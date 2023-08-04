    // Calibrate
		if (needCalibration)
		{
			logger.info("Performing 6P calibration at ChemSpeedLDStation");
			commander.getArm().moveToolPTP("/ChemSpeedLDStation/Pre_Cube_Pos", "/spacer/tcp", 0.3);
			commander.PerformSixPointCalibration("ChemSpeedLDStation", true);
		}
		
		// Pick the rack and place in Chemspeed
		commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Pre_Racks", "/spacer/tcp", 0.3);
		rackHandling.pickupRack(jobRack, GripperPos.HALF_OPEN);
		
		// Place the rack inside the Chemspeed
		commander.getArm().moveToolLIN("/RobotRacks/PreDeckRack" + Integer.toString(rackNum), "/spacer/tcp", 50);
		commander.getArm().moveToolLIN("/ChemSpeedLDStation/Move_Frames/DeckViaPoint", "/spacer/tcp", 50);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/RotStart", "/spacer/tcp", 0.075);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/RotEnd", "/spacer/tcp", 0.075);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Cube_Corner/CSViaPoint", "/spacer/tcp", 0.075);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Cube_Corner/CSPreHome", "/spacer/tcp", 0.075);
		commander.getArm().moveToolLIN("/ChemSpeedLDStation/Cube_Corner/CSHome", "/spacer/tcp", 50);
		commander.getArm().moveToolLIN("/ChemSpeedLDStation/Cube_Corner/Racks/Pre_Rack" + Integer.toString(rackNum), "/spacer/tcp", 50);
		ObjectFrame robotRackFrame = applicationData.getFrame("/ChemSpeedLDStation/Cube_Corner/Racks/Rack" + Integer.toString(rackNum));
		rackHandling.placeRack(jobRack, robotRackFrame);
		
		// Retreat back to the home position
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Cube_Corner/CSHome", "/spacer/tcp", 0.3);
		commander.getArm().moveToolLIN("/ChemSpeedLDStation/Cube_Corner/CSPreHome", "/spacer/tcp", 200);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Cube_Corner/CSViaPoint", "/spacer/tcp", 0.3);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/RotEnd", "/spacer/tcp", 0.3);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/RotStart", "/spacer/tcp", 0.3);
		commander.getArm().moveArmToDrivePos(0.3);
