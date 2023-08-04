import rospy
import signal
from yumi_task_msgs.msg import YuMiTask, TaskStatus
from twisted.internet import protocol, reactor, defer, endpoints
from twisted.protocols import basic


class YuMiROSNode:
    def __init__(self):
        rospy.init_node('yumi_bridge', anonymous=True)
        rospy.Subscriber('yumi/task', YuMiTask, self._ros_task_callback)
        self._status_pub = rospy.Publisher('yumi/status', TaskStatus, queue_size=1)
        self._current_seq_cmd = 0
        self._current_task_name = ''
        self._current_task_status = TaskStatus.ERROR
        self._fwd_msg_cb = None
        
        rospy.sleep(0.5) # to start subscribers and publishers
        self._timer = rospy.Timer(rospy.Duration(1), self._ros_task_status_update)
        rospy.loginfo('started YuMi Node')     

    def _ros_task_callback(self,msg):
        if msg.cmd_seq > self._current_seq_cmd:
            rospy.loginfo(f'received task message: {msg.task_name} with cmd_seq: {msg.cmd_seq}')
            self._current_task_name = msg.task_name
            self._current_task_status = TaskStatus.EXECUTING
            self._current_seq_cmd += 1
            self._forward_task_msg(self._current_task_name)
        else:
            rospy.logwarn('message ignored!!! it has a repeated cmd_seq')

    def _ros_task_status_update(self, event=None):
        msg = TaskStatus()
        msg.cmd_seq = self._current_seq_cmd
        msg.task_name = self._current_task_name
        msg.task_state = self._current_task_status
        self._status_pub.publish(msg)

    def complete_task_execution(self, success):
        if success:
            self._current_task_status = TaskStatus.FINISHED
        else:
            self._current_task_status = TaskStatus.ERROR

    def set_forward_msg_cb(self, cb_func):
        self._fwd_msg_cb = cb_func

    def _forward_task_msg(self, task_name):
        if self._fwd_msg_cb is not None:
            self._fwd_msg_cb(task_name)
        else:
            pass

class YuMiForwardPolicy(basic.LineReceiver):
    def connectionMade(self):
        self.setRawMode()
        address = self.transport.getPeer()
        print(f'YuMi client connected on {address}')

    def rawDataReceived(self, data):
        msg = data.decode('utf-8')
        print(f'received -> {msg}')
        if msg == 'task_done':
            self.factory.complete_task_execution_cb(True)
        else:
            self.factory.complete_task_execution_cb(False)
            print('Task execution failed')

    def connectionLost(self, reason):
        print('YuMi client disconnected!!!')

    def forward_msg(self, msg):
        msg = msg.encode('ascii')
        self.sendLine(msg)

class YuMiForwardPolicyFactory(protocol.ServerFactory):
    protocol = YuMiForwardPolicy
    
    def __init__(self) -> None:
        self._ros_node = YuMiROSNode()
        self._ros_node.set_forward_msg_cb(self.forward_msg_cb)

    def buildProtocol(self, addr):
        self.active_protocol = super().buildProtocol(addr)
        return self.active_protocol

    def forward_msg_cb(self, msg):
        self.active_protocol.forward_msg(msg)

    def complete_task_execution_cb(self, no_error):
        self._ros_node.complete_task_execution(no_error)


if __name__ == '__main__':
    PORT = 1031
    HOST = '172.31.1.191' #'192.168.0.101'
    yumi_server = endpoints.serverFromString(reactor,f'tcp:{PORT}:interface={HOST}')

    try:
        yumi_server.listen(YuMiForwardPolicyFactory())
        signal.signal(signal.SIGINT, signal.default_int_handler)
        reactor.run()
    finally:
        rospy.loginfo('server is terminated')
