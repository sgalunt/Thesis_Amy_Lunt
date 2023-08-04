
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
		
		// Close left door
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Start_Pos", "/spacer/tcp", 0.2);
		commander.getGripper().open(); 
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Left_Door/Close_PreGrasp_Pos", "/spacer/tcp", 0.2);
		logger.info("Approaching left door handle");
		commander.getArm().moveToolLIN("/PXRDStation/Cube_Corner/Left_Door/Close_Grasp_Pos", "/spacer/tcp", 25);
		commander.getGripper().moveToPos(GripperPos.HALF_OPEN);
		commander.getArm().moveLINWithImpedance("/PXRDStation/Cube_Corner/Left_Door/Close_Via_Pos", "/spacer/tcp", 15, impedanceConfig);
		commander.getArm().moveLINWithImpedance("/PXRDStation/Cube_Corner/Left_Door/Close_Pos", "/spacer/tcp", 10, impedanceConfig);
		commander.getArm().moveLINRelSensitively(30,30, 15, CoordinateAxis.X, CollisionBehvaior.STOP_AT_COLLISION);
		logger.info("Done closing left door. Retreating");
		commander.getGripper().open();
		commander.getArm().moveToolLIN("/PXRDStation/Cube_Corner/Left_Door/Close_Retreat_Pos", "/spacer/tcp", 15);
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Start_Pos", "/spacer/tcp", 0.2);
		
		// Close right door
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Start_Pos", "/spacer/tcp", 0.2);
		commander.getGripper().open();
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Right_Door/Close_PreGrasp_Pos", "/spacer/tcp", 0.2);
		logger.info("Approaching right door handle");
		commander.getArm().moveToolLIN("/PXRDStation/Cube_Corner/Right_Door/Close_Grasp_Pos", "/spacer/tcp", 25);
		commander.getGripper().moveToPos(GripperPos.HALF_OPEN);
		commander.getArm().moveLINWithImpedance("/PXRDStation/Cube_Corner/Right_Door/Close_Via_Pos" , "/spacer/tcp", 15, impedanceConfig);
		commander.getArm().moveLINWithImpedance("/PXRDStation/Cube_Corner/Right_Door/Close_Pos", "/spacer/tcp", 10, impedanceConfig);
		commander.getArm().moveLINRelSensitively(-30, 30, 15, CoordinateAxis.X, CollisionBehvaior.STOP_AT_COLLISION);
		logger.info("Done closing right door. Retreating");
		commander.getGripper().open();
		commander.getArm().moveToolLIN("/PXRDStation/Cube_Corner/Right_Door/Close_Retreat_Pos", "/spacer/tcp", 25);
		commander.getArm().moveToolPTP("/PXRDStation/Cube_Corner/Start_Pos", "/spacer/tcp", 0.2);
		commander.getArm().moveArmToDrivePos(0.2);
	}
}
