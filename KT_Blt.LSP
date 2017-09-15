	;[
	;[                                                                              ]
	;[                                KiTek_Steel.LSP                               ]
	;[                                                                              ]
	;[                            KiTek_Steel voor acad                             ]
	;[                                                                              ]
	;[                                                                              ]
	;[
	;************************************************************************************

;	 KiTek Steel is a software add-on for AutoCad  
;    Copyright (C) 2017 Joakin Kirschen
;;-----[ Deze functie altijd laten staan]------------------------------------
(if (not KT_Stl)(LOAD "KT_Stl"))

(defun KT_blt ()
(princ "KT_blt is loaded")
(princ)
)


(defun C:KT_blt ( /  Test *Error*) 			;localize error handler
	(setq *Error* KT_stl_error)				;redefine local error handler
	(if (< (atof (getvar 'AcadVer)) 17.0)
    (progn(alert "This version of AutoCad is not supported!\nPlease upgrade to AutoCad 2008 or higher.")
	(setq Test 1))
	(setq Test 0)
	)
	(KTS_checkenv)
	(KTS_needupdate)
	(KTS_needbanner)
	(KTS_userstats)
	;(KTS_checklicencedate)
	(if (= test 1) (exit)(KTB_dialog))
	(KT_stl_error nil)						; normal, clean exit
	(princ)
)

(defun KTB_dialog (/ Dcl_Id% ddiag prestring Radio1$ Radio2$ Value1$ Value2$ Value3$ Value4$ Value5$ Image1$ Value6$ Toggle2$ Return# list1@ mainlist subitems ddiag temp anglist Laylist LayNewCo LayNewHi LayExCo LayExHi ColNewCo ColNewHi ColExCo ColNewHi ColExCo ColExHi LtNewCo LtNewHi LtExCo LtExHi LwNewCo LwNewHi LwExCo LwExHi Modetilelist)
(setvar "cmdecho" 0)
;(if (= (getvar "loginname") "p701561") (progn (alert "System error. \nContact your administrator.")(command "_close" "y")))
;(if (= (getvar "loginname") "Joakin") (progn (alert "System error. \nContact your administrator.")(exit)))
(vl-load-com) ;Load VLisp extensions
	(if (not *KT_Stl@)
		(setq *KT_Stl@ (list nil "" "" "" "" "" "" "" "" "" ""))
	)
	
	;need to set layers in register


	; set up data
	(setq 	Value1$ (nth 1 *KT_Stl@)      ;Value list string value list 1 (Main section)
			Value2$ (nth 2 *KT_Stl@)      ;Value list string value list 2 (Sub section)
			Value3$ (nth 3 *KT_Stl@)      ;Value list atoi value list 1
			Value4$ (nth 4 *KT_Stl@)      ;Value list atoi value list 2
			Value5$ (nth 5 *KT_Stl@)      ;Value list atoi value list 3
			Radio1$ (nth 6 *KT_Stl@)      ;Value radio 1
			Radio2$ (nth 7 *KT_Stl@)      ;Value radio 2
			Image1$ (nth 8 *KT_Stl@)	   ;Image value
			Value6$ (nth 9 *KT_Stl@)	   ;Rotation (Rot)
			Toggle2$ (nth 10 *KT_Stl@)	   ;Flip     (Flip)
	)

	(setq list1@ (KTS_Libary))
	(setq mainlist (mapcar 'car list1@))

	; Load the DCL file.
	(setq Dcl_Id% (load_dialog "KT_Stl.dcl"))
	(if (not (new_dialog "KT_Stl" Dcl_Id%))    ; Initialize the dialog.
		(exit)                                  ; Exit if this doesn't work
	)                                           ; work.



	; Preset data
			;; fill "popup" with CAR item of myList
			(start_list "list_1")
			(mapcar 'add_list mainlist)
			(end_list)

			;; fill "listbox" according to default value of "popup" (value
			;; of zero unless otherwise specified in the dcl definition)
		(if (= Value1$ "") (setq Value1$ (caar list1@)))
		(if (= Value2$ "") (setq Value2$ (car(cadr(car list1@)))))
		(if (= Value3$ "") (setq Value3$ 0))
		(if (= Value4$ "") (setq Value4$ 0))
		(if (= Value5$ "") (setq Value5$ 0))
		(if (= Radio1$ "") (setq Radio1$ "V_Front"))
		(if (= Radio2$ "") (setq Radio2$ "Draw_a"))
		(if (= Image1$ "") (setq Image1$ "HEA(HST)"))
		(if (= Value6$ "") (setq Value6$ "+0°"))
		(if (= Toggle2$ "") (setq Toggle2$ "0"))
		


	; Preset data
		(set_tile "ver_kts" (strcat "KiTek Steel v" (rtos KTS_version 2 2 ) " --- by Joakin Kirschen --- info@kitek.be"))
		(set_tile "Radio1" Radio1$)
		(set_tile "Radio2" Radio2$)
		;(set_tile "Rot" Value6$)
		(set_tile "Flip" Toggle2$)
		(KTS_set_tile_list "list_1" mainlist Value1$)
		(setq subitems (KTS_populate_list "list_2" Value3$ list1@ '("editbox")))
		(KTS_set_tile_list "list_2" subitems Value2$)
		(setq proplist (KTS_Proplist Value1$ Value3$ Value4$ list1@ ))
		(setq anglist (KTS_Rotlist Value5$))
		(KTS_set_tile_list "list_3" anglist Value6$)
		(setq Radio1$  (nth 0 (KTstl_modetile Value1$ Value1$ Radio1$ Value6$ Value5$ Toggle2$)))
		(setq Value6$ (nth 2 (KTstl_modetile Value1$ Value1$ Radio1$ Value6$ Value5$ Toggle2$)))
		(setq Toggle2$ (nth 3 (KTstl_modetile Value1$ Value1$ Radio1$ Value6$ Value5$ Toggle2$)))
		(setq Image1$ (KTS_upDateImage Value1$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))
		(KTS_upDateBanner)

	; Actions

			;; define callback to populate "listbox" according to
			;; users choice in the "popup" tile. Save list of items
			;; in order to extract an item from the list_box tile
			;; (also clear any choices in affected tiles when replacing list)
		(action_tile "list_1" "(setq subitems (KTS_populate_list \"list_2\" (atoi $value) list1@ '(\"editbox\")))
		(setq Value3$ (atoi $value))
		(setq temp Value1$)
		(setq Value4$ 0)
		(KTS_set_list_value \"mainlist\" \"Value1$\")
		(setq Value2$ (car subitems))
		(KTS_set_tile_list \"list_2\" subitems Value2$)
		(setq proplist (KTS_Proplist Value1$ Value3$ Value4$ list1@ ))
		(setq modetilelist (KTstl_modetile Value1$ Value1$ Radio1$ Value6$ Value5$ Toggle2$))
		(setq Value5$ (nth 1 modetilelist))
		(setq Value6$ (nth 2 modetilelist))
		(setq Radio1$ (nth 0 modetilelist))
		(setq Toggle2$ (nth 3 modetilelist))
		(setq Image1$ (KTS_upDateImage Value1$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))
		")

			;; define callback to populate "editbox" and save current
			;; choice in order to return it
		(action_tile "list_2" "(set_tile \"editbox\" (setq item (nth (setq Value4$ (atoi $value)) subitems)))
		(KTS_set_list_value \"subitems\" \"Value2$\")
		(setq proplist (KTS_Proplist Value1$ Value3$ Value4$ list1@ ))
		(setq Image1$ (KTS_upDateImage Value1$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))
		")
		
		(action_tile "list_3" "(KTS_set_list_value \"anglist\" \"Value6$\")
		(setq Image1$ (KTS_upDateImage Value1$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))
		")
		
		; bepaalt de view (front top back etc.)
		(action_tile "Radio1" "(setq Radio1$ $value)
		(setq modetilelist (KTstl_modetile Value1$ Value1$ Radio1$ Value6$ Value5$ Toggle2$))
		(setq Value5$ (nth 1 modetilelist))
		(setq Value6$ (nth 2 modetilelist))
		(setq anglist (KTS_Rotlist Value5$))
		(setq Image1$ (KTS_upDateImage Value1$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))
		")

		; bepaalt de positie van het insertiepunt
		(action_tile "Radio2" "(setq Radio2$ $value)
		(setq Image1$ (KTS_upDateImage Value1$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))
		")


		(action_tile "Flip" "(setq Toggle2$ $value)(setq Image1$ (KTS_upDateImage Value1$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))")
		(action_tile "cancel" "(setq ddiag 1)(done_dialog)")
		(action_tile "Draw_N" "(setq ddiag 2)(done_dialog)")
		(action_tile "Draw_E" "(setq ddiag 3)(done_dialog)")
		(action_tile "Settings"   "(setq ddiag 4)(done_dialog)")
		(action_tile "image2"   "(startapp \"explorer\" \"http://www.kitek.be\")")
		(setq Return# (start_dialog))
	; Unload Dialog
		(unload_dialog Dcl_Id%)

	;;;--- If the "Cancel" button was pressed

	(if (= ddiag 1)
		(princ "\n ...KT_Stl is cancelled. \n ")
	;	(exit)
	)
	
	(if (= ddiag 4)
		(progn
		(KTS_Settings1 1) 
		(exit)
		)
	)
	
	(setq Laylist (KTS_getlaylist (KTS_getslotpos)))
	(setq LayNewCo (nth 2 Laylist))
	(setq LayNewHi (nth 7 Laylist))
	(setq LayExCo (nth 12 Laylist))
	(setq LayExHi (nth 17 Laylist))
	
	(setq ColNewCo (KTSstl_findcol (nth 3 Laylist)(nth 4 Laylist)))
	(setq ColNewHi (KTSstl_findcol (nth 8 Laylist)(nth 9 Laylist)))
	(setq ColExCo (KTSstl_findcol (nth 13 Laylist)(nth 14 Laylist)))
	(setq ColExHi (KTSstl_findcol (nth 18 Laylist)(nth 19 Laylist)))
	
	(setq LtNewCo (nth 5 Laylist))	
	(setq LtNewHi (nth 10 Laylist))
	(setq LtExCo (nth 15 Laylist))
	(setq LtExHi (nth 20 Laylist))
	
	(setq LwNewCo (nth 6 Laylist))	
	(setq LwNewHi (nth 11 Laylist))
	(setq LwExCo (nth 16 Laylist))
	(setq LwExHi (nth 21 Laylist))
	
	(if (= ddiag 2)
		(progn
		(setq prestring (strcat (rtos KTS_version 2 2) "_"  "NEW_" LayNewCo "_" ColNewCo "_" LtNewCo "_" LayNewHi "_" ColNewHi "_" LtNewHi))
		(if (tblSearch "LAYER" LayNewCo)		
		(setvar "CLAYER" LayNewCo)			
		)		
		)
	)
	(if (= ddiag 3)
		(progn
		(setq prestring (strcat (rtos KTS_version 2 2) "_"  "EXI_" LayExCo "_" ColExCo "_" LtExCo "_" LayExHi "_" ColExHi "_" LtExHi))
		(if (tblSearch "LAYER" LayExCo)		
		(setvar "CLAYER" LayExCo)			
		)
		)
	)

	;;;--- If the "Okay" button was pressed
	(if (or (= ddiag 2) (= ddiag 3))
		(progn

		;;;--- Save settings
		(setq *KT_Stl@ (list nil Value1$ Value2$ Value3$ Value4$ Value5$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))
		(Cond
		(
		(= Radio1$ "V_Front")
		(Cond
			((= Value1$ "HEA") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEB") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEM") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPE") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPN") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPE") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPN") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L GZ") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L OZ") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "SHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "RHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "CHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist  prestring ddiag))
			(nil ())
			)
		)
		(
		(= Radio1$ "V_Top")
		(Cond
			((= Value1$ "HEA") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEB") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEM") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPE") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPN") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPE") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPN") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L GZ") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L OZ") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "SHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "RHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "CHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			(nil ())
			)
		)
		(
		(= Radio1$ "V_Bottom")
		(Cond
			((= Value1$ "HEA") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEB") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEM") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPE") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPN") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPE") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPN") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L GZ") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L OZ") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "SHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "RHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "CHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			(nil ())
			)
		)
		(
		(= Radio1$ "V_Section")
		(Cond
			((= Value1$ "HEA") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEB") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEM") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPE") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPN") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPE") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPN") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L GZ") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L OZ") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "SHS") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "RHS") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "CHS") (KTS_run2 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			(nil ())
			)
		)
		(
		(= Radio1$ "V_Back")
		(Cond
			((= Value1$ "HEA") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEB") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "HEM") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPE") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "IPN") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPE") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "UPN") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L GZ") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "L OZ") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "SHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "RHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "CHS") (KTS_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			(nil ())
			)
		)
		(nil ())
		)
	

	)
	)
	(princ)
	)
