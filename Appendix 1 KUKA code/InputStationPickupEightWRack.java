  //Calibrate
		if (needCalibration)
		{
			logger.info("Performing 6P calibration at InputStation");
			commander.PerformSixPointCalibration("LightboxStation", false);
		}
		
		// Pick up EightWRack from station and place on kuka deck 
		rackHandling.setPtpVelocity(0.2);
		rackHandling.pickupRack(jobRack, GripperPos.HALF_OPEN);
		commander.getArm().moveToolLIN("/LightboxStation/StartCalibrationPos", "/spacer/tcp", 50);
		commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Rack_Move_Mid", "/spacer/tcp", 50);
		commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 0.075);
		commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Pre_Racks", "/spacer/tcp", 50);
		ObjectFrame robotRH1Frame = applicationData.getFrame("/RobotRacks/DeckRack1");
		rackHandling.placeRack(jobRack, robotRH1Frame);
		commander.getArm().moveArmToDrivePos(0.3);
