MODULE MainModule
    CONST string SERVER_IP_ADDRR := "172.31.1.191";
    CONST num SERVER_PORT := 1031;
    
    VAR socketdev server_socket;
    VAR socketstatus socket_stat;
    VAR string server_ip;
    VAR num retry_no := 0;
    VAR string server_msg;
    VAR string task_name;
    VAR num new_line_pos;
    
    
    PERS bool server_connected;
    PERS string current_task;
    PERS bool task_complete;
    
    PROC ConnectToServer()
        SocketCreate server_socket;
        TPWrite "Attempting to connect to the server";
        SocketConnect server_socket, SERVER_IP_ADDRR, SERVER_PORT;
        
        socket_stat := SocketGetStatus(server_socket);
        
        IF socket_stat = SOCKET_CONNECTED THEN
            TPWrite "Connected to the server";
            server_connected := TRUE;
        ELSE
            TPWrite "Failed to connect to the server";
        ENDIF
        
        ERROR
            IF ERRNO = ERR_SOCK_TIMEOUT THEN
                IF retry_no < 5 THEN
                    WaitTime 1;
                    retry_no := retry_no + 1;
                    RETRY;
                ELSE
                    RAISE;
                ENDIF
            ENDIF
    ENDPROC
    
    PROC main()
        server_connected := FALSE;
        current_task := "";
        ConnectToServer;
        
        WHILE server_connected DO
            SocketReceive server_socket \Str:= server_msg \Time:=WAIT_MAX;
            task_complete := FALSE;
            new_line_pos := Strmatch(server_msg,1,"\0D");
            TPWrite "found at: " \Num:= new_line_pos;
            task_name := StrPart(server_msg,1, new_line_pos - 1);
            TPWrite "Got a task message from Server: " + task_name;
            current_task := task_name;
            WaitUntil task_complete;
            ! send response back
            SocketSend server_socket \Str:= "task_done";
            server_msg := "";
        ENDWHILE
        
    ENDPROC
ENDMODULE