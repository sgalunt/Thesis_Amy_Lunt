
	
	public void run() throws Exception{	
		// create impedance control mode
		int[] stiffnessArray = {2000,2000,2000,150,300,300};
		CartesianImpedanceControlMode impedanceConfig = commander.getArm().createCartesianImpedanceConfig(stiffnessArray);
		
		// Calibrate
		if (needCalibration)
		{
			logger.info("Performing 6P calibration at PXRD station");
			commander.getArm().moveToolPTP("/PXRDStation/Pre_Cube_Pos", "/spacer/tcp", 0.3);
			commander.PerformSixPointCalibration("PXRDStation", false);
		}
		
		// Open right door
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Start_Pos", "/spacer/tcp", 0.3);
		commander.getGripper().open();
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Right_Door/Open_PreGrasp_Pos", "/spacer/tcp", 0.2);
		logger.info("Approaching right door handle");
		commander.getArm().moveToolLIN("/PXRDStation/Cube_Corner/Right_Door/Open_Grasp_Pos", "/spacer/tcp", 25);
		
		commander.getGripper().moveToPos(GripperPos.HALF_OPEN);
		commander.getArm().moveLINWithImpedance("/PXRDStation/Cube_Corner/Right_Door/Open_Via_Pos", "/spacer/tcp", 15, impedanceConfig);
		commander.getArm().moveLINWithImpedance("/PXRDStation/Cube_Corner/Right_Door/Open_Pos", "/spacer/tcp", 10, impedanceConfig);
		logger.info("Done opening right door. Retreating");
		commander.getGripper().open();
		commander.getArm().moveToolLIN("/PXRDStation/Cube_Corner/Right_Door/Open_Retreat_Pos", "/spacer/tcp", 25);
		
		// Open left door
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Start_Pos", "/spacer/tcp", 0.2);
		commander.getGripper().open();
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Left_Door/Open_PreGrasp_Pos", "/spacer/tcp", 0.2);
		logger.info("Approaching left door handle");
		commander.getArm().moveToolLIN("/PXRDStation/Cube_Corner/Left_Door/Open_Grasp_Pos", "/spacer/tcp", 25);
		commander.getGripper().moveToPos(GripperPos.HALF_OPEN);
		commander.getArm().moveLINWithImpedance("/PXRDStation/Cube_Corner/Left_Door/Open_Via_Pos",  "/spacer/tcp", 15, impedanceConfig);
		commander.getArm().moveLINWithImpedance("/PXRDStation/Cube_Corner/Left_Door/Open_Pos",  "/spacer/tcp", 10, impedanceConfig);
		logger.info("Done opening left door. Retreating");
		commander.getGripper().open();
		commander.getArm().moveToolLIN("/PXRDStation/Cube_Corner/Left_Door/Open_Retreat_Pos", "/spacer/tcp", 25);
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Start_Pos", "/spacer/tcp", 0.2);
		commander.getArm().moveArmToDrivePos(0.2);
	}
}
