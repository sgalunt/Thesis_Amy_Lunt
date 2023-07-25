//Calibrate
				
				if (needCalibration)
				{
					logger.info("Performing 6P calibration at InputStation");
					commander.PerformSixPointCalibration("LightboxStation", false);
				}
				
		// Pick up PXRDRack from bench and place on kuka deck 
				rackHandling.setPtpVelocity(0.2);
				rackHandling.pickupRack(jobRack, GripperPos.HALF_OPEN);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRD_PreRack1", "/spacer/tcp", 0.3);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRDRack_Via1", "/spacer/tcp", 0.3);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRDRack_Via2", "/spacer/tcp", 0.3);
				commander.getArm().moveToolPTP("/LightboxStation/Cube_Corner/BenchRacks/PXRDRack_Via3", "/spacer/tcp", 0.3);
				commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 0.075);
				commander.getArm().moveToolLIN("/RobotRacks/CrystalWorkflow/PXRD_PreRack1", "/spacer/tcp", 50);
				ObjectFrame robotRH1Frame = applicationData.getFrame("/RobotRacks/CrystalWorkflow/PXRD_Rack1");
				rackHandling.placeRack(jobRack, robotRH1Frame);
				commander.getArm().moveArmToDrivePos(0.3);
