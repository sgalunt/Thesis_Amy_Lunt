package crystalBot.tasks.inputStation;

import robotChemist.interfaces.GenericTwoFingerGripper.GripperPos;
import robotChemist.interfaces.LBRCommander;
import robotChemist.tasks.RackHandling;
import robotChemist.utility.Rack;

import com.kuka.roboticsAPI.applicationModel.IApplicationData;
import com.kuka.roboticsAPI.geometricModel.ObjectFrame;
import com.kuka.roboticsAPI.geometricModel.Workpiece;
import com.kuka.task.ITaskLogger;

public class PlacePXRDRack
{
	private LBRCommander commander;
	private RackHandling rackHandling;
	private ITaskLogger logger;
	private IApplicationData applicationData;
	private Rack jobRack;
	private boolean needCalibration;

	
	public PlacePXRDRack(LBRCommander commander, Workpiece rack, RackHandling rackHandling, boolean needCalibration, IApplicationData applicationData,ITaskLogger logger)
	{
		this.commander = commander;
		this.rackHandling = rackHandling;
		this.applicationData = applicationData;
		this.logger = logger;
		ObjectFrame rackFrame = applicationData.getFrame("/RobotRacks/CrystalWorkflow/PXRDRack_Rack1");
		this.jobRack = new Rack(rack,rackFrame);
		this.needCalibration = needCalibration;
	}
	
	public void run() throws Exception{
		
		// Calibration 
				if (needCalibration)
				{
					logger.info("Performing 6P calibration at InputStation");
					commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Rack_Move_Mid", "/spacer/tcp", 0.3);
					commander.getArm().moveToolLIN("/LightboxStation/StartCalibrationPos", "/spacer/tcp", 200);
					commander.PerformSixPointCalibration("LightboxStation", false);
					commander.getArm().moveToolLIN("/LightboxStation/StartCalibrationPos", "/spacer/tcp", 200);
					commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Rack_Move_Mid", "/spacer/tcp", 200);
					commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 0.3);
				}
				
				
				// Pick up PXRDRack from deck 
				rackHandling.setPtpVelocity(0.2);
				commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 0.3);
				commander.getArm().moveToolLIN("/RobotRacks/CrystalWorkflow/PXRD_PreRack1", "/spacer/tcp", 50);
				rackHandling.pickupRack(jobRack, GripperPos.HALF_OPEN);
				
				// Move PXRDRack to bench
				commander.getArm().moveToolLIN("/RobotRacks/CrystalWorkflow/PXRD_PreRack1", "/spacer/tcp", 200);
				commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 50);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRDRack_Via3", "/spacer/tcp", 0.3);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRDRack_Via2", "/spacer/tcp", 0.3);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRDRack_Via1", "/spacer/tcp", 0.3);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRD_PreRack1", "/spacer/tcp", 0.3);
				ObjectFrame robotRH1Frame = applicationData.getFrame("/LightboxStation/Cube_Corner/BenchRacks/PXRD_Rack1");
				rackHandling.placeRack(jobRack, robotRH1Frame);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRD_PreRack1", "/spacer/tcp", 0.3);
				commander.getArm().moveToolLIN("/LightboxStation/StartCalibrationPos", "/spacer/tcp", 200);
				commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Rack_Move_Mid", "/spacer/tcp", 200);
				commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 0.3);
				commander.getArm().moveArmToDrivePos(0.2);
			}
		}