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
		
		
		// Pick up EightWRack from deck 
		
		rackHandling.setPtpVelocity(0.2);
		commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 0.3);
		commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Pre_Racks", "/spacer/tcp", 200);
		rackHandling.pickupRack(jobRack, GripperPos.HALF_OPEN);
		
		// Move EightWRack to bench
		commander.getArm().moveToolLIN("/RobotRacks/PreDeckRack1", "/spacer/tcp", 50);
		commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 50);
		commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Pre_Racks", "/spacer/tcp", 50);
		commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Rack_Move_Mid", "/spacer/tcp", 50);
		commander.getArm().moveToolLIN("/LightboxStation/StartCalibrationPos", "/spacer/tcp", 50);
		ObjectFrame robotRH1Frame = applicationData.getFrame("/LightboxStation/Cube_Corner/BenchRacks/Rack_1");
		rackHandling.placeRack(jobRack, robotRH1Frame);
		commander.getArm().moveToolLIN("/LightboxStation/StartCalibrationPos", "/spacer/tcp", 200);
		commander.getArm().moveToolLIN("/LightboxStation/Move_Frames/Rack_Move_Mid", "/spacer/tcp", 200);
		commander.getArm().moveToolPTP("/LightboxStation/Move_Frames/Deck_Home", "/spacer/tcp", 0.3);
		
		
		commander.getArm().moveArmToDrivePos(0.2);
