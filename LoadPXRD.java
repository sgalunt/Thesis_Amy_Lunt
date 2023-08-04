package crystalBot.tasks.pxrd;

import robotChemist.interfaces.GenericTwoFingerGripper.GripperPos;
import robotChemist.interfaces.LBRCommander;
import com.kuka.roboticsAPI.applicationModel.IApplicationData;
import com.kuka.task.ITaskLogger;

public class LoadPXRD 
{
	private LBRCommander commander;
	private ITaskLogger logger;
	private IApplicationData applicationData;
	private boolean needCalibration;

	
	public LoadPXRD(LBRCommander commander, boolean needCalibration, IApplicationData applicationData, ITaskLogger logger)
	{
		this.commander = commander;
		this.applicationData = applicationData;
		this.logger = logger;
		this.needCalibration = needCalibration;
	}
	
	public void run() throws Exception{	
		// Calibrate
		if (needCalibration)
		{
			logger.info("Performing 6P calibration at PXRD loading station");
			commander.getArm().moveToolPTP("/PXRDLoadingStation/Pre_Cube_Pos", "/spacer/tcp", 0.3);
			commander.PerformSixPointCalibration("PXRDLoadingStation", false);
		}
		
		// Grasp Rack
		logger.info("Picking up the rack from the deck");
		commander.getArm().moveToolPTP("/PXRDLoadingStation/PreGrasp", "/spacer/tcp", 0.2);
		commander.getGripper().moveToPos(GripperPos.HALF_OPEN);
		commander.getArm().moveToolLIN("/RobotRacks/Rack1/PXRDRack", "/spacer/tcp", 25);
		commander.getGripper().invGraspWithForce((Integer) applicationData.getProcessData("openForceRack").getValue());
		
		// Moving towards loading
		commander.getArm().moveToolLIN("/PXRDLoadingStation/PreGrasp", "/spacer/tcp", 25);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint1", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint2", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint3", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint4", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint5", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint6", "/spacer/tcp", 0.2);
		
		// Loading
		logger.info("Load the rack into the PXRD");
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadingStart", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadingMidWay", "/spacer/tcp", 0.2);
		commander.getArm().moveToolLIN("/PXRDLoadingStation/Cube_Corner/PreLoading", "/spacer/tcp", 25);
		commander.getArm().moveToolLIN("/PXRDLoadingStation/Cube_Corner/LoadingPos", "/spacer/tcp", 7);
		commander.getGripper().moveToPos(GripperPos.CLOSE);
		
		// Taking the arm off the PXRD
		logger.info("Retreating from the PXRD");
		commander.getArm().moveToolLIN("/PXRDLoadingStation/Cube_Corner/PreLoading", "/spacer/tcp", 25);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadingMidWay", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadingStart", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint6", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint5", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint4", "/spacer/tcp", 0.2);
		commander.getArm().moveToolPTP("/PXRDLoadingStation/Cube_Corner/LoadWayPoint3", "/spacer/tcp", 0.2);
		commander.getArm().moveArmToDrivePos(0.2);
	}
}
