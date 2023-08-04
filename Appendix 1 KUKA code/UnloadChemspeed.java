// Calibrate
		if (needCalibration)
		{
			logger.info("Performing 6P calibration at ChemSpeedLDStation");
			commander.getArm().moveToolPTP("/ChemSpeedLDStation/Pre_Cube_Pos", "/spacer/tcp", 0.3);
			commander.PerformSixPointCalibration("ChemSpeedLDStation", true);
		}
		
		// Get into the chemspeed workspace and pick the rack
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/RotStart", "/spacer/tcp", 0.3);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/RotEnd", "/spacer/tcp", 0.3);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Cube_Corner/CSViaPoint", "/spacer/tcp", 0.3);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Cube_Corner/CSPreHome", "/spacer/tcp", 0.3);
		commander.getArm().moveToolLIN("/ChemSpeedLDStation/Cube_Corner/CSHome", "/spacer/tcp", 200);
		rackHandling.pickupRack(jobRack, GripperPos.HALF_OPEN);
		commander.getArm().moveToolLIN("/ChemSpeedLDStation/Cube_Corner/Racks/Pre_Rack" + Integer.toString(rackNum), "/spacer/tcp", 50);
		
		// Retreat back from the Chemspeed
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Cube_Corner/CSHome", "/spacer/tcp", 0.075);
		commander.getArm().moveToolLIN("/ChemSpeedLDStation/Cube_Corner/CSPreHome", "/spacer/tcp", 50);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Cube_Corner/CSViaPoint", "/spacer/tcp", 0.075);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/RotEnd", "/spacer/tcp", 0.075);
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/RotStart", "/spacer/tcp", 0.075);
		
		// Place the rack on deck
		commander.getArm().moveToolPTP("/ChemSpeedLDStation/Move_Frames/DeckViaPoint", "/spacer/tcp", 0.075);
		ObjectFrame robotRackFrame = applicationData.getFrame("/RobotRacks/DeckRack" + Integer.toString(rackNum));
		rackHandling.placeRack(jobRack, robotRackFrame);
		
		// Back to drive position
		commander.getArm().moveArmToDrivePos(0.3);
