MODULE CrystalBotR
    
    
    PERS bool server_connected;
    PERS string current_task;
    PERS bool task_complete;
    PERS bool right_arm_done;
    PERS bool left_arm_done;
    
    PROC main()
        TPErase;
        TPWrite "starting the program";
        right_arm_done := TRUE;
        executeRemoteTasks;
        
    ENDPROC
        
    
     PROC executeRemoteTasks()
        current_task := "";
        WaitUntil server_connected;
        
        WHILE server_connected DO
           TEST current_task
            CASE "loadIKAPlate": !move vials from Chemspeed rack to Stir plate
                TPWrite "Right arm executing loadIKAPlate";
                loadIKAPlate;
                current_task := "";
                task_complete := TRUE;
                TPWrite "Right arm finished executing loadIKAPlate";
            CASE "invertAndLoadShakerPlate": !move and invert vials from stir plate to Shaker plate
                TPWrite "Right arm executing invertAndLoadShakerPlate";
                invertAndLoadShakerPlate;
                current_task := "";
                task_complete := TRUE;
                TPWrite "Right arm finished executing invertAndLoadShakerPlate";
            CASE "invertAndLoadWellPlate": !move and invert vials from shaker plate to Well plate rack
                TPWrite "Right arm executing invertAndLoadWellPlate";
                invertAndLoadWellPlate;
                current_task := "";
                task_complete := TRUE;
                TPWrite "Right arm finished executing invertAndLoadWellPlate";
            CASE "unscrewCaps": ! unscrew caps and load well plate rack
                TPWrite "Right arm executing unscrewCaps";
                unscrewCaps;
                current_task := "";
                task_complete := TRUE;
                TPWrite "Right arm finished executing unscrewCaps";
            DEFAULT:
                WaitTime 0.5;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    !PROC RhomePos()
    !MoveAbsJ [[0,-130,30,0,40,0],[-135,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    !ENDPROC
    !PROC RcamCalib()
    !MoveAbsJ [[57.7349,-143.377,51.5897,111.55,2.23142,-0.00329059],[-67.9156,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    !ENDPROC
    
    PROC OpenGripper()
    g_GripOut \holdForce:=10;
    ENDPROC
    
    PROC CloseGripper()
    g_GripIn \holdForce:=10;
    ENDPROC
    
    PROC loadIKAPlate ()
    ! code move vials from Chemspeed rack to Stir plate
    ! right arm does not move in this task
    WaitTestAndSet right_arm_done;
    ENDPROC
    
    
    PROC invertAndLoadShakerPlate ()
    ! code to move and invert vials from stir plate to Shaker plate
    STRSHKR;
    WaitTestAndSet right_arm_done;
    ENDPROC
    
    PROC invertAndLoadWellPlate ()
    ! code to move and invert vials from shaker plate to Well plate rack
    LoadRack;
    !WaitTestAndSet right_arm_done;
    right_arm_done := FALSE;
    Uncap;
    ENDPROC
    
    
    PROC unscrewCaps ()
    ! code to unscrew caps and load well plate rack
    !Uncap;
    OpenGripper;
    ENDPROC

    


    PROC Uncap()
    Pick_vial_pos1;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    Unscrew;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    Pick_vial_pos2;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    Unscrew2;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    Pick_vial_pos3;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    Unscrew2;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    Pick_vial_pos4;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    Unscrew2;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    
    Pick_vial_pos5;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    Unscrew2;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    Pick_vial_pos6;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    Unscrew2;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    Pick_vial_pos7;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    Unscrew2;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    Pick_vial_pos8;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    Unscrew2;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    ENDPROC
    
    
    PROC RMove()
    !move R away 
    
    ENDPROC


    
    PROC Unscrew()
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    g_GripOut \holdForce:=10;
    ! rotate back to start of range
    MoveAbsJ [[48.6284,-41.0321,53.7426,-72.205,84.5488,177.274],[-14.1891,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ! wait until robot has stopped previous command
    WaitRob \ZeroSpeed;
    ! unscrew 
        FOR i FROM 1 TO 8 DO
            g_GripIn \holdForce:=10;
            MoveL RelTool (CRobT(\Tool:=GripperR),0,0,-1,\Rz:=-95), v200, z50,GripperR;
            WaitRob \ZeroSpeed;
            g_GripOut \holdForce:=10;
            MoveL RelTool (CRobT(\Tool:=GripperR),0,0,0,\Rz:=95), v200, z50,GripperR;
            WaitRob \ZeroSpeed;
        ENDFOR
            g_GripIn \holdForce:=10;
            MoveL RelTool (CRobT(\Tool:=GripperR),0,0,-1,\Rz:=-160), v200, z50,GripperR;
            WaitRob \ZeroSpeed;
            MoveAbsJ [[47.1303,-40.9734,53.1958,-69.0688,88.3684,16.7173],[-7.32916,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v200, z50, GripperR;
            WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC Unscrew2()
    g_GripOut \holdForce:=10;
    ! rotate back to start of range
    MoveAbsJ [[48.6284,-41.0321,53.7426,-72.205,84.5488,177.274],[-14.1891,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ! wait until robot has stopped previous command
    WaitRob \ZeroSpeed;
    ! unscrew 
        FOR i FROM 1 TO 8 DO
            g_GripIn \holdForce:=10;
            MoveL RelTool (CRobT(\Tool:=GripperR),0,0,-1,\Rz:=-95), v200, z50,GripperR;
            WaitRob \ZeroSpeed;
            g_GripOut \holdForce:=10;
            MoveL RelTool (CRobT(\Tool:=GripperR),0,0,0,\Rz:=95), v200, z50,GripperR;
            WaitRob \ZeroSpeed;
        ENDFOR
            g_GripIn \holdForce:=10;
            MoveL RelTool (CRobT(\Tool:=GripperR),0,0,-1,\Rz:=-160), v200, z50,GripperR;
            WaitRob \ZeroSpeed;
            MoveAbsJ [[47.1303,-40.9734,53.1958,-69.0688,88.3684,16.7173],[-7.32916,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v200, z50, GripperR;
            WaitRob \ZeroSpeed;
    ENDPROC
  
    PROC Pick_vial_pos1()
    !move to pos 1
    g_GripOut \holdForce:=10;
    MoveAbsJ [[53.4511,-108.088,49.251,-158.196,6.63098,-71.7097],[-81.8794,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveJ [[424.30,-95.09,38.19],[0.00592649,-0.869466,0.493772,0.013512],[1,-2,-1,4],[-145.084,9E+09,9E+09,9E+09,9E+09,9E+09]], v1000, z50, GripperR;
    MoveAbsJ [[88.472,-93.0778,27.8177,-145.852,86.4869,-85.8162],[-72.285,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[88.4721,-93.0774,42.1255,-139.088,104.374,-84.9323],[-61.0018,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[66.7816,-44.8059,54.7806,-99.6021,80.2425,-97.7416],[-51.5833,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[48.6286,-41.0318,53.737,-72.1983,84.5596,-101.978],[-14.1273,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    ENDPROC
   
    PROC Pick_vial_pos2()
    !move to pos 2
    g_GripOut \holdForce:=10;
    MoveAbsJ [[72.6157,-90.1698,56.0165,-142.987,94.1219,-57.2997],[-73.8457,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[92.1971,-90.1699,32.5581,-146.554,94.0054,-44.7993],[-74.2144,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[93.5437,-90.17,26.7792,-148.231,88.6874,-43.7337],[-76.8391,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[85.7166,-72.8743,41.6074,-127.251,93.6256,-26.059],[-70.1833,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[66.7816,-44.8059,54.7806,-99.6021,80.2425,-97.7416],[-51.5833,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[48.6286,-41.0318,53.737,-72.1983,84.5596,-101.978],[-14.1273,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Pick_vial_pos3()
    !move to pos 3
    g_GripOut \holdForce:=10;
    MoveAbsJ [[76.4475,-84.612,48.4944,-131.31,97.7305,-31.7915],[-61.9359,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[91.602,-84.6127,23.737,-137.035,91.4348,-86.1329],[-69.1565,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[92.8879,-85.5904,19.7735,-138.844,88.3422,-87.1725],[-71.1679,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[93.0771,-85.6971,19.164,-138.916,87.8951,-87.2814],[-71.4354,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[88.9594,-81.6133,32.352,-130.321,99.1245,-82.878],[-62.9704,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[48.6286,-41.0318,53.737,-72.1983,84.5596,-101.978],[-14.1273,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Pick_vial_pos4()
    !move to pos 4
    g_GripOut \holdForce:=10;
    MoveAbsJ [[71.7225,-80.3926,50.6629,-129.458,93.4159,-92.5144],[-67.4039,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[94.7081,-80.3941,23.8164,-137.878,88.6043,-38.5869],[-74.6104,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[95.2513,-79.6657,21.0793,-139.561,84.7137,-41.0362],[-77.9961,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[95.5992,-80.0211,19.726,-139.638,83.9347,-41.2623],[-78.6272,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[95.5974,-80.018,19.6318,-140.848,82.3286,-33.2565],[-78.5362,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[95.5958,-80.0179,19.6434,-139.684,83.0648,-39.2403],[-78.5534,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[95.5958,-80.0116,20.1553,-134.63,86.6792,-40.9031],[-75.0742,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[89.4665,-71.9235,37.2042,-125.107,97.6431,-33.0353],[-64.4147,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[48.6286,-41.0318,53.737,-72.1983,84.5596,-101.978],[-14.1273,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Pick_vial_pos5()
    !move to pos 5
    g_GripOut \holdForce:=10;
    MoveJ [[469.87,-85.39,136.46],[0.00802368,0.924256,-0.381674,-0.00330309],[1,-1,-1,4],[-161.259,9E+09,9E+09,9E+09,9E+09,9E+09]], v1000, z50, GripperR;
    MoveAbsJ [[94.1475,-69.0238,12.397,-125.887,81.8346,-74.4697],[-76.3307,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[93.3059,-68.4308,11.0438,-127.767,75.5926,-78.571],[-79.929,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[93.4263,-68.5064,10.774,-127.851,75.4474,-78.602],[-80.1036,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[94.0331,-68.8602,9.58197,-128.271,74.7169,-78.853],[-80.8354,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[93.4264,-68.5064,10.774,-127.851,75.4473,-78.602],[-80.1036,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[93.9689,-68.8182,9.69145,-128.163,74.7936,-78.7947],[-80.7859,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[93.6174,-68.6244,10.3247,-127.857,75.2154,-78.6342],[-80.3955,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[94.1276,-68.6248,10.0155,-128.507,75.3548,-77.7229],[-80.3568,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[86.1563,-69.025,28.7378,-121.3,91.9055,-73.6308],[-61.1861,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[66.7816,-44.8059,54.7806,-99.6021,80.2425,-97.7416],[-51.5833,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[48.6286,-41.0318,53.737,-72.1983,84.5596,-101.978],[-14.1273,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Pick_vial_pos6()
    !move to pos 6
    g_GripOut \holdForce:=10;
    MoveAbsJ [[93.8418,-68.533,27.077,-125.335,94.6846,-38.1945],[-66.9863,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[98.6405,-68.5376,10.354,-132.164,74.0169,-38.5144],[-84.0528,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[92.8005,-68.5392,27.9635,-125.966,91.683,-34.1162],[-68.184,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[66.7816,-44.8059,54.7806,-99.6021,80.2425,-97.7416],[-51.5833,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[48.6286,-41.0318,53.737,-72.1983,84.5596,-101.978],[-14.1273,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Pick_vial_pos7()
    !move to pos 7
    g_GripOut \holdForce:=10;
    MoveAbsJ [[86.2767,-68.5807,26.0915,-125.754,85.9514,-78.0997],[-67.2133,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[97.1776,-68.5829,6.00598,-125.666,80.5769,-95.2197],[-73.9714,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[97.9758,-68.0757,2.9782,-126.066,75.5735,-96.8028],[-78.0383,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[98.1723,-68.1886,2.56748,-126.178,75.3279,-96.9003],[-78.2726,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[98.3824,-68.3081,2.14429,-126.297,75.0632,-96.9993],[-78.5172,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[99.5965,-68.3024,1.34481,-126.633,76.8159,-107.204],[-78.3591,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[91.8798,-68.5831,17.451,-121.847,88.4883,-92.9011],[-64.6472,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[66.7816,-44.8059,54.7806,-99.6021,80.2425,-97.7416],[-51.5833,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[48.6286,-41.0318,53.737,-72.1983,84.5596,-101.978],[-14.1273,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Pick_vial_pos8()
    !move to pos 8
    g_GripOut \holdForce:=10;
    MoveAbsJ [[95.4226,-68.5829,20.0045,-127.747,85.6422,-93.7521],[-70.3233,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[103.581,-68.5835,4.66988,-127.573,84.3222,-47.7393],[-77.1338,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[103.581,-68.5838,1.98202,-129.034,76.2547,-44.7996],[-80.7638,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[96.0518,-68.5844,23.0703,-125.307,95.0334,-44.7674],[-64.8486,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[66.7816,-44.8059,54.7806,-99.6021,80.2425,-97.7416],[-51.5833,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[48.6286,-41.0318,53.737,-72.1983,84.5596,-101.978],[-14.1273,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC RotateVialGrasp()
    !grasp side of vial and rotate
    g_GripOut \holdForce:=10;
    MoveAbsJ [[85.8206,-129.901,45.1298,-86.5617,66.6929,12.3404],[-70.188,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[92.292,-129.901,42.9227,-96.0754,58.8309,9.91664],[-77.8583,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    WaitRob \ZeroSpeed;
    ENDPROC
    !left gripper open
    
    PROC RotateVial()
    MoveAbsJ [[80.3158,-129.901,48.0693,-82.1757,66.9061,9.82952],[-69.374,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[80.3279,-129.901,48.0579,-80.6576,63.5743,-179.352],[-69.4183,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    ENDPROC
    
    PROC STRSHKR()
    WaitTestAndSet right_arm_done;
    RotateVialGrasp;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateVial;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateVialGrasp;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateVial;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
     RotateVialGrasp;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateVial;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
     RotateVialGrasp;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateVial;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
     RotateVialGrasp;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateVial;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateVialGrasp;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateVial;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
     RotateVialGrasp;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateVial;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
     RotateVialGrasp;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateVial;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    OpenGripper;
    left_arm_done := FALSE;
    ENDPROC
    
    
    PROC RotateGraspRightWay()
    g_GripOut;
    MoveAbsJ [[62.354,-120.167,46.0815,-64.5606,68.9514,10.214],[-70.8404,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[81.9881,-120.167,45.7793,-83.3789,52.5266,12.5972],[-80.322,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[80.8077,-120.166,46.8331,-84.3113,50.8023,10.6209],[-81.3721,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    ENDPROC
    
    PROC RotateRightWay()
    MoveAbsJ [[73.1484,-120.167,45.7498,-65.8988,65.4949,5.36649],[-68.3065,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[73.1514,-120.167,45.7603,-69.8531,62.4272,187.868],[-68.345,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial1Rack()
    MoveAbsJ [[106.257,-120.148,-4.08985,-66.2795,58.8736,160.574],[-31.414,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[110.879,-109.66,-32.3874,-56.9635,72.8131,143.905],[-32.1646,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[110.783,-109.635,-31.3446,-62.0621,68.3419,149.913],[-32.3453,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut;
    MoveAbsJ [[95.008,-109.7,1.76861,-61.9102,58.1412,172.584],[-44.4171,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[58.3512,-132.366,42.7348,-67.3871,-9.10248,178.734],[-72.9697,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial2Rack()
    MoveAbsJ [[94.9446,-113.237,-4.29491,70.0196,53.711,43.0672],[-83.0188,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[100.218,-113.532,-5.40997,70.5245,56.3635,39.0644],[-84.8854,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[114.583,-113.532,-15.5457,92.165,67.9148,22.1307],[-75.4613,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_JogOut;
    MoveAbsJ [[93.4048,-129.413,9.1802,26.3262,26.7508,70.3098],[-63.0193,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[55.5388,-129.418,36.4089,40.5365,9.3796,77.316],[-70.6277,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial3Rack()
    MoveAbsJ [[81.6265,-120.17,15.0105,76.2977,47.7481,29.9708],[-90.0786,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[95.7966,-119.978,1.78267,73.51,39.0055,33.3606],[-73.581,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut;
    MoveAbsJ [[75.3101,-120.313,35.8572,89.4617,29.1082,13.0129],[-81.744,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[60.3668,-120.312,30.0295,111.301,4.0726,20.2406],[-59.0995,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial4Rack()
    MoveAbsJ [[70.1572,-120.17,19.7638,11.1517,34.0312,96.1737],[-83.6533,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[102.808,-120.156,-5.06126,70.1128,46.0855,35.1857],[-75.5117,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_JogOut;
    MoveAbsJ [[75.991,-120.167,16.582,53.8072,32.4563,49.581],[-87.1418,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[96.4197,-120.139,10.1772,82.9492,45.1113,22.1729],[-80.1212,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[60.3932,-120.167,28.9558,50.0237,11.2751,73.0104],[-62.745,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial5Rack()
    MoveAbsJ [[92.6888,-126.13,9.74809,-104.711,-34.3351,209.387],[-73.6488,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[98.9443,-126.082,-0.360487,-121.511,-32.3577,223.442],[-66.1531,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut;
    MoveAbsJ [[90.7855,-126.083,22.0992,-86.2361,-29.9509,185.547],[-71.9291,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[67.5364,-126.258,33.1943,60.1532,8.74354,55.5144],[-58.9781,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial6Rack()
    MoveAbsJ [[87.2599,-126.083,24.0666,-93.4592,-42.6602,185.787],[-89.5204,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[104.7,-126.071,-1.54734,-108.624,-36.2763,208.613],[-67.7384,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_JogOut;
    MoveAbsJ [[98.2408,-126.073,4.43208,-108.726,-41.1014,208.405],[-78.3434,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[54.7707,-126.074,33.7083,-100.887,0.470235,228.785],[-58.7088,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial7Rack()
    MoveAbsJ [[84.6931,-126.073,13.3988,-108.698,-39.3625,211.922],[-82.9093,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[93.0029,-126.068,5.59207,-107.13,-31.9781,210.344],[-73.1121,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut;
    MoveAbsJ [[87.4513,-126.069,8.79744,-107.1,-40.6682,213.377],[-82.7559,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[55.4717,-126.07,36.2352,-90.2385,-1.80426,220.192],[-61.9425,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial8Rack()
    MoveAbsJ [[84.5937,-126.071,23.5604,-92.7863,-46.2235,187.818],[-95.1905,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[98.5131,-126.068,1.12003,-108.027,-37.9482,208.476],[-75.4965,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_JogOut;
    MoveAbsJ [[90.6814,-126.069,6.58716,-108.063,-43.1438,209.837],[-86.5754,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[59.3021,-126.069,30.1981,-102.661,-2.54244,221.392],[-65.7778,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial1Holder()
    !move vial to mid point right way up
    MoveAbsJ [[56.8128,-120.171,24.9204,-35.494,53.1262,129.133],[-88.6256,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[69.9412,-120.166,-1.0289,-34.3398,62.4725,120.314],[-84.3346,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[49.8008,-120.17,33.008,-39.5664,47.2481,138.348],[-88.8221,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[70.9327,-120.171,53.2617,-166.941,92.0121,209.354],[-89.0222,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[72.7713,-119.809,47.2738,-171.642,89.7139,207.773],[-91.3413,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[72.7196,-119.809,67.7724,-170.552,111.227,207.82],[-88.015,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[115.966,-109.489,27.188,-165.579,111.517,175.394],[-37.2662,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[112.071,-109.591,18.819,-165.862,98.7047,168.98],[-45.0772,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[111.818,-101.182,11.1459,-158.116,101.927,170.981],[-47.9843,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[112.071,-109.591,27.3456,-165.245,106.698,171.35],[-42.5646,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[70.7618,-143.374,42.614,-114.825,22.1661,222.383],[-53.5027,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial2Holder()
    MoveAbsJ [[53.2711,-119.488,24.9753,-33.5259,48.8459,125.001],[-92.176,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[68.8599,-119.488,0.559508,-30.2041,56.8767,117.505],[-87.5321,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[50.5998,-119.488,36.4028,-49.3893,42.4333,144.701],[-90.3732,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[68.6593,-119.495,54.7786,-176.098,88.7341,115.544],[-94.739,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[72.3664,-119.495,47.8181,-177.514,88.7753,113.105],[-94.6623,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[72.3535,-119.494,52.9645,-177.487,94.6829,113.106],[-94.1135,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[72.3456,-119.495,62.831,-177.41,106.425,113.153],[-94.1222,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[91.6994,-119.485,58.0932,-164.929,116.446,107.06],[-66.3714,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[100.671,-115.374,50.1222,-164.925,116.214,106.382],[-59.0874,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[121.168,-112.069,15.9813,-170.642,104.079,164.764],[-39.9502,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[121.166,-112.069,31.3432,-170.642,117.117,164.856],[-39.0264,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[62.3952,-129.651,34.6742,-121.132,-5.56879,228.776],[-69.3235,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial3Holder()
    MoveAbsJ [[65.4831,-120.179,6.28168,-27.741,62.3391,115.527],[-87.5683,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[70.1677,-120.179,-2.33891,-27.6804,62.734,117.11],[-86.2508,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[52.2954,-120.179,29.4066,-46.417,45.7688,142.307],[-90.2154,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[73.23,-120.183,49.0504,-174.449,93.1954,162.568],[-91.6554,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[73.2287,-120.183,46.9593,-177.259,90.0565,161.37],[-93.7574,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[73.2289,-120.183,47.11,-171.184,89.7739,158.289],[-90.4442,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[73.2101,-120.183,59.7897,-169.832,104.481,158.953],[-88.691,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[73.1914,-120.183,66.2307,-171.297,110.395,145.875],[-88.6434,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[113.458,-117.232,30.8676,-168.574,111.655,101.94],[-39.0345,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[110.109,-120.524,28.6976,-167.859,95.6712,99.7992],[-41.7481,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[110.173,-109.934,20.3482,-158.953,104.064,103.545],[-43.8467,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[113.381,-117.231,32.5324,-169.022,112.675,101.379],[-39.8795,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[71.8541,-133.708,36.7687,-159.06,3.60623,99.7354],[-53.5073,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial4Holder()
    MoveAbsJ [[61.036,-120.18,11.6361,-36.1973,60.0365,121.466],[-87.1804,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[69.8185,-120.179,-0.588783,-33.5028,62.4014,121.026],[-84.7091,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[57.7005,-120.179,22.4309,-36.776,53.2105,131.165],[-88.1656,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[70.068,-120.179,61.7226,-175.756,101.464,168.577],[-93.0291,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[74.083,-120.181,47.4815,-171.2,92.7208,114.69],[-90.1014,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[74.0546,-120.178,59.6031,-170.827,105.925,114.729],[-88.8175,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[119.016,-125.089,39.5721,-177.577,118.443,98.0723],[-40.3693,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[119.046,-119.88,29.9962,-174.229,109.178,137.747],[-39.9836,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[119.046,-119.88,25.1346,-174.143,104.583,135.781],[-39.9639,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[119.046,-119.88,25.1341,-174.151,104.612,144.562],[-39.9639,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[117.292,-115.134,33.5305,-173.934,117.971,138.708],[-45.0397,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[59.0388,-130.992,35.6886,-160.294,-7.98918,103.938],[-67.3961,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial5Holder()
    MoveAbsJ [[64.8443,-120.172,19.427,-60.8448,64.7245,150.988],[-77.5756,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[70.9734,-120.171,2.89872,-52.8669,66.2947,136.179],[-77.9116,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[61.0739,-120.171,25.4654,-53.4576,69.3382,149.924],[-77.4764,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[70.6339,-120.173,61.8428,-165.277,103.874,220.598],[-86.884,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[73.4432,-120.173,47.5238,-174.536,91.1757,136.959],[-92.2348,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[73.3825,-120.174,71.1948,-161.555,113.963,139.792],[-82.1644,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[105.505,-120.164,35.3531,-163.857,105.941,105.398],[-45.5509,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[105.502,-120.168,32.1546,-163.105,101.372,105.464],[-45.6864,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[105.505,-120.164,40.8013,-163.114,109.444,107.565],[-44.2536,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[69.1908,-141.192,37.4236,-178.974,-4.24598,102.542],[-61.981,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial6Holder()
    MoveAbsJ [[70.4586,-120.178,1.26725,-40.7107,68.2691,132.61],[-80.3568,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[72.7484,-120.177,-4.21411,-37.4546,69.8441,128.679],[-80.4757,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    WaitRob \ZeroSpeed;
    MoveAbsJ [[60.7308,-120.176,16.318,-41.5583,61.3434,134.351],[-83.8881,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[76.4572,-120.177,58.7195,-169.434,106.798,174.578],[-86.2891,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[72.2393,-120.177,48.1766,-172.98,88.7879,145.868],[-91.8615,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[72.3796,-120.184,69.4465,-171.025,111.735,120.381],[-89.3459,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[112.412,-117.231,36.6506,-168.099,118.404,136.207],[-47.8932,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[109.368,-120.349,31.3271,-171.691,102.725,131.552],[-51.0937,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[109.37,-120.347,31.327,-171.664,102.725,155.084],[-51.0825,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[108.105,-117.369,35.9579,-170.649,107.883,153.171],[-53.1415,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[76.2523,-117.373,38.1362,-258.826,38.4627,181.118],[-93.7692,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[55.5394,-117.373,33.124,-261.047,7.15476,207.012],[-68.75,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial7Holder()
    MoveAbsJ [[56.1837,-120.167,20.1108,-50.1597,57.1686,124.179],[-90.7697,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[71.6838,-120.152,-3.22803,-33.5056,66.4208,125.632],[-82.8432,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[58.1942,-120.14,31.2268,-60.2035,64.3848,155.065],[-79.0146,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[72.151,-120.152,56.3865,-173.426,99.1726,143.202],[-91.4376,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[74.9101,-120.152,47.476,-173.339,94.9557,127.498],[-91.115,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[74.8516,-120.152,66.5946,-170.644,115.249,127.496],[-89.1157,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[84.5745,-120.138,63.8449,-163.413,116.279,118.536],[-69.3816,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[101.188,-120.124,52.6019,-166.535,122.538,117.131],[-55.0411,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[100.749,-120.125,35.0347,-164.91,105.39,106.602],[-53.1203,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[100.876,-115.258,47.5883,-160.248,121.583,110.672],[-51.5459,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[64.4014,-128.894,33.5585,-166.955,-0.738536,100.74],[-60.9595,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    PROC Vial8Holder()
    MoveAbsJ [[71.2971,-120.168,0.812248,-43.8757,68.8446,134.578],[-79.0108,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[71.5254,-120.168,0.397624,-46.2534,64.4384,129.771],[-79.9772,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[57.7164,-120.162,27.1012,-48.665,58.2327,145.033],[-84.1815,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[69.3947,-120.168,62.8227,-169.811,101.756,124.345],[-89.5321,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[73.8757,-120.168,47.5582,-173.937,93.1769,129.752],[-91.5646,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripIn \holdForce:=10;
    MoveAbsJ [[73.8746,-120.168,70.8037,-165.018,117.513,130.667],[-84.9094,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[103.281,-120.187,40.7959,-164.609,111.759,147.853],[-55.8932,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[103.283,-120.188,33.7648,-167.897,102.244,155.133],[-56.9424,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    WaitRob \ZeroSpeed;
    g_GripOut \holdForce:=10;
    MoveAbsJ [[103.33,-120.185,43.4246,-166.158,112.329,155.579],[-55.2794,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    MoveAbsJ [[65.2712,-138.121,41.8005,-165.374,-5.4102,91.165],[-66.0621,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, GripperR;
    ENDPROC
    
    
    
    PROC LoadRack()
    WaitTestAndSet right_arm_done;
    RotateGraspRightWay;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateRightWay;
    Vial1Holder;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateGraspRightWay;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateRightWay;
    Vial2Holder;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateGraspRightWay;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateRightWay;
    Vial3Holder;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateGraspRightWay;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateRightWay;
    Vial4Holder;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateGraspRightWay;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateRightWay;
    Vial5Holder;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateGraspRightWay;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateRightWay;
    Vial6Holder;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateGraspRightWay;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateRightWay;
    Vial7Holder;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    
    RotateGraspRightWay;
    left_arm_done := FALSE;
    WaitTestAndSet right_arm_done;
    RotateRightWay;
    Vial8Holder;
    !left_arm_done := FALSE;
    !WaitTestAndSet right_arm_done;
    
    ENDPROC
    
ENDMODULE

    