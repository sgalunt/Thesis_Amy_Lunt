
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
