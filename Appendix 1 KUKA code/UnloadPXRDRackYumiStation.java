
			// Calibration at YumiStation
			
			if (needCalibration)
			{
				logger.info("Performing 6P calibration at YumiStation");
				commander.getArm().moveToolPTP("/YumiStation/Move_Frames/DeckViaPoint", "/spacer/tcp", 0.3);
				commander.getArm().moveToolPTP("/YumiStation/Move_Frames/Station_Apr", "/spacer/tcp", 0.3);
				commander.getArm().moveToolLIN("/YumiStation/Pre_Cube_Pos", "/spacer/tcp", 200);
				commander.PerformSixPointCalibration("YumiStation", false);
				commander.getArm().moveToolLIN("/YumiStation/Pre_Cube_Pos", "/spacer/tcp", 200);
				commander.getArm().moveToolPTP("/YumiStation/Move_Frames/Station_Apr", "/spacer/tcp", 0.3);
				}
			
		// Pick up PXRD Rack 1 from YumiStation
		
			logger.info("Picking up the PXRD rack from the YumiStation");
			commander.getArm().moveToolPTP("/YumiStation/Cube_Corner/PXRD_PreRack1", "/spacer/tcp", 0.3);
			commander.getGripper().moveToPos(GripperPos.HALF_OPEN);
			commander.getArm().moveToolPTP("/YumiStation/Cube_Corner/PXRD_Rack1", "/spacer/tcp", 0.3);
			commander.getGripper().invGraspWithForce((Integer) applicationData.getProcessData("openForceRack").getValue());
				

		// Move and place PXRD Rack1 to KUKA deck
			
			commander.getArm().moveToolPTP("/YumiStation/Cube_Corner/PXRD_PreRack1", "/spacer/tcp", 0.3);
			commander.getArm().moveToolPTP("/YumiStation/Move_Frames/Station_Apr", "/spacer/tcp", 0.3);
			commander.getArm().moveToolPTP("/YumiStation/Move_Frames/DeckViaPoint", "/spacer/tcp", 0.3);
			commander.getArm().moveToolPTP("/RobotRacks/CrystalWorkflow/PXRD_PreRack1", "/spacer/tcp", 0.2);
			commander.getArm().moveToolLIN("/RobotRacks/CrystalWorkflow/PXRD_Rack1", "/spacer/tcp", 25);
			commander.getGripper().moveToPos(GripperPos.HALF_OPEN);
			commander.getArm().moveToolPTP("/YumiStation/Cube_Corner/PXRD_PreRack1", "/spacer/tcp", 0.3);
			commander.getArm().moveToolPTP("/YumiStation/Move_Frames/Station_Apr", "/spacer/tcp", 0.3);
			commander.getArm().moveToolPTP("/YumiStation/Move_Frames/DeckViaPoint", "/spacer/tcp", 0.3);
			commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 0.3);
			
			
			commander.getArm().moveArmToDrivePos(0.2);
		}
	}
