MODULE CrystalBotL
    
    PERS bool server_connected;
    PERS string current_task;
    PERS bool task_complete;
    PERS bool left_arm_done; 
    PERS bool right_arm_done;
    
    PROC main()
        TPErase;
        TPWrite "starting the program";
        left_arm_done := TRUE;
        executeRemoteTasks;
        
    ENDPROC
    
    PROC executeRemoteTasks()
        current_task := "";
        WaitUntil server_connected;
        
        WHILE server_connected DO
            TEST current_task
            CASE "loadIKAPlate": !move vials from Chemspeed rack to Stir plate
                TPWrite "Left arm executing loadIKAPlate";
                loadIKAPlate;
                current_task := "";
                task_complete := TRUE;
                TPWrite "Left arm finished executing loadIKAPlate";
            CASE "invertAndLoadShakerPlate": !move and invert vials from stir plate to Shaker plate
                TPWrite "Left arm executing invertAndLoadShakerPlate";
                invertAndLoadShakerPlate;
                current_task := "";
                task_complete := TRUE;
                TPWrite "Left arm finished executing invertAndLoadShakerPlate";
            CASE "invertAndLoadWellPlate": !move and invert vials from shaker plate to Well plate rack
                TPWrite "Left arm executing invertAndLoadWellPlate";
                invertAndLoadWellPlate;
                current_task := "";
                task_complete := TRUE;
                TPWrite "Left arm finished executing invertAndLoadWellPlate";
            CASE "unscrewCaps": ! unscrew caps and load well plate rack
                TPWrite "Left arm executing unscrewCaps";
                unscrewCaps;
                current_task := "";
                task_complete := TRUE;
                TPWrite "Left arm finished executing unscrewCaps";
            DEFAULT:
                WaitTime 0.5;
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC LhomePos()
	MoveAbsJ [[0,-130,30,0,40,0],[135,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
	ENDPROC
	PROC LcamCalib()
	MoveJ [[439.09,273.63,286.84],[0.50907,-0.490757,0.50908,-0.490758],[-1,0,0,5],[115.735,9E+09,9E+09,9E+09,9E+09,9E+09]], v1000, z50, GripperLeft;
	ENDPROC
    PROC OpenGripper()
    g_GripOut \holdForce:=10;
    ENDPROC
    PROC CloseGripper()
    g_GripIn \holdForce:=7;
    ENDPROC
    

    
     PROC loadIKAPlate ()
    ! code move vials from Chemspeed rack to Stir plate   
    ChemspeedRack;
    right_arm_done := FALSE;
     ENDPROC
     
     PROC invertAndLoadShakerPlate ()
    ! code to move and invert vials from stir plate to Shaker plate
    STRSHKL;
    AddShakerLid;
    right_arm_done := FALSE;
     ENDPROC
     
     PROC invertAndLoadWellPlate ()
    ! code to move and invert vials from shaker plate to Well plate rack
    RemoveShakerLid;
    LoadRack;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Uncap;
     ENDPROC
    
    PROC unscrewCaps ()
    ! code to unscrew caps and load well plate rack
    !Uncap;
    OpenGripper;
    ENDPROC
    
    PROC AddShakerLid()
    ! add shaker lid with left arm only
    MoveAbsJ [[-45.9063,-143.377,40.7297,2.54252,13.7156,60.5708],[71.4443,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-57.8603,-132.265,39.7813,-26.4646,-76.7922,28.5586],[69.7831,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-63.7462,-132.262,27.0223,-24.7858,-69.1512,30.0948],[70.3962,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-58.1593,-132.263,48.5557,-31.74,-87.5381,25.7972],[64.8393,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-10.9964,-122.515,59.7444,-73.9861,-77.983,37.7827],[61.6139,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-17.0377,-107.278,18.516,-90.1457,-64.0567,69.1733],[59.7552,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-24.2874,-107.278,13.2686,-84.8327,-56.4411,68.4029],[65.3874,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-24.775,-107.294,13.1033,-83.7847,-57.5767,67.3706],[64.69,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-24.744,-107.278,14.3493,-84.4284,-72.6293,67.499],[51.4624,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-24.7352,-107.288,30.9071,-64.376,28.4772,82.9469],[63.4698,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-42.5212,-134.607,37.473,-52.2278,31.2563,116.039],[90.9591,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    ENDPROC
    
    PROC RemoveShakerLid()
    !after shaking remove shaker lid
    MoveAbsJ [[-56.3805,-134.486,50.9376,-33.8612,-86.7028,81.8022],[60.2646,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-11.0907,-134.479,67.051,-63.0813,-80.4402,88.2498],[67.6205,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-29.5283,-115.807,16.8334,-79.3255,-74.5688,118.259],[49.2153,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-29.4569,-114.836,15.827,-73.7957,-64.7636,114.204],[57.3777,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-29.4535,-114.836,21.1373,-79.8181,-87.0304,113.84],[36.4933,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-29.5323,-114.779,71.4739,-67.9587,-85.9268,60.3008],[52.4545,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-56.055,-114.777,29.9859,-27.8625,-60.0655,60.598],[84.3688,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-56.1144,-114.778,28.2458,-27.9467,-57.5383,61.1266],[85.0552,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-56.0588,-114.777,41.2923,-28.6957,-73.5783,61.1164],[78.1265,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-51.0711,-143.388,39.9122,-11.9242,10.5907,78.7484],[73.2232,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    ENDPROC
    
    PROC ChemspeedRack()
    OpenGripper;
    !move vials from chemspeed rack to stir plate
    !vial 1
    MoveAbsJ [[-78.3407,-107.282,49.922,136.076,105.977,-134.16],[56.636,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-75.4646,-93.1245,33.7683,143.792,81.9507,-178.191],[76.0764,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-70.7371,-93.1248,45.3594,137.225,89.5397,-176.928],[68.6274,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-70.7411,-93.2006,48.5441,130.958,96.0909,-180.04],[60.9535,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-55.8702,-111.602,22.0911,118.689,89.5363,-99.3627],[30.8812,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-55.8731,-111.603,19.7513,116.931,90.4848,-99.3627],[32.8688,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-55.8752,-111.602,19.2312,119.947,86.6992,-99.2895],[36.5505,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-55.8722,-111.602,22.078,113.205,97.6824,-96.44],[25.6439,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    
    !vial 2 
    MoveAbsJ [[-55.9372,-70.5378,39.1649,119.521,63.9812,-152.485],[70.9836,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-66.6258,-70.5382,27.5782,133.05,55.7517,-154.832],[86.0086,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-61.4881,-70.5377,35.6012,128.998,61.5539,-154.855],[79.2384,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-35.5932,-75.5518,10.1996,87.6044,59.9892,-84.2041],[56.795,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-44.7262,-75.5412,1.55804,90.8768,60.8082,-83.5886],[62.0141,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-44.7295,-75.5414,1.5587,90.8985,57.1568,-83.672],[64.3773,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-31.7104,-75.5414,10.5829,81.7407,64.5726,-81.3968],[53.2762,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    
    !vial 3
    MoveAbsJ [[-64.5002,-55.0333,31.5313,111.071,61.1769,-167.462],[74.3898,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-77.2085,-55.0332,20.6233,123.868,54.1983,-193.48],[92.4166,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-62.7428,-55.0331,35.09,114.273,64.0194,-189.265],[72.8336,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-30.6759,-55.0516,11.1996,73.1693,34.4951,-117.019],[74.7942,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-35.7887,-55.0523,9.01748,73.9355,29.3379,-112.471],[83.235,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-19.7828,-55.0523,18.8129,69.9032,36.6352,-112.488],[68.4834,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    
    !vial 4 
    MoveAbsJ [[-67.7759,-55.0141,20.8647,113.581,54.2863,-147.225],[82.1057,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-71.6844,-55.0141,18.4402,122.597,46.3393,-156.933],[92.2792,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-61.6664,-55.0142,28.7774,117.151,53.5917,-156.588],[79.2551,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-16.3998,-55.0274,25.1725,72.3973,26.1771,-115.665],[74.1497,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-32.1148,-55.0278,14.5432,72.144,22.3462,-115.076],[87.6448,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    
    !vial 5 
    MoveAbsJ [[-13.1204,-55.0279,26.5953,68.008,25.339,-114.604],[72.8443,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-68.5135,-55.0076,19.4257,99.6278,78.6714,-186.947],[54.9862,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-90.3345,-84.4168,16.7725,132.93,88.4664,-160.641],[59.2508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-94.3132,-84.4133,6.50029,133.288,85.1,-158.162],[63.332,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-92.7914,-84.4185,19.7203,130.006,103.154,-161.085],[50.7599,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-47.6538,-87.881,24.9446,100.982,84.1938,-113.28],[38.8098,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-27.7349,-88.0275,22.1416,92.0905,60.2602,-96.0004],[58.5078,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-25.6571,-87.9927,23.4049,88.5732,55.6175,-94.0224],[62.5958,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-33.1286,-87.9927,18.4458,96.0497,53.0767,-83.7032],[67.578,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-33.9573,-87.9923,18.3152,98.7639,50.8171,-84.2005],[68.8541,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    
    !vial 6 
    MoveAbsJ [[-22.2811,-87.9923,26.6238,88.3488,57.9104,-79.6192],[58.5766,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-75.0214,-67.8565,16.0256,107.76,86.1834,-151.043],[52.6789,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-86.4558,-67.8572,1.32139,119.906,70.7606,-133.71],[74.8598,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-77.6191,-67.8572,14.8243,113.524,82.0727,-133.72],[60.7351,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-35.2617,-67.9054,1.07574,79.1296,66.2893,-74.2724],[51.42,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-13.4382,-67.9543,13.8153,62.9457,47.2125,-51.811],[66.8093,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-29.7635,-67.9532,6.62081,69.9811,32.8173,-58.118],[81.7213,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-32.7191,-67.9538,3.82957,70.5509,36.5081,-29.6298],[81.8381,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    
    !vial 7 
    MoveAbsJ [[-17.4019,-67.9532,14.3444,68.5547,42.8483,-29.6923],[69.8893,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-15.1774,-67.9641,10.6849,59.6736,47.5,-19.0758],[65.7701,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-79.0307,-67.8681,14.8958,111.061,87.2451,-112.985],[52.7371,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-96.4906,-67.8826,-5.49628,125.261,72.0259,-175.531],[75.7122,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-91.6843,-67.8817,2.69391,121.853,77.9621,-175.532],[68.5396,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-91.6879,-67.882,8.16879,118.255,96.2274,-173.319],[53.7527,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-58.3233,-67.0524,-10.6565,94.4612,72.4998,-84.5804],[49.1531,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-58.3529,-69.1276,-50.2151,77.393,72.0193,-30.9725],[52.0559,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-33.802,-69.1284,-3.94859,63.7733,41.415,-62.5678],[75.1277,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-37.2854,-69.129,-6.16662,63.6508,39.9617,-133.465],[79.8806,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    
    !vial 8 
    MoveAbsJ [[-28.9236,-69.1279,-2.05169,64.3472,52.7075,-132.195],[68.7977,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-25.0117,-69.1289,-2.11568,64.3506,62.0995,-132.164],[60.6632,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-53.3716,-47.5651,12.5979,84.6903,69.2182,-228.543],[52.7966,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-93.8784,-48.1044,-15.3948,95.6253,49.4952,-158.957],[97.5357,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-81.3534,-48.1018,-2.59441,97.5794,60.895,-162.956],[78.5681,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-64.9554,-48.1377,-43.0583,56.5151,56.2885,-82.1289],[83.4387,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-41.4351,-43.9783,-13.036,23.3569,34.3171,-36.0213],[100.759,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-45.8318,-44.0516,-14.3587,23.6614,31.2799,-36.9262],[105.357,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-21.8634,-44.0282,-9.29755,26.2849,48.248,-36.9496],[81.7905,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-35.3311,-105.681,36.3761,94.1214,92.2528,-121.022],[29.0136,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    MoveAbsJ [[-56.0638,-135.608,40.2051,90.2231,-6.67731,-36.9183],[63.6879,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
    ENDPROC
    
    PROC Uncap()
    !right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    GraspVialSide;
    WaitRob \ZeroSpeed;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    BinVial;
    Rerack1;
    GraspCap;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    Cap1;
    
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    GraspVialSide;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    BinVial;
    Rerack2;
    GraspCap;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    Cap2;
    
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    GraspVialSide;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    BinVial;
    Rerack3;
    GraspCap;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    Cap3;
    
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    GraspVialSide;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    BinVial;
    Rerack4;
    GraspCap;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    Cap4;
    
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    GraspVialSide;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    BinVial;
    Rerack5;
    GraspCap;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    Cap5;
    
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    GraspVialSide;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    BinVial;
    Rerack6;
    GraspCap;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    Cap6;
    
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    GraspVialSide;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    BinVial;
    Rerack7;
    GraspCap;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    Cap7;
    
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    GraspVialSide;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    BinVial;
    Rerack8;
    GraspCap;
    right_arm_done:= FALSE;
    WaitTestAndSet left_arm_done;
    Cap8;
    right_arm_done := FALSE;
    ENDPROC
    
    PROC GraspVialSide()
    !grasp vial from right arm
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-68.8533,-96.5027,17.497,30.6356,84.3835,-9.75034],[36.401,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-71.5319,-96.4827,48.9135,50.3575,45.9816,-9.80341],[59.9477,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-80.0035,-96.45,47.6143,57.4698,46.0402,-15.3968],[60.2747,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-81.0294,-96.4521,47.5824,57.4559,42.3838,-12.9311],[63.9368,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-82.3405,-96.4505,49.3344,65.7498,42.8275,-22.5482],[62.0649,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-82.7588,-96.4503,49.7823,68.0593,42.3253,-24.0921],[63.1602,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-86.2163,-96.4505,48.0293,69.4239,47.3279,-25.4379],[61.7343,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=20;
    ENDPROC
    
    
    PROC GraspCap()
    ! bin vial and pick up cap
    MoveAbsJ [[-69.9197,-90.1475,43.112,109.562,1.77156,-68.849],[86.8269,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-99.767,-121.133,25.5614,176.515,-83.2137,-52.7068],[72.3865,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-124.197,-121.092,19.2622,181.031,-75.6171,2.22833],[62.1658,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-122.581,-121.101,21.5373,177.725,-73.1339,-0.706672],[65.3109,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    ENDPROC
    
   
    PROC BinVial()
    WaitRob \ZeroSpeed;
    MoveAbsJ [[-84.3034,-96.4371,49.1012,66.9944,41.1294,-18.2171],[64.0656,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-84.2949,-96.4386,44.3638,67.0098,41.1627,-19.3105],[68.1703,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-80.0013,-98.7027,36.495,161.776,-7.64921,-91.7014],[103.396,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-98.6993,-98.7237,-4.11162,167.319,-33.8398,-87.7709],[113.426,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-98.6974,-98.719,-1.97956,166.272,-28.5823,-87.7709],[112.411,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-98.6989,-98.7192,-1.9772,166.262,-25.1906,-87.7734],[112.965,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-72.8471,-98.7228,45.5123,160.98,-6.29976,-87.8009],[105.767,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-107.356,-98.7238,52.1151,161.364,119.548,-155.375],[97.5552,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-105.861,-98.7239,34.9159,165.773,100.714,-165.163],[104.905,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-105.853,-98.7239,33.0625,164.62,99.5095,-166.065],[104.807,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn;
    MoveAbsJ [[-105.853,-98.723,55.128,161.344,119.528,-163.617],[99.5053,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    PROC Rerack1()
    !vial 1 waste back to rack
     MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-109.721,-98.715,10.6143,152.716,103.948,-115.339],[39.045,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-109.721,-98.7151,6.26947,152.41,100.344,-115.339],[40.4532,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut;
     MoveAbsJ [[-109.721,-98.7142,23.1364,152.252,117.041,-115.339],[33.9672,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Rerack2()
    !vial 2 waste back to rack
     MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-104.211,-92.3842,16.6039,141.292,116.591,-111.382],[32.145,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-104.202,-92.4099,1.06969,146.05,96.6724,-67.6011],[44.2024,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut;
     MoveAbsJ [[-104.202,-92.4091,22.5751,146.022,118.737,-67.0032],[32.5618,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Rerack3()
    !vial 3 waste back to rack
     MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-100.622,-98.5626,28.639,144.226,114.675,-116.123],[42.1606,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-100.623,-98.5629,14.4241,145.592,99.0553,-116.126],[48.4331,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut;
     MoveAbsJ [[-100.623,-98.5625,29.1327,145.5,114.46,-116.126],[41.5172,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Rerack4()
    !vial 4 waste back to rack
     MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-100.619,-98.5614,24.6909,143.424,115.93,-111.332],[34.7708,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-100.617,-98.5599,10.9928,145.004,101.854,-156.095],[43.0318,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut;
     MoveAbsJ [[-100.615,-98.5596,26.6066,142.159,117.948,-156.095],[32.8588,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Rerack5()
    !vial 5 waste back to rack
     MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-86.0392,-98.5548,38.1858,135.822,109.496,-125.941],[54.4734,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-82.5967,-98.5583,31.4114,142.988,91.1574,-123.667],[65.6761,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut;
     MoveAbsJ [[-85.955,-98.5556,43.2155,134.499,115.162,-127.406],[50.8973,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Rerack6()
    !vial 6 waste back to rack
     MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-75.5068,-98.5532,39.1758,132.499,97.666,-123.45],[55.7533,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-78.1103,-98.5545,30.623,140.139,88.3496,-123.39],[62.6064,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut;
     MoveAbsJ [[-80.5034,-98.5538,43.6111,130.172,113.965,-92.8182],[47.3132,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Rerack7()
    !vial 7 waste back to rack
     MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-75.5169,-98.5541,47.5599,134.489,102.797,-132.135],[60.5504,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-78.3763,-98.554,36.9964,142.878,94.3825,-134.218],[69.3619,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut;
     MoveAbsJ [[-78.3748,-98.554,50.7904,132.497,110.766,-134.214],[55.9671,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Rerack8()
    !vial 8 waste back to rack
     MoveAbsJ [[-68.5856,-98.7421,64.2108,133.008,103.658,-130.45],[62.1003,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-69.3608,-98.5674,40.6802,138.095,87.0789,-178.691],[66.3819,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-69.383,-98.5676,36.1287,138.806,80.628,-177.295],[69.1189,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut;
     MoveAbsJ [[-71.8771,-98.5673,48.7446,126.698,107.129,-179.29],[52.0359,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Cap1()
    !move cap to position 1
    WaitRob \ZeroSpeed;
    MoveAbsJ [[-95.6447,-66.4217,25.1362,126.322,81.483,-107.981],[85.1965,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-126.828,-66.4255,16.3678,134.565,95.0633,-140.237],[103.052,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-124.49,-66.4258,14.6322,140.123,87.6864,-26.5434],[107.223,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-125.912,-66.4049,3.85852,139.038,71.1256,-25.7465],[113.54,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-128.261,-66.4059,0.328008,134.472,74.0395,-20.8825],[114.261,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-125.709,-66.4515,19.744,137.061,95.1004,-28.4701],[101.607,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-64.3093,-143.138,44.7622,137.025,5.13986,-62.3977],[62.2032,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    ENDPROC
    
     PROC Cap2()
     MoveAbsJ [[-90.7578,-55.4745,23.6861,130.449,65.0055,3.54273],[95.1727,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-125.882,-55.5081,7.46319,135.088,66.5393,-13.1132],[123.474,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     WaitRob \ZeroSpeed;
     g_GripOut \holdForce:=10;
     MoveAbsJ [[-110.92,-55.4167,27.1114,129.887,80.3581,-7.6229],[102.458,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     MoveAbsJ [[-69.0247,-121.081,27.3451,96.219,-3.50852,-41.0246],[54.8015,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     ENDPROC
     
     PROC Cap3()
        !cap3
        MoveAbsJ [[-100.059,-78.2646,26.9687,135.847,93.8327,26.6201],[78.274,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-122.878,-78.2648,12.7169,144.853,96.8457,-23.4426],[90.0614,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-126.417,-78.2647,-1.93682,147.626,83.8711,-13.0423],[99.3452,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-126.416,-78.2693,-2.30168,146.986,82.7467,-16.0056],[99.6761,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        WaitRob \ZeroSpeed;
        g_GripOut \holdForce:=10;
        MoveAbsJ [[-120.993,-78.2638,13.7486,145.625,93.5302,-11.2852],[90.3503,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-118.073,-78.3268,11.2927,145.603,7.67605,-11.2851],[92.642,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-65.5245,-127.055,29.443,139.36,2.40811,-81.1234],[60.2104,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     ENDPROC
   
     PROC Cap4()
        !cap4
        MoveAbsJ [[-99.1415,-57.503,8.08408,120.947,63.8697,-22.2918],[96.8826,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-99.142,-57.503,8.09518,120.998,63.8702,21.5614],[96.886,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-123.85,-57.5214,4.22261,138.099,64.9077,-6.18929],[118.206,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-127.379,-57.5336,-0.121608,133.329,66.0936,-22.2078],[120.925,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        WaitRob \ZeroSpeed;
        g_GripOut \holdForce:=10;
        MoveAbsJ [[-115.218,-60.6809,12.6654,128.599,79.1307,-18.8985],[97.5891,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-74.3547,-143.381,43.0461,120.169,14.4318,-55.8825],[41.381,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     ENDPROC

    PROC Cap5()
        !cap5
        MoveAbsJ [[-101.07,-58.0717,14.8326,126.183,73.9199,1.79574],[88.6889,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-125.904,-58.0842,3.06064,125.858,75.5805,-29.4626],[103.684,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-137.748,-58.315,-12.3277,125.46,65.0659,-27.8422],[124.077,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-140.912,-58.5796,-16.5239,122.141,64.373,-20.2856],[127.661,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        WaitRob \ZeroSpeed;
        g_GripOut \holdForce:=10;
        MoveAbsJ [[-133.495,-47.9193,0.503899,117.31,67.5053,-28.1883],[119.36,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-69.6086,-132.485,39.4046,117.42,11.4703,-52.2052],[50.1062,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     ENDPROC
    
     PROC Cap6()
        !cap6
        MoveAbsJ [[-101.767,-55.4111,4.94045,124.485,61.6193,1.41023],[98.0187,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-128.199,-55.4144,-3.74193,125.506,66.552,10.9397],[116.766,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-132.347,-55.498,-10.4137,121.383,62.988,9.41646],[122.447,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-131.612,-55.4519,-10.3938,122.654,59.3845,-13.0981],[123.13,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        WaitRob \ZeroSpeed;
        g_GripOut \holdForce:=10;
        MoveAbsJ [[-125.414,-42.8284,5.8204,115.653,57.732,-0.501942],[120.038,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-73.0543,-128.034,31.8994,110.877,10.7613,-49.5397],[44.6868,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
     ENDPROC
     
     PROC Cap7()
        !cap7
        MoveAbsJ [[-105.014,-48.2722,5.55492,113.806,67.0934,13.9707],[93.0445,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-138.16,-48.3263,-9.18236,112.971,67.9748,-42.8797],[120.629,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-142.496,-58.6759,-23.46,118.991,61.3515,-42.8301],[126.121,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-144.9,-60.6875,-31.0938,110.932,63.5254,-36.4752],[124.787,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        WaitRob \ZeroSpeed;
        g_GripOut \holdForce:=10;
        MoveAbsJ [[-142.405,-44.1729,-10.4294,106.555,67.9611,-44.6518],[126.228,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
        MoveAbsJ [[-74.4094,-141.233,39.2791,117.66,3.67368,-32.9745],[52.122,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;

     ENDPROC
     
    PROC Cap8()
    !cap8
    MoveAbsJ [[-103.032,-55.7217,0.015996,117.34,67.0449,22.6541],[91.1123,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-130.944,-55.7596,-13.8895,119.941,62.0668,12.9737],[115.965,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-133.624,-58.2648,-18.858,119.06,63.6642,13.9165],[116.816,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-133.623,-58.3096,-20.4037,116.666,61.5902,15.0789],[117.366,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-129.791,-46.109,-6.06598,110.228,64.9115,13.7122],[116.439,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-112.325,-56.1717,5.07685,108.246,-15.4949,-52.6371],[105.678,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-58.341,-141.104,43.0323,93.9849,9.09801,-21.7765],[62.9915,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
     
     
    PROC STRVial1()
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-34.3602,-94.2544,21.5331,-265.059,78.9897,-86.629],[42.9679,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-41.497,-94.2653,13.8991,-259.631,69.886,-87.2586],[52.3965,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-44.4406,-94.2649,10.8604,-257.566,68.7579,-85.8811],[54.631,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-31.9962,-94.3145,22.2239,-266.233,70.86,-83.7014],[46.0294,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-47.8745,-78.2042,77.6642,-253.969,89.3387,-68.5387],[42.3386,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC 
    
    
    PROC STRVial2()
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-33.919,-124.205,54.1534,-235.057,80.6775,65.2568],[62.5859,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-57.0916,-99.197,10.7665,-247.284,87.0591,75.504],[34.8629,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-57.0815,-99.2135,8.54671,-248.375,83.0973,23.7945],[40.0816,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-57.081,-99.213,8.54639,-246.763,83.0919,17.4088],[40.4922,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-51.1599,-99.2123,17.0939,-256.179,94.7467,20.2837],[25.6353,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-47.8745,-78.2042,77.6642,-253.969,89.3387,-68.5387],[42.3386,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-48.9402,-78.2048,77.6313,-257.115,90.8408,-68.9346],[42.3411,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-48.9397,-78.2048,70.6998,-266.124,89.2872,-60.8576],[40.5663,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC STRVial3()
    g_GripOut \holdForce:=10;
    !get vial
    MoveAbsJ [[-37.3302,-118.858,58.9874,-236.551,85.0014,64.7426],[59.0241,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-61.6505,-106.095,26.8134,-240.925,96.6917,77.8374],[30.2725,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-53.1164,-103.357,22.575,-247.36,88.3217,67.3691],[38.7961,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-54.2749,-103.356,19.2284,-245.728,83.4497,68.3599],[43.2198,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    !move up
    MoveAbsJ [[-54.1491,-103.356,30.3367,-258.294,110.694,67.9319],[14.7326,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    MoveAbsJ [[-47.8745,-78.2042,77.6642,-253.969,89.3387,-68.5387],[42.3386,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC STRVial4()
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-36.7101,-115.209,57.5186,-243.004,83.3692,65.7279],[51.0376,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-55.431,-115.188,29.3552,-240.31,86.6871,97.1598],[35.5061,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-48.6192,-115.207,30.1753,-238.574,74.2369,96.711],[47.8188,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-48.6203,-115.203,30.2343,-239.67,76.4408,96.7129],[46.5168,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-48.6036,-115.208,39.6957,-252.262,99.1921,96.7089],[24.3397,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    MoveAbsJ [[-47.8745,-78.2042,77.6642,-253.969,89.3387,-68.5387],[42.3386,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC STRVial5()
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-55.4001,-115.188,33.1769,-245.858,100.012,98.5856],[26.2505,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-55.353,-124.262,32.4986,-239.982,95.1613,147.32],[29.8789,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-55.3369,-124.262,29.5439,-236.605,91.4822,152.552],[33.9581,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-55.3369,-124.26,28.8199,-236.246,90.1232,152.525],[34.7166,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-55.3122,-124.261,39.552,-250.896,107.557,152.492],[12.9456,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    MoveAbsJ [[-47.8745,-78.2042,77.6642,-253.969,89.3387,-68.5387],[42.3386,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC STRVial6()
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-55.3988,-124.238,56.6152,-239.012,98.7452,77.8466],[35.2962,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-55.3717,-117.621,20.1297,-242.583,90.4227,84.7005],[26.7377,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-55.3419,-120.861,21.5744,-237.333,87.9837,68.7603],[31.7383,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-55.3555,-120.849,19.3282,-239.526,86.4037,68.6544],[32.4509,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-55.2776,-120.842,20.4829,-238.264,86.9966,69.2598],[32.5098,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-55.3288,-120.86,31.1205,-245.507,103.96,68.7973],[13.4372,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    MoveAbsJ [[-47.8745,-78.2042,77.6642,-253.969,89.3387,-68.5387],[42.3386,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC STRVial7()
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-55.3412,-123.496,53.8493,-236.23,96.359,72.8582],[36.961,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-46.9641,-107.468,12.2419,-252.232,80.4786,103.428],[35.9974,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-53.9371,-107.443,5.53339,-247.688,80.2106,104.715],[37.6622,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-53.9072,-107.442,6.59357,-247.601,82.0041,104.706],[36.4202,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-48.1361,-107.443,16.1448,-253.265,94.0221,102.538],[26.2986,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    MoveAbsJ [[-47.8745,-78.2042,77.6642,-253.969,89.3387,-68.5387],[42.3386,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC STRVial8()
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-47.0875,-112.333,54.5972,-230.65,83.6943,61.9543],[55.443,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-47.1021,-102.875,10.7672,-254.759,79.6076,102.644],[37.4138,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-56.5564,-102.858,4.61899,-247.593,80.3428,100.232],[36.5516,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-56.5036,-102.858,15.7505,-251.511,110.021,101.623],[10.9374,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    MoveAbsJ [[-47.8745,-78.2042,77.6642,-253.969,89.3387,-68.5387],[42.3386,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC Vial1SHK()
    !move vial 1 to shaker plate
    MoveAbsJ [[-57.335,-87.0814,72.6786,-257.056,103.61,-64.3249],[39.1508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-15.334,-107.902,30.3539,-274.041,78.1142,30.6023],[44.074,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-15.4047,-107.901,30.3569,-266.851,69.2002,88.1757],[56.4773,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-19.2951,-107.884,28.5537,-262.164,67.6832,87.7594],[58.5968,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-19.2952,-107.885,28.5531,-261.314,65.2871,87.7594],[59.9703,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-6.73029,-107.885,31.6483,-279.567,82.7545,95.9252],[44.4884,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.293,-143.37,41.2616,-211.568,-11.9772,98.022],[85.137,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   ENDPROC
    
    PROC Vial2SHK()
    MoveAbsJ [[-57.2838,-89.6612,71.8973,-264.655,105.382,-55.4003],[31.1381,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-23.3803,-131.105,31.6087,-263.095,86.2475,47.0509],[36.9468,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-23.4567,-131.059,31.62,-258.105,79.8363,45.7886],[46.0965,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-23.6123,-130.953,32.0914,-255.745,77.1733,66.8161],[47.8993,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-23.6129,-130.953,32.0017,-253.568,74.0755,65.2215],[50.2557,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-23.6431,-130.91,36.2064,-258.745,91.9008,78.1798],[36.5401,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft; 
    MoveAbsJ [[-37.293,-143.37,41.2616,-211.568,-11.9772,98.022],[85.137,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Vial3SHK()
    
    MoveAbsJ [[-55.6809,-87.1616,72.5232,-265.628,104.322,24.7112],[33.3048,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-1.08041,-98.7316,39.1534,-274.567,59.7253,118.662],[58.8952,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-0.586025,-98.7304,29.5298,-278.067,49.9349,133.062],[72.5101,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-8.54628,-98.7301,23.3089,-276.305,48.4149,132.94],[76.1758,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-9.72802,-98.7288,23.3077,-272.94,47.6884,128.111],[76.8733,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[4.35453,-98.7289,30.9021,-282.006,56.3872,130.049],[67.5872,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.293,-143.37,41.2616,-211.568,-11.9772,98.022],[85.137,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
   
    ENDPROC
    
    PROC Vial4SHK()
    !move vial 1 to shaker plate
    MoveAbsJ [[-57.335,-87.0814,72.6786,-257.056,103.61,-64.3249],[39.1508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-23.5593,-120.577,62.4926,-262.613,92.3074,68.9851],[38.2583,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-20.0058,-140.803,32.661,-256.03,89.0932,134.935],[39.0516,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-14.9238,-140.803,36.5046,-247.812,78.7358,124.201],[52.8277,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-18.4763,-140.596,34.2903,-245.062,77.9964,123.757],[53.0754,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-15.3978,-136.972,29.4625,-259.724,83.1793,133.449],[45.6111,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft; 
    
    ENDPROC
    
    PROC Vial5SHK()
    !move vial 1 to shaker plate
    MoveAbsJ [[-57.335,-87.0814,72.6786,-257.056,103.61,-64.3249],[39.1508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-35.8913,-134.102,51.9253,-258.188,102.712,102.732],[22.0033,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-35.9574,-121.427,22.8757,-260.146,99.913,122.269],[23.0876,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-35.9578,-121.45,20.0653,-256.726,90.6334,61.7993],[33.408,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-35.9578,-121.45,20.0642,-255.372,88.1569,61.7993],[35.2528,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-35.9549,-121.45,25.492,-259.063,103.575,61.8088],[19.5398,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    ENDPROC
    
    PROC Vial6SHK()
    !move vial 1 to shaker plate
    MoveAbsJ [[-57.335,-87.0814,72.6786,-257.056,103.61,-64.3249],[39.1508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.129,-122.208,19.506,-256.999,98.601,128.201],[22.6406,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1297,-134.337,30.893,-250.018,96.7641,129.338],[24.8453,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1497,-134.335,28.6743,-244.011,88.5617,129.057],[31.84,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1497,-134.335,28.6744,-242.967,87.2404,129.057],[33.1714,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-37.1478,-134.334,28.7907,-250.424,96.3739,129.152],[23.4469,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    ENDPROC
    
    PROC Vial7SHK()
    !move vial 1 to shaker plate
    MoveAbsJ [[-57.335,-87.0814,72.6786,-257.056,103.61,-64.3249],[39.1508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1291,-130.322,21.1507,-257.732,103.396,128.208],[14.5571,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1191,-136.941,27.0914,-249.632,98.6266,132.636],[23.3317,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1314,-136.936,27.0324,-245.435,94.2881,132.636],[28.2711,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1311,-136.936,27.032,-244.375,93.8297,132.636],[29.6782,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-37.1252,-136.936,27.089,-252.013,100.492,132.658],[20.4508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    ENDPROC
    
    PROC Vial8SHK()
    !move vial 1 to shaker plate
    MoveAbsJ [[-57.335,-87.0814,72.6786,-257.056,103.61,-64.3249],[39.1508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1261,-136.786,26.5631,-255.373,103.107,127.727],[12.3214,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1272,-142.036,27.8259,-247.057,99.9454,130.205],[21.398,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1559,-142.034,25.6049,-244.361,93.9882,145.312],[26.8571,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-37.1563,-142.035,25.6025,-243.761,92.6802,145.312],[28.0875,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[-37.1542,-142.033,27.4844,-255.159,104.292,145.309],[13.6092,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    ENDPROC
    
    PROC GraspTopVial()
    !grasp vial from top off right arm
    MoveAbsJ [[-60.7497,-45.6673,67.9526,-273.921,87.7841,-100.902],[32.8627,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-60.7491,-45.6671,67.1996,-272.794,85.46,-7.61757],[34.5505,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-60.749,-45.6672,67.1272,-269.061,83.5359,-7.68266],[40.4567,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-60.7488,-45.668,67.1254,-269.057,82.4673,-7.68228],[40.46,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-60.7474,-45.6677,67.1234,-267.388,82.5786,-8.59584],[41.2739,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-60.488,-46.3664,67.2933,-266.405,82.4442,-8.13832],[42.1216,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    ENDPROC 
    
    PROC STRSHKL()
    STRVial1;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    GraspTopVial;
    CloseGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Vial1SHK;
    
    STRVial2;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    GraspTopVial;
    CloseGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Vial2SHK;
    
    STRVial3;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    GraspTopVial;
    CloseGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Vial3SHK;
    
    STRVial4;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    GraspTopVial;
    CloseGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Vial4SHK;
    
    STRVial5;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    GraspTopVial;
    CloseGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Vial5SHK;
    
    STRVial6;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    GraspTopVial;
    CloseGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Vial6SHK;
    
    STRVial7;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    GraspTopVial;
    CloseGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Vial7SHK;
    
    STRVial8;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    GraspTopVial;
    CloseGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    Vial8SHK;
    ENDPROC
    
    
    PROC FROMSHK1()
    OpenGripper;
    MoveAbsJ [[-37.1441,-127.872,32.0569,-256.595,97.1534,113.409],[24.8604,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-36.8688,-128.657,30.5357,-246.883,85.7586,78.9222],[40.0479,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-36.8856,-128.654,29.287,-247.066,84.7325,80.1886],[40.8394,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-36.8682,-128.657,36.9725,-256.6,101.148,79.046],[23.8226,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-50.4504,-56.8934,74.7006,-260.72,80.7505,88.7103],[40.5041,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    PROC FROMSHK2()
    OpenGripper;
    MoveAbsJ [[-19.9972,-117.812,25.0195,-261.72,67.9316,124.882],[55.5617,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-21.0632,-117.802,27.8725,-255.184,65.9636,73.439],[60.4175,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-22.7446,-117.799,26.3084,-254.597,67.2098,76.574],[60.4676,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-13.0494,-117.798,35.4717,-269.269,85.5161,80.0741],[42.4293,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-50.4504,-56.8934,74.7006,-260.72,80.7505,88.7103],[40.5041,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    PROC FROMSHK3()
    OpenGripper;
    MoveAbsJ [[-29.392,-140.751,34.533,-251.426,87.0321,143.044],[35.3518,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-29.5977,-135.87,31.3752,-248.638,87.9178,74.6648],[42.2788,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-29.5633,-135.885,29.6998,-247.594,84.7438,74.6211],[45.0515,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-29.5258,-135.885,39.2421,-260.188,106.147,74.8826],[19.926,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    
    MoveAbsJ [[-50.4504,-56.8934,74.7006,-260.72,80.7505,88.7103],[40.5041,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    PROC FROMSHK4()
    OpenGripper;
    MoveAbsJ [[-13.5223,-132.791,29.3922,-258.171,72.3214,103.881],[54.86,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-15.7555,-132.691,28.5901,-253.384,69.9537,85.9091],[59.6987,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-15.3145,-124.457,24.1095,-257.809,64.7905,85.9133],[65.3454,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-4.00997,-130.127,35.3437,-270.241,85.9078,87.3927],[47.2385,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-50.4504,-56.8934,74.7006,-260.72,80.7505,88.7103],[40.5041,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    PROC FROMSHK5()
    OpenGripper;
    MoveAbsJ [[-21.5953,-104.822,14.0632,-271.387,64.141,91.8141],[54.3944,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-26.2537,-104.792,12.6506,-265.615,62.9925,96.2881],[59.3911,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-13.1707,-104.79,22.1334,-274.251,78.2487,97.1809],[45.7819,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-50.4504,-56.8934,74.7006,-260.72,80.7505,88.7103],[40.5041,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    PROC FROMSHK6()
    OpenGripper;
    MoveAbsJ [[-18.5599,-104.91,10.8058,-276.991,58.6255,124.612],[61.1281,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-21.6406,-104.902,12.5077,-269.461,56.0874,123.806],[65.5955,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-20.4679,-104.824,13.7208,-268.679,52.4213,120.141],[67.1973,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-5.13804,-104.9,19.4515,-285.75,74.6587,126.898],[50.4823,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-50.4504,-56.8934,74.7006,-260.72,80.7505,88.7103],[40.5041,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    PROC FROMSHK7()
    OpenGripper;
    MoveAbsJ [[-17.2454,-104.914,8.55446,-279.76,50.817,129.163],[69.0107,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-17.6051,-104.872,11.7271,-272.892,50.1919,125.38],[71.3005,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[-3.27174,-104.872,21.7553,-280.754,63.9814,125.558],[60.4986,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-50.4504,-56.8934,74.7006,-260.72,80.7505,88.7103],[40.5041,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    PROC FROMSHK8()
    OpenGripper;
    MoveAbsJ [[-10.9344,-104.913,11.3356,-286.204,61.2066,135.862],[60.9427,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-14.5595,-104.913,8.76606,-280.241,46.8567,135.709],[76.4086,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-14.559,-104.907,9.76471,-279.05,45.9393,131.816],[76.4997,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[1.49182,-104.904,18.9505,-287.21,66.9418,131.815],[61.5749,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    MoveAbsJ [[-50.4504,-56.8934,74.7006,-260.72,80.7505,88.7103],[40.5041,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperLeft;
    ENDPROC
    
    
    PROC LoadRack()
    FROMSHK1;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    
    FROMSHK2;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    
    FROMSHK3;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    
    FROMSHK4;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    
    FROMSHK5;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    
    FROMSHK6;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    
    FROMSHK7;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    
    FROMSHK8;
    right_arm_done := FALSE;
    WaitTestAndSet left_arm_done;
    OpenGripper;
    right_arm_done := FALSE;
    
    ENDPROC
    
ENDMODULE