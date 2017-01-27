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
;    Copyright (C) 2015 Joakin Kirschen
;;-----[ Deze functie altijd laten staan]------------------------------------
(defun KT_stl ()
(princ "KT_stl is loaded")
(princ)
)


(setq KTS_version 1.32)
(vl-load-com)

(defun C:KT_stl ( /  Test *Error*) 			;localize error handler
	(setq *Error* KT_stl_error)				;redefine local error handler
	(if (< (atof (getvar 'AcadVer)) 17.0)
    (progn(alert "This version of AutoCad is not supported!\nPlease upgrade to AutoCad 2008 or higher.")
	(setq Test 1))
	(setq Test 0)
	)
	(KTS_checkenv)
	(KTS_needupdate)
	(KTS_needbanner)
	;(KTS_checklicencedate)
	(if (= test 1) (exit)(KT_dialog))
	(KT_stl_error nil)						; normal, clean exit
	(princ)
)

(defun KT_stl_error (msg)
 (cond 
  ((not msg)) ; no error, normal exit
  ((member msg '("Function cancelled" "quit / exit abort"))) ; <esc> or (quit)
  (
  (alert (strcat "Error: " msg "\nIf the problem persists contact developer at www.kitek.be."))
  ); error, display it
 ) 
 (princ)
)

(defun KTS_checkenv (/ lst)	
	(setq col (KTS_Colorlist))
	(setq lt  (KTS_Linetypelist))
	(setq lst (KTS_getlaylist (KTS_getslotpos)))
	(if (and (member (nth 3 lst) col)(member (nth 8 lst) col)(member (nth 13 lst) col)(member (nth 18 lst) col)
	(member (nth 25 lst) col)(member (nth 5 lst) lt)(member (nth 10 lst) lt)(member (nth 15 lst) lt)(member (nth 20 lst) lt) )  
	nil
	(KTS_reset)
	)
)



(defun KTS_reset ( / )		
	(setenv "KTS_UpdateSettings" (vl-princ-to-string 2))
	(setenv "KTS_Datestamp" (vl-prin1-to-string (atoi (substr (rtos (getvar "CDATE") 2 0) 1 8))))
	(setenv "KTS_Slot" (vl-princ-to-string 1))
	(setenv "KTS_LayerSettings1" (vl-prin1-to-string '(1 "Slot 1" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(setenv "KTS_LayerSettings2" (vl-prin1-to-string '(2 "Slot 2" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(setenv "KTS_LayerSettings3" (vl-prin1-to-string '(3 "Slot 3" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(setenv "KTS_LayerSettings4" (vl-prin1-to-string '(4 "Slot 4" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(setenv "KTS_LayerSettings5" (vl-prin1-to-string '(5 "Slot 5" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(setenv "KTS_LayerSettings6" (vl-prin1-to-string '(6 "Slot 6" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(setenv "KTS_LayerSettings7" (vl-prin1-to-string '(7 "Slot 7" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(setenv "KTS_LayerSettings8" (vl-prin1-to-string '(8 "Slot 8" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(setenv "KTS_LayerSettings9" (vl-prin1-to-string '(9 "Slot 9" "KTS_NEW_CO" "Red" "-" "Continuous" "Default" "KTS_NEW_HI" "Red" "-" "Continuous" "Default" "KTS_EX_CO" "Red" "-" "Continuous" "Default" "KTS_EX_HI" "Red" "-" "Continuous" "Default" "0" "350" "KTS_TEXT" "Yellow" "-" "isocpeur" "0" "*")))
	(alert "Environment has been (re)set.\nPlease restart KiTeK Steel.\nIf problem persists contact us at www.kitek.be.")
)

(defun KTS_getlaylist	(Slot / LayList)
	(if (setq LayList (getenv (strcat "KTS_LayerSettings" (vl-prin1-to-string Slot))))
		(progn 
			(setq LayList (read LayList)) 
			(if (= length Laylist 28)(progn (setq LayList(append LayList (list "0" "*")))(KTS_savelaylist LayList)))
			(if (= length Laylist 29)(progn (setq LayList(append LayList (list "*")))(KTS_savelaylist LayList)))
		)
		(progn
		(KTS_reset)
		(setq LayList (read (getenv "KTS_LayerSettings1")))
		)
	)
	Laylist
)

(defun KTS_savelaylist	(List1 / Laylist Index Temp)
(setq Index (car List1))
(setenv (strcat "KTS_LayerSettings"  (itoa Index)) (vl-prin1-to-string List1))
)

(defun KTS_getslotlist	( / i LayList Slotname Slotlist)
(setq Slotlist '())
(setq index 9)
(while (> index 0)
(setq Slotname (cadr(read (getenv (strcat "KTS_LayerSettings" (itoa index))))))
(setq Slotlist (cons  Slotname Slotlist))
(setq index (1- index))
)
Slotlist
)

(defun KTS_getslotpos ( / slotpos)
(if (setq slotpos (getenv "KTS_Slot" ))
	(setq slotpos (read slotpos))
	(progn
		(KTS_reset)
		(setq slotpos 1)
	)
)
slotpos
)

(defun KTS_saveslotpos	(Index / )
(setenv "KTS_Slot" (vl-prin1-to-string Index))
)

(defun c:KTS_link ()
		(command "._browser" "http://www.kitek.be")
		(princ)
)

(defun c:KTSGMI ()
    (KTS_savelaylist (list 1 "GM" "AC-2100-STAAL-PROF-co-35" "Yellow" "-" "Continuous" "Default" "AC-2100-STAAL-PROF-hi2-12" "Green" "-"  "Hidden2" "Default" "AC-0000-BESTAAND-co-06" "Red" "-"  "Continuous" "Default" "AC-0000-BESTAAND-hi2-06" "Red" "-" "Hidden2" "Default" "0" "2.5" "AC-0300-TEKST-35" "Yellow" "-" "isocpeur" "1" "*"))
	(KTS_savelaylist (list 2 "Arcelor" "35C" "Red" "-" "Continuous" "0.35 mm" "10H2" "Other" "9" "Hidden2" "0.09 mm" "10C" "Other" "9" "Continuous" "0.09 mm" "10H2" "Other" "9" "Hidden2" "0.09 mm" "0" "2.5" "Text" "White" "-" "isocpeur" "1" "*"))
)

;make counter for not able to connect
(defun KTS_checklicencedate ( / 1four 2four 3four 4four ddiag editset today licdate)
	
	(if (findfile "licence.vlx")
		(progn 
		(if (not licence.vlx)(load "licence.vlx"))
		(setq licdate (KTS_LicExpireDate))
		(setq today (atoi (rtos (getvar "CDATE") 2 0)))
		(if (> (+ today 10) licdate)
				(progn
					(if (= (KTS_confirmlicence ) 1) ;licence confirmed
					(progn
					(princ)
					;(setenv "KTS_Datestamp3" (vl-prin1-to-string  (atoi (substr (rtos (getvar "CDATE") 2 0)1 8))))
					)
					;(if (KTS_urlping "kitek.be")
					(KTS_enterlicence)
					)
				)
		)
		)
		(KTS_enterlicence)
	)
		
)


(defun KTS_enterlicence ( / 1four 2four 3four 4four ddiag editset )
	
	(setq Dcl_Id% (load_dialog "KT_Stlsettings.dcl"))
	(if (not (new_dialog "KTSLicence" Dcl_Id%))    ; Initialize the dialog.
		(exit)                                  ; Exit if this doesn't work
	)
	
	(if (getvar "lkey")
		(progn
		(if (not(= (strlen (getvar "lkey")) 16))
			(progn
			(setq 1four "")
			(setq 2four "")
			(setq 3four "")
			(setq 4four "")
			)
		)
		)
	)
	
	(action_tile "1four" "(KTS_check_editreal \"1four\")(setq editset 1)")
	(action_tile "2four" "(KTS_check_editreal \"2four\")(setq editset 1)")
	(action_tile "3four" "(KTS_check_editreal \"3four\")(setq editset 1)")
	(action_tile "4four" "(KTS_check_editreal \"4four\")(setq editset 1)")
	(action_tile "cancel" "(setq ddiag 1)(done_dialog)")
	(action_tile "verify" "(setq ddiag 2)(done_dialog)")
	
	(setq Return# (start_dialog))
	; Unload Dialog
	(unload_dialog Dcl_Id%)	; work.
	
	(if (= ddiag 2)
		(progn
			(if (= (KTS_confirmlicence ) 1)
				(progn
				(setenv "lkey" (strcat 1four 2four 3four 4four))
				)
			)
		)
	)
	
)

;(defun KTS_downllicence (subpath / )
;(setq scriptfile (findfile "KT_dl.vbs")) 
;(startapp (strcat "CSCRIPT.EXE //nologo " (vl-prin1-to-string scriptfile) " " (vl-prin1-to-string (strcat "http://www.kitek.be/" subpath "/licence.vlx"))))
;)

;(defun KTS_confirmlicence ( / lic)
;(setq LicCode 999999)
;(if (getenv "lkey")
;	(progn
;		(setq subpath (substr (getenv "lkey") 1 4)) 
;		(if (findfile "licence.vlx")
;			(progn (if (not licence.vlx)(load "licence.vlx"))(setq LicCode (KTS_LicCode)))
;			(progn 
;				(KTS_downllicence subpath)
;				(if (not licence.vlx)
;					(if (findfile "licence.vlx")
;						(progn (load "licence.vlx")(setq LicCode (KTS_LicCode)))
;						(progn (princ "No correct licence file found on registration server.\nPlease enter new licence code") (KTS_enterlicence))
;					)
;					(setq LicCode (KTS_LicCode))
;				)
;			)
;		)
;		(if (= (getenv "lkey") LicCode)
;			(progn 
;					(if (< KTS_LicExpireDate (atoi (rtos (getvar "CDATE") 2 0)))
;						3 ;licence expired
;						1 ;vallid licence
;					)
;			)
;			0 ;invallid licence
;		)
;	)
;	(progn
;	0 ;invallid licence
;	)
;);
;(princ)
;)

(defun KT_dialog (/ Dcl_Id% ddiag prestring Radio1$ Radio2$ Value1$ Value2$ Value3$ Value4$ Value5$ Image1$ Value6$ Toggle2$ Return# list1@ mainlist subitems ddiag temp anglist Laylist LayNewCo LayNewHi LayExCo LayExHi ColNewCo ColNewHi ColExCo ColNewHi ColExCo ColExHi LtNewCo LtNewHi LtExCo LtExHi LwNewCo LwNewHi LwExCo LwExHi Modetilelist)
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
	
;(defun KTS_layrenameold (layerin layerout / s )
;        (KTS_ApplytoBlockObjects
;            (vla-get-blocks (vla-get-activedocument (vlax-get-acad-object)))
;            (cdr (assoc 2 (entget (entlast))))
;           '(lambda ( obj )
;                 (if  (eq layerin (vla-get-layer obj ))  
;					(vla-put-layer obj layerout)
;				 )
;            )
;        )
;	(command "regen")
;    (princ)
;)

(defun KTS_layrename (layerin layerout / ELST FLST BNAM); ENAM ESEL)
	(setq   
			;ESEL (entlast)
			;ENAM (car ESEL)
			ELST (entget (entlast))
			BNAM (cdr (assoc 2 ELST))
			FLST nil
	)
  (if (not (member BNAM FLST))
    (progn
      (setq FLST  (cons BNAM FLST)
	    BENAM (tblobjname "block" BNAM)
      )
      (while (setq BENAM (entnext BENAM))
;					(print (entget BENAM))
	(if (= (cdr (assoc 0 (entget BENAM))) "INSERT")
	  (progn
	    (vla-put-layer (vlax-ename->vla-object BENAM) "0")
;	    (fix1 (cdr (assoc 2 (entget BENAM))))
	  )
	  (progn
	    ;(vla-put-color (vlax-ename->vla-object BENAM) 256)
	    ;(vla-put-layer (vlax-ename->vla-object BENAM) "0")
				(if (= layerin (strcase(cdr (assoc 8 (entget BENAM)))))
				(progn
                (vla-put-layer (vlax-ename->vla-object BENAM) layerout)
				(vla-put-color (vlax-ename->vla-object BENAM) 256)
				)
				)

	  )
	)
      )
    )
  )
  (vl-cmdf "regen")
  (princ)
)



(defun KTS_ApplytoBlockObjects ( blks name func / def result )
    (setq func (eval func))
    (if (not (vl-catch-all-error-p (setq def (vl-catch-all-apply 'vla-item (list blks name)))))
        (vlax-for obj def (setq result (cons (func obj) result)))
    )
    (reverse result)
)

(defun KTSstl_findcol ( str1 str2 / returnval )
	(Cond
		((= str1 "Blue") (setq returnval "5"))
		((= str1 "Green") (setq returnval "3"))
		((= str1 "Magenta") (setq returnval "6"))
		((= str1 "Red") (setq returnval "1"))
		((= str1 "Cyan") (setq returnval "4"))
		((= str1 "White") (setq returnval "7"))
		((= str1 "Yellow") (setq returnval "2"))
		((= str1 "Other") (setq returnval str2))
		(nil ())
	)
	returnval
	)
	
(defun Unitfactor ( / insuits factor)
(setq insunits (getvar "INSUNITS"))
(setq factor 1)
(cond
    ((= 1 insunits) (setq factor (/ 1 25.4)))     ;If Inches - set to Architectural 1/16
    ((= 2 insunits) (setq factor (/ 1 304.8)))     ;If Feet - set to Architectural 1/32
    ((= 3 insunits) (setq factor (/ 1 1609344)))     ;If Miles - set to Fractional 1/256
    ((= 4 insunits) (setq factor 1))     ;If Millimeters - set to Decimal 0
    ((= 5 insunits) (setq factor 0.1))     ;If Centimeters - set to Decimal 0.0
    ((= 6 insunits) (setq factor 0.001))     ;If Meters - set to Decimal 0.000
    ((= 7 insunits) (setq factor 0.000001))     ;If Kilometers - set to Decimal 0.000
    ((= 8 insunits) (setq factor (/ 1000 25.4)))     ;If Micro Inches - set to Decimal 0 
    ((= 9 insunits) (setq factor (/ 100 25.4)))     ;If Mils - set to Decimal 0
    ((= 10 insunits) (setq factor (/ 1 914.4)))     ;If Yards - set to Architectural 1/64
    ((= 11 insunits) (setq factor 0.0000001))     ;If Angstroms - set to Decimal 0
    ((= 12 insunits) (setq factor 1000000))     ;If Nanometers - set to Decimal 0
    ((= 13 insunits) (setq factor 1000))     ;If Microns - set to Decimal 0
    ((= 14 insunits) (setq factor 0.01))     ;If Decimeters - set to Decimal 0.00
    ((= 15 insunits) (setq factor 0.0001))     ;If Dekameters - set to Decimal 0.0
    ((= 16 insunits) (setq factor 0.00001))     ;If Hectometers - set to Decimal 0.00
    ((= 17 insunits) (setq factor 0.000000000001))     ;If Gigameters - set to Decimal 0.000000
    ((= 18 insunits) (setq factor 000000000000000.668458712))     ;If Astronomical Units - set to Scientific 0.000E+01
    ((= 19 insunits) (setq factor 0000000000000000000.10570234557733))     ;If Light Years - set to Scientific 0.000E+01
    ((= 20 insunits) (setq factor 00000000000000000000.324077929))     ;If Parsecs - set to Scientific 0.000E+01
)
factor
)
	
(defun KTS_run1 (proftype profile view draw rot flip props  prestring ddiag / ppt1 ppt2 ppt3 osv dist ang  iptx ipty bptx bpty ipt width height fl ang2)
	(if (and (setq ppt1 (getpoint "\nFirst insertion point"))(setq ppt2 (getpoint ppt1 "\nSecond insertion point")))
	(progn
	(setq dist (distance ppt1 ppt2))
	(if (> (car ppt1) (car ppt2))
		(progn
			(setq ppt3 ppt1)
			(setq ppt1 ppt2)
			(setq ppt2 ppt3)
		)
	)
	(setq factor (Unitfactor))
	(setq height (* (nth 1 props) factor))
	(setq width (* (nth 2 props) factor))
	(setq ang  (*(/ (angle ppt1 ppt2)Pi)180))
	(setq ang2 (angle ppt1 ppt2))
	(setq bptx (car ppt1))
	(setq bpty (cadr ppt1))
	(setq fl 1)
	(if (= flip "1")
	(progn  (setq ang (+ ang 180)) (setq bptx (car ppt2)) (setq bpty (cadr ppt2)) (setq fl -1))
	)

	(Cond
		((= view "V_Front") ;front
		(progn
		(Cond
			((= draw "Draw_a") (progn   (setq ipty (-(+ bpty (*(sin ang2) 500 factor fl)) (*(cos ang2)(/ height 2) )))
						(setq iptx   (+ bptx (*(cos ang2) 500 factor fl)  (*(sin ang2)(/ height 2) )))
						)
		)
			((= draw "Draw_b") (progn   (setq iptx (+ bptx   (*(cos ang2) 500 factor fl)))
						(setq ipty (+ bpty   (*(sin ang2) 500 factor fl)))
					)
		)
			((= draw "Draw_c") (progn
						(setq ipty (+(+ bpty (*(sin ang2) 500 factor fl)) (*(cos ang2)(/ height 2) )))
						(setq iptx (-(+ bptx (*(cos ang2) 500 factor fl)) (*(sin ang2)(/ height 2) )))
						)
		)
			(nil ())
			)
		(setq ipt (list iptx ipty))
		(Cond
		((= proftype "HEA") (KTS_InsDynBlock "HEA_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "HEB") (KTS_InsDynBlock "HEB_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "HEM") (KTS_InsDynBlock "HEM_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "IPE") (KTS_InsDynBlock "IPE_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "IPN") (KTS_InsDynBlock "IPN_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "UPE") (KTS_InsDynBlock "UPE_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "UPN") (KTS_InsDynBlock "UPN_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "SHS") (KTS_InsDynBlock "SHS_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "RHS") (KTS_InsDynBlock "RHS_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "CHS") (KTS_InsDynBlock "CHS_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "L GZ") (KTS_InsDynBlock "LGZ_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 1 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring ddiag))
		((= proftype "L OZ") (KTS_InsDynBlock "LOZ_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 1 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring ddiag))
		(nil ())
		))
		) ;end view a


		((= view "V_Top") ;top
		(progn
		(Cond
			((= draw "Draw_a") (progn   (setq ipty (-(+ bpty (*(sin ang2)500 factor fl)) (*(cos ang2)(/ width 2) )))
						(setq iptx   (+ bptx (*(cos ang2)500 factor fl)  (*(sin ang2)(/ width 2) )))
					)
		)
			((= draw "Draw_b") (progn   (setq iptx (+ bptx (*(cos ang2)500 factor fl)))
						(setq ipty (+ bpty (*(sin ang2)500 factor fl)))
					)
		)
			((= draw "Draw_c") (progn   (setq ipty (+(+ bpty (*(sin ang2)500 factor fl)) (*(cos ang2)(/ width 2) )))
						(setq iptx (-(+ bptx (*(cos ang2)500 factor fl)) (*(sin ang2)(/ width 2) )))
					)
		)
			(nil ())
			)
		(setq ipt (list iptx ipty))
		(Cond
		((= proftype "HEA") (KTS_InsDynBlock "HEA_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "HEB") (KTS_InsDynBlock "HEB_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "HEM") (KTS_InsDynBlock "HEM_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "IPE") (KTS_InsDynBlock "IPE_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "IPN") (KTS_InsDynBlock "IPN_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "UPE") (KTS_InsDynBlock "UPE_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "UPN") (KTS_InsDynBlock "UPN_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "RHS") (KTS_InsDynBlock "RHS_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))		
		((= proftype "L GZ") (KTS_InsDynBlock "LGZ_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 2 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring ddiag))
		((= proftype "L OZ") (KTS_InsDynBlock "LOZ_TOP" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 2 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring ddiag))
			(nil ())
			)
		)
		) ;end view Top

		((= view "V_Back")
		(progn
		(Cond
			((= draw "Draw_a") (progn   (setq ipty (-(+ bpty (*(sin ang2)500 factor)) (*(cos ang2)(/ height 2) )))
						(setq iptx   (+ bptx (*(cos ang2)500 factor)  (*(sin ang2)(/ height 2) )))
		)
			)
			((= draw "Draw_b") (progn   (setq iptx (+ bptx (*(cos ang2)500 factor fl)))
						(setq ipty (+ bpty (*(sin ang2)500 factor fl)))
					)
		)
			((= draw "Draw_c") (progn   (setq ipty (+(+ bpty (*(sin ang2)500 factor)) (*(cos ang2)(/ height 2) )))
						(setq iptx (-(+ bptx (*(cos ang2)500 factor)) (*(sin ang2)(/ height 2) )))
						)
		)
			(nil ())
			)
		(setq ipt (list iptx ipty))
		(Cond
		((= proftype "UPE") (KTS_InsDynBlock "UPE_BACK" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "UPN") (KTS_InsDynBlock "UPN_BACK" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "L GZ") (KTS_InsDynBlock "LGZ_BACK" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 1 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring ddiag))
		((= proftype "L OZ") (KTS_InsDynBlock "LOZ_BACK" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 1 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring ddiag))
		(nil ())
		))
		) ;end view back
		
		((= view "V_Bottom")
		(progn
		(Cond
			((= draw "Draw_a") (progn   (setq ipty (-(+ bpty (*(sin ang2)500 factor)) (*(cos ang2)(/ height 2) )))
						(setq iptx   (+ bptx (*(cos ang2)500 factor)  (*(sin ang2)(/ height 2) )))
		)
			)
			((= draw "Draw_b") (progn   (setq iptx (+ bptx (*(cos ang2)500 factor fl)))
						(setq ipty (+ bpty (*(sin ang2)500 factor fl)))
					)
		)
			((= draw "Draw_c") (progn   (setq ipty (+(+ bpty (*(sin ang2)500 factor)) (*(cos ang2)(/ height 2) )))
						(setq iptx (-(+ bptx (*(cos ang2)500 factor)) (*(sin ang2)(/ height 2) )))
						)
		)
			(nil ())
			)
		(setq ipt (list iptx ipty))
		(Cond
			((= proftype "L OZ") (KTS_InsDynBlock "LOZ_BOTTOM" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 2 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring))
			(nil ())
			))
		) ;end view back
		
	)	  ;end cond
	)
	(exit)
	)
	(princ)
	)				;end run 1


(defun KTS_run2 (proftype profile view draw rot flip props prestring ddiag / ppt1 ppt2 osv dist ang  iptx ipty ipt width height flipstate)
	(if(setq ppt1 (getpoint "\nInsertion point"))
	(progn
	(princ "\n")
	(setq factor (Unitfactor))
	(setq width (* (nth 2 props) factor))
	(if (= flip "1")
	(setq flipstate T)
	(setq flipstate F)
	)

	(if (and (= rot "+0°") (= flip "0"))
		(progn 
			(setq ang 0)
			(setq height (* (nth 1 props) factor))
			(if 			
			(or (= proftype "UPE") (= proftype "UPN"))
		    (progn
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1)))
			(nil ())
			)			
			(setq iptx (car ppt1))				
			)
			)
			(if 			
			(or (= proftype "RHS")(= proftype "SHS")(= proftype "CHS"))
		    (progn
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_b") (setq ipty (cadr ppt1)))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			(nil ())
			)			
			(setq iptx (car ppt1))				
			)
			)
			(if 
			(or (= proftype "L GZ") (= proftype "L OZ"))
			(progn
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1)))
			(nil ())
			)			
		    (setq iptx (- (car ppt1) width ))			
			)
			)
			
			(if 
			(or (= proftype "HEA") (= proftype "HEB") (= proftype "HEM") (= proftype "IPE") (= proftype "IPN"))
			(progn
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1)))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
			)						
		    (setq iptx (car ppt1))
			)
			)
		)
	)

	(if (and (= rot "+90°") (= flip "0"))
		(progn 
			(setq ang 90)
			(setq height (* (nth 2 props) factor))
			(if (or (= proftype "L GZ") (= proftype "L OZ"))
			(progn
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1)))
			(nil ())
			)
		    (setq iptx (car ppt1))			
			)
			)
			(if 
			(or (= proftype "HEA")  (= proftype "HEB") (= proftype "HEM") (= proftype "IPE") (= proftype "IPN")(= proftype "UPE") (= proftype "UPN")(= proftype "RHS"))
			(progn
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_b") (setq ipty (cadr ppt1)))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			(nil ())
			)			
		    (setq iptx (- (car ppt1) (/ (nth 1 props) 2.0)))
			)
			)
			(if 
			(or (= proftype "UPE") (= proftype "UPN"))
			(progn
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1)  height )))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1)  (/ height 2))))
			((= draw "Draw_c") (setq ipty (cadr ppt1)))
			(nil ())
			)			
		    (setq iptx (+ (car ppt1) (/ (nth 1 props) 2.0)))
			)
			)
		)
	)
	
	(if (and (= rot "+180°") (= flip "0"))		;only for angles
		(progn (setq ang 180)
			(setq height (* (nth 1 props) factor))
			(setq iptx (+ (car ppt1) width ))
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1)))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
		)
		)
	)
	
	(if (and (= rot "+270°") (= flip "0"))
		(progn (setq ang 270)
			(setq height (* (nth 2 props) factor))
			(setq iptx  (car ppt1) )
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1)))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
		)
		)
	)

	(if (and (= rot "+0°") (= flip "1"))
		(progn 
			(setq height (* (nth 1 props) factor))
			(if (or (= proftype "UPE") (= proftype "UPN"))
		    (progn
			(setq iptx (car ppt1))(setq ang 180)
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1)))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
			)
			))
			(if (or (= proftype "L GZ") (= proftype "L OZ"))
		    (progn
			(setq iptx  (car ppt1) )(setq ang 0)
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1)))
			(nil ())
			)
			))
			(if (or (= proftype "HEA") (= proftype "HEB") (= proftype "HEM") (= proftype "IPE") (= proftype "IPN"))
		    (progn
			(setq iptx (+ (car ppt1) (/ width 2.0)))
			(setq ang 180)
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1)))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
			)
			))
		)
	)
	
	(if (and (= rot "+90°") (= flip "1"))
		(progn 
			(setq height (* (nth 2 props) factor))
			(if (or (= proftype "UPE") (= proftype "UPN"))
		    (progn
			(setq iptx (- (car ppt1) (/ (nth 1 props) 2.0)))
			(setq ang 270)
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1)))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
			)
			))
			(if (or (= proftype "L GZ") (= proftype "L OZ"))
		    (progn
			(setq iptx  (car ppt1) )(setq ang 90)
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1)))
			(nil ())
			)
			))
			(if (or (= proftype "HEA") (= proftype "HEB") (= proftype "HEM") (= proftype "IPE") (= proftype "IPN"))
		    (progn
			(setq iptx (- (car ppt1) (/ (nth 1 props) 2.0)))
			(setq ang 270)
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1)))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
			))
			)
		)
	)
	
	(if (and (= rot "+180°") (= flip "1"))
		(progn 
			(setq height (* (nth 1 props) factor))
			(if (or (= proftype "UPE") (= proftype "UPN"))
		    (progn
			(setq iptx (car ppt1))
			(setq ang 0)
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1)))
			(nil ())
			)
			))
			(if (or (= proftype "L GZ") (= proftype "L OZ"))
		    (progn
			(setq iptx  (car ppt1) )(setq ang 180)
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1) ))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
			)
			))
			(if (or (= proftype "HEA") (= proftype "HEB") (= proftype "HEM") (= proftype "IPE") (= proftype "IPN"))
		    (progn
			(setq iptx (- (car ppt1) (/ width 2.0)))
			(setq ang 0)
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1)))
			(nil ())
			)
			)
			)
		)
	)
	
	(if (and (= rot "+270°") (= flip "1"))
		(progn 
			(setq height (* (nth 2 props) factor))
			(if (or (= proftype "UPE") (= proftype "UPN"))
		    (progn
			(setq iptx (+ (car ppt1) (/ (nth 1 props) 2.0)))
			(setq ang 90)
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1) ))
			(nil ())
			)
			))
			(if (or (= proftype "L GZ") (= proftype "L OZ"))
		    (progn
			(setq iptx  (car ppt1) )(setq ang 270)
			(Cond
			((= draw "Draw_a") (setq ipty (cadr ppt1) ))
			((= draw "Draw_b") (setq ipty ( + (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty ( + (cadr ppt1) height)))
			(nil ())
			)
			))
			(if (or (= proftype "HEA") (= proftype "HEB") (= proftype "HEM") (= proftype "IPE") (= proftype "IPN"))
		    (progn
			(setq iptx (+ (car ppt1) (/ (nth 1 props) 2.0)))
			(setq ang 90)
			(Cond
			((= draw "Draw_a") (setq ipty ( - (cadr ppt1) height)))
			((= draw "Draw_b") (setq ipty ( - (cadr ppt1) (/ height 2.0))))
			((= draw "Draw_c") (setq ipty (cadr ppt1) ))
			(nil ())
			))
			)
		)
		(princ)
	)

	(setq ipt (list iptx ipty))
	(Cond
		((= proftype "HEA") (KTS_InsDynBlock "HEA_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "HEB") (KTS_InsDynBlock "HEB_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "HEM") (KTS_InsDynBlock "HEM_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "IPE") (KTS_InsDynBlock "IPE_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "IPN") (KTS_InsDynBlock "IPN_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))		
		((= proftype "UPE") (KTS_InsDynBlock "UPE_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "UPN") (KTS_InsDynBlock "UPN_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "SHS") (KTS_InsDynBlock "SHS_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))		
		((= proftype "RHS") (KTS_InsDynBlock "RHS_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "CHS") (KTS_InsDynBlock "CHS_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" profile)) prestring ddiag))
		((= proftype "L GZ") (KTS_InsDynBlock "LGZ_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 1 props)2 0)))								(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))(cons "FlipV" flipstate)) prestring ddiag))
		((= proftype "L OZ") (KTS_InsDynBlock "LOZ_SECTION" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 1 props)2 0) " x " (rtos(nth 2 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))(cons "FlipV" flipstate)) prestring ddiag))
		(nil ())
	))
	(exit)
	)
	(princ)
	)				;end run 2

	;************************************************************************************

	;;; Function to insert block with Dynamic Parameters Set
	;;; Use example:
	;;; (KTS_InsDynBlock "test" '(("Angle" . 120.0) ("Visibility" . "VS1") ("Position X" . 200.0) ("Distance" . 50.0) ("Distance2" . 40.0) ("X Distance" . 35.0) ("Angle1" . 30.0) ("Flip state" . T) ("Lookup" . "Test")))
	;;; (Add Error handling)
(defun KTS_InsDynBlock (bName position rotation params prestring ddiag / Laylist LayNewCo LayNewHi LayExCo LayExHi ColNewCo ColNewHi ColExCo ColExHi LtNewCo LtNewHi 
LtExCo LtExHi LwNewCo LwNewHi LwExCo LwExHi snap en eo paramCol p v bNameNew *error*)

	(defun *error* ( msg )
	
		(if old_snapmode (setvar "snapmode" old_snapmode))
		(if old_units (setvar "insunits" old_units))
		(if old_osmode (setvar "osmode" old_osmode))
		
		(if (not (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*"))
			(princ (strcat "\n** Error: " msg " **"))
		)
    (princ)
	)

	(setq old_snapmode (getvar "snapmode"))
	(setq old_units (getvar "insunits"))
	(setq old_osmode (getvar "osmode"))
	
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

	(setvar "snapmode" 0)
	;(setvar "insunits" 4)
	(setvar "osmode" 0)

	(setq bNameNew (strcat prestring "_" bName))

	(and (or (tblsearch "block" bName)(tblsearch "block" bNameNew)(findfile (strcat bName ".DWG")))
	
	(progn
		(if (tblsearch "block" bNameNew)
			(command "_.INSERT" bNameNew position "1" "1" rotation) ;Start Insert command
			(command "_.INSERT" (strcat bNameNew "=" bName) position "1" "1" rotation) ;Start Insert command
		)
		
		(if (= ddiag 2)
			(progn
			(if (tblSearch "LAYER" "KTS_EX_HID")
			(progn		
			(KTS_MLayer LayNewHi ColNewHi LtNewHi LwNewHi 1)			
			(KTS_layrename "KTS_EX_HID" LayNewHi)
			)
			)
			
			(if (tblSearch "LAYER" "KTS_EX_VIS")
			(progn
			(KTS_MLayer LayNewCo ColNewCo LtNewCo LwNewCo 1)	
			(KTS_layrename "KTS_EX_VIS" LayNewCo)
			)
			)		
			)
		)
		(if (= ddiag 3)
			(progn		
			(if (tblSearch "LAYER" "KTS_EX_HID")
			(progn		
			(KTS_MLayer LayExHi ColExHi LtExHi LwExHi 1)	
			(KTS_layrename "KTS_EX_HID" LayExHi)
			)
			)		
			(if (tblSearch "LAYER" "KTS_EX_VIS")
			(progn
			(KTS_MLayer LayExCo ColExCo LtExCo LwExCo 1)	
			(KTS_layrename "KTS_EX_VIS" LayExCo)
			)
			)
			)
		)

	(while (> (getvar "CMDACTIVE") 0) (command pause)) ;Let user pick points, scale, rotation
	;; Check if no error occurred, e.g. wrong block
	(if (and (setq en (entlast)) ;Get last entity
			(setq eo (vlax-ename->vla-object en)) ;Convert to COM object
			(= (vla-get-ObjectName eo) "AcDbBlockReference") ;Check if block
			(= (strcase (vla-get-EffectiveName eo)) (strcase bNameNew)) ;Correct block
			(setq paramCol (vla-GetDynamicBlockProperties eo)) ;Get the parameters
			(setq paramCol (vlax-variant-value paramCol)) ;Convert variant to SafeArray
			(>= (vlax-safearray-get-u-bound paramCol 1) 0) ;Check if there are parameters
			(setq paramCol (vlax-safearray->list paramCol)) ;Convert to list
		) ;_ end of and
		(progn
		(foreach p paramCol ;Step through list
			;; Check if current parameter is to be set
			(if (setq v (assoc (vla-get-PropertyName p) params)) ;Get the value
			(cond
				((= (vla-get-UnitsType p) 0) ;String / Flip State
				(if (= (vlax-variant-type (vla-get-Value p)) 2) ;If integer - then Flip State
				(if (cdr v) ;If to flip
					(vla-put-Value p (vlax-make-variant 1 vlax-vbInteger)) ;Set the value 1 = True
					(vla-put-Value p (vlax-make-variant 0 vlax-vbInteger)) ;Set the value 0 = False
					)
				(vla-put-Value p (vlax-make-variant (cdr v) vlax-vbString)) ;Set the value
				)
				)
				((= (vla-get-UnitsType p) 1) ;Angle
				(vla-put-Value p (vlax-make-variant (* (/ (cdr v) 180.0) pi) vlax-vbDouble)) ;Set the value
				)
				((= (vla-get-UnitsType p) 2) ;Distance
				(vla-put-Value p (vlax-make-variant (cdr v) vlax-vbDouble)) ;Set the value
				)
			) ;_ end of cond
			) ;_ end of if
			(vlax-release-object p) ;Release the COM object handle
		) ;_ end of foreach
		(vlax-release-object eo) ;Release the COM object handle
		) ;_ end of progn
		(princ "\nSome error occurred, could not insert or set parameters.")
	) ;_ end of if

	))
	
	(setvar "snapmode" old_snapmode)
	;(setvar "insunits" old_units)
	(setvar "osmode" old_osmode)
	
	(princ)
	) ;_ end of defunThere doesn't seem to be any values for Alignment and Basepoint. But then I wouldn't expect any



	;************************************************************************************
(defun KTS_set_tile_list (KeyName$ ListName@ Selected / Item)
	(start_list KeyName$ 3)
	(mapcar 'add_list ListName@)
	(end_list)
	(foreach Item (if (listp Selected) Selected (list Selected))
	(if (member Item ListName@)
		(set_tile KeyName$ (itoa (- (length ListName@) (length (member Item ListName@)))))
	);if
	);foreach
	);defun KTS_set_tile_list

	;************************************************************************************
	;-------------------------------------------------------------------------------
	; KTS_set_list_value - Sets SentVar$ to the item selected in SentList$
	; Arguments: 2
	;   SentList$ = String of the list variable name
	;   SentVar$ = String of the variable name
	; Syntax: (KTS_set_list_value "ListName" "Variable")
	;-------------------------------------------------------------------------------
(defun KTS_set_list_value (SentList$ SentVar$ / SaveVar$ SubList@)
	(setq SubList@ (eval (read SentList$)))
	(setq SaveVar$ (eval (read SentVar$)))
	(set (read SentVar$) (nth (atoi $value) SubList@))
	(if (= (eval (read SentVar$)) "")
		(progn
		(set (read SentVar$) SaveVar$)
		(KTS_set_tile_list $key SubList@ SaveVar$)
		);progn
	);if
	(princ)
	);defun KTS_set_list_value

	;************************************************************************************
(defun KTS_populate_list (tile item lst cleartiles / sublst level1 level2)
	(setq level1 (nth item lst))
	(setq level1 (vl-remove  (car level1) level1))
	(setq sublst(mapcar 'car level1))
	(start_list tile)
	(mapcar 'add_list sublst)
	(end_list)
	;; clear any affected tiles
	(foreach n cleartiles
		(set_tile n "")
	)
	;; return sublist
	sublst
	)

	;************************************************************************************

(defun KTstl_modetile (current future view rot1 rot2 flip / anglist )

	(Cond
		(
			(= future "HEA")   											;instellingen HEA
			(mode_tile "V_Back" 1)   									;disable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (or (= view "V_Back")(= view "V_Bottom"))
			(progn(set_tile "Radio1" "V_Front")(setq view "V_Front"))
			) ;als op back dan op front view
			(if (= view "V_Section")									;als sectie dan rotatie
				(progn 
					(mode_tile "list_3" 0)
					(if (= rot2 1) (progn (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
								   (progn (setq rot2 1) (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
					)
				)
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)
			(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))											;geen flip
		)
		
		(
			(= future "SHS")   											;instellingen HEA
			(mode_tile "V_Back" 1)   									;disable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 1)
			(if (or (= view "V_Back")(= view "V_Bottom")(= view "V_Top"))
			(progn(set_tile "Radio1" "V_Front")(setq view "V_Front"))
			) ;als op back dan op front view
			(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))											;geen flip
		)
		
		(
			(= future "RHS")   											;instellingen HEA
			(mode_tile "V_Back" 1)   									;disable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (or (= view "V_Back")(= view "V_Bottom"))
			(progn(set_tile "Radio1" "V_Front")(setq view "V_Front"))
			) ;als op back dan op front view
			(if (= view "V_Section")									;als sectie dan rotatie
				(progn 
					(mode_tile "list_3" 0)
					(if (= rot2 1) (progn (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
								   (progn (setq rot2 1) (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
					)
				)
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)
			(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))											;geen flip
		)
		
		(
			(= future "CHS")   											;instellingen HEA
			(mode_tile "V_Back" 1)   									;disable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 1)
			(if (or (= view "V_Back")(= view "V_Bottom")(= view "V_Top"))
			(progn(set_tile "Radio1" "V_Front")(setq view "V_Front"))
			) ;als op back dan op front view
			(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))											;geen flip
		)

		(
			(= future "HEB")   											;instellingen HEB
			(mode_tile "V_Back" 1)   									;disable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (= view "V_Back")(progn(set_tile "Radio1" "V_Front")(setq view "V_Front"))) ;als op back dan op front view
			(if (= view "V_Bottom")(progn(set_tile "Radio1" "V_Front")(setq view "V_Front")))
			(if (= view "V_Section")									;als sectie dan rotatie
				(progn 
					(mode_tile "list_3" 0)
					(if (= rot2 1) (progn (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
								   (progn (setq rot2 1) (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
					)
				)
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)
			(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))										;geen flip
		)
		
		(
			(= future "HEM")   											;instellingen HEB
			(mode_tile "V_Back" 1)   									;disable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (or (= view "V_Back")(= view "V_Bottom"))
			(progn(set_tile "Radio1" "V_Front")(setq view "V_Front"))
			) ;als op back dan op front view
			(if (= view "V_Section")									;als sectie dan rotatie
				(progn 
					(mode_tile "list_3" 0)
					(if (= rot2 1) (progn (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
								   (progn (setq rot2 1) (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
					)
				)
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)
			(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))										;geen flip
		)

		(
			(= future "IPE")   											;instellingen IPE
			(mode_tile "V_Back" 1)   									;disable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (or (= view "V_Back")(= view "V_Bottom"))
			(progn(set_tile "Radio1" "V_Front")(setq view "V_Front"))
			) ;als op back dan op front view
			(if (= view "V_Section")									;als sectie dan rotatie
				(progn 
					(mode_tile "list_3" 0)
					(if (= rot2 1) (progn (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
								   (progn (setq rot2 1) (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
					)
				)
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)
			(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))										;geen flip
		)

		(
			(= future "IPN")   											;instellingen IPE
			(mode_tile "V_Back" 1)   									;disable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (or (= view "V_Back")(= view "V_Bottom"))
			(progn(set_tile "Radio1" "V_Front")(setq view "V_Front"))
			) ;als op back dan op front view
			(if (= view "V_Section")									;als sectie dan rotatie
				(progn 
					(mode_tile "list_3" 0)
					(if (= rot2 1) (progn (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
								   (progn (setq rot2 1) (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
					)
				)
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)
			(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))										;geen flip
		)

		(
			(= future "UPE")   											;instellingen IPE
			(mode_tile "V_Back" 0)   									;enable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (= view "V_Bottom")(progn(set_tile "Radio1" "V_Front")(setq view "V_Front")))
			(if (= view "V_Section")									;als sectie dan rotatie en flip
				(progn 
					(mode_tile "list_3" 0)
					(if (= rot2 1) (progn (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
								   (progn (setq rot2 1) (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
					)
				)
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)															;geen flip
			(if (or (= view "V_Section")	 (= view "V_Top"))			;als sectie dan rotatie en flip
				(progn (mode_tile "Flip" 0))
				(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))
			)															;geen flip
		)

		(
			(= future "UPN")   											;instellingen IPE
			(mode_tile "V_Back" 0)   									;enable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (= view "V_Bottom")(progn(set_tile "Radio1" "V_Front")(setq view "V_Front")))
			(if (= view "V_Section")									;als sectie dan rotatie en flip
				(progn 
					(mode_tile "list_3" 0)
					(if (= rot2 1) (progn (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
								   (progn (setq rot2 1) (KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
					)
				)
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)															;geen flip
			(if (or (= view "V_Section")	 (= view "V_Top"))			;als sectie dan rotatie en flip
				(progn (mode_tile "Flip" 0))
				(progn (mode_tile "Flip" 1)(set_tile "Flip" "0")(setq flip "0"))
			)															;geen flip
		)

		(
			(= future "L GZ")   										;instellingen IPE
			(mode_tile "V_Back" 1)   									;enable back
			(mode_tile "V_Bottom" 1)
			(mode_tile "V_Top" 0)
			(if (= view "V_Back")(progn(set_tile "Radio1" "V_Front")(setq view "V_Front")))
			(if (= view "V_Bottom")(progn(set_tile "Radio1" "V_Front")(setq view "V_Front")))
			(if (= view "V_Section")									;als sectie dan rotatie en flip
				(progn (setq rot2 2)(mode_tile "list_3" 0)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)															
			(mode_tile "Flip" 0)										;wel flip
		)

		(
			(= future "L OZ")   										;instellingen IPE
			(mode_tile "V_Back" 0)   									;enable back
			(mode_tile "V_Bottom" 0)
			(mode_tile "V_Top" 0)
			(if (= view "V_Section")									;als sectie dan rotatie en flip
				(progn (setq rot2 2)(mode_tile "list_3" 0)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) rot1))
				(progn (setq rot2 0)(mode_tile "list_3" 1)(KTS_set_tile_list "list_3" (setq anglist (KTS_Rotlist rot2)) (setq rot1 (nth 0 anglist))))
			)															
			(mode_tile "Flip" 0)										;wel flip
		)
	)

	(setq interface (list view rot2 rot1 flip))
	interface
	); end KTstl_modetile


	;************************************************************************************
(defun KTS_Proplist (val1 val3 val4 lst / level1 level2 val2)
	(setq index (+ val4 1))
	(setq level1 (nth val3 lst))
	(setq level2 (cadr(nth index level1)))
	(Cond
		((= val1 "HEA")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
			)
		)
		((= val1 "HEB")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
		))
		((= val1 "HEM")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
		))
		((= val1 "IPE")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
			)
		)
		((= val1 "IPN")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
			)
		)
			((= val1 "UPE")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
			)
		)
		((= val1 "UPN")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
			)
		)
		((= val1 "L GZ")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Thick.:\t "   (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Area:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Ø max:\t "   (if (=(nth 5 level2 ) "")""(strcat "M"(rtos (nth 5 level2 ) 2 1))) ))
			(set_tile "shp_g" "")
			)
		)
		((= val1 "L OZ")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Thick.:\t "   (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Area:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" "")
			(set_tile "shp_g" "")
			)
		)
		((= val1 "SHS")
			(progn
			(set_tile "shp_d" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Thick.:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" "")
			(set_tile "shp_e" (strcat "Area:\t "    (rtos (nth 4 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" "")
			)
		)
		((= val1 "RHS")
			(progn
			(set_tile "shp_d" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Thick.:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" "")
			(set_tile "shp_e" (strcat "Area:\t "    (rtos (nth 4 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" "")
			)
		)
		((= val1 "CHS")
			(progn
			(set_tile "shp_c" (strcat "Weight:\t "  (rtos (nth 2 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Ø:\t "    (rtos (nth 0 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Thick.:\t "   (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_e" "")
			(set_tile "shp_d" "")
			(set_tile "shp_f" "")
			(set_tile "shp_g" "")
			)
		)
	)
	(princ)
	level2
	)

(defun KTS_upDateImage (prof view draw sldName rot flip /)

	(cond
		((or(= prof "HEA")(= prof "HEB")(= prof "HEM"))
			(cond
			((= view "V_Front")
			(cond	;front
				((= draw "Draw_a") (setq sldName "HEA(HFT)"))
				((= draw "Draw_b") (setq sldName "HEA(HFC)"))
				((= draw "Draw_c") (setq sldName "HEA(HFB)"))
				(nil())
			)
			)
			((= view "V_Top") 	;top
			(cond
				((= draw "Draw_a") (setq sldName "HEA(HTT)"))
				((= draw "Draw_b") (setq sldName "HEA(HTC)"))
				((= draw "Draw_c") (setq sldName "HEA(HTB)"))
				(nil())
			)
			)
			((= view "V_Section") 	;section
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "HEA(HST)"))
						((= draw "Draw_b") (setq sldName "HEA(HSC)"))
						((= draw "Draw_c") (setq sldName "HEA(HSB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "HEA(HSRT)"))
						((= draw "Draw_b") (setq sldName "HEA(HSRC)"))
						((= draw "Draw_c") (setq sldName "HEA(HSRB)"))
						(nil())
						)
					)
					(nil())
			)
			)
			(nil())
			))

		((= prof "IPE")
			(cond
			((= view "V_Front")
			(cond	;front
				((= draw "Draw_a") (setq sldName "IPE(IFT)"))
				((= draw "Draw_b") (setq sldName "IPE(IFC)"))
				((= draw "Draw_c") (setq sldName "IPE(IFB)"))
				(nil())
			)
			)
			((= view "V_Top") 	;top
			(cond
				((= draw "Draw_a") (setq sldName "IPE(ITT)"))
				((= draw "Draw_b") (setq sldName "IPE(ITC)"))
				((= draw "Draw_c") (setq sldName "IPE(ITB)"))
				(nil())
			)
			)
			((= view "V_Section") 	;section
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "IPE(IST)"))
						((= draw "Draw_b") (setq sldName "IPE(ISC)"))
						((= draw "Draw_c") (setq sldName "IPE(ISB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "IPE(ISRT)"))
						((= draw "Draw_b") (setq sldName "IPE(ISRC)"))
						((= draw "Draw_c") (setq sldName "IPE(ISRB)"))
						(nil())
						)
					)
					(nil())
			)
			)
			(nil())
			))

		((= prof "IPN")
			(cond
			((= view "V_Front")
			(cond	;front
				((= draw "Draw_a") (setq sldName "IPE(IFT)"))
				((= draw "Draw_b") (setq sldName "IPE(IFC)"))
				((= draw "Draw_c") (setq sldName "IPE(IFB)"))
				(nil())
			)
			)
			((= view "V_Top") 	;top
			(cond
				((= draw "Draw_a") (setq sldName "IPE(ITT)"))
				((= draw "Draw_b") (setq sldName "IPE(ITC)"))
				((= draw "Draw_c") (setq sldName "IPE(ITB)"))
				(nil())
			)
			)
			((= view "V_Section") 	;section
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "IPN(IPNST)"))
						((= draw "Draw_b") (setq sldName "IPN(IPNSC)"))
						((= draw "Draw_c") (setq sldName "IPN(IPNSB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "IPN(IPNSRT)"))
						((= draw "Draw_b") (setq sldName "IPN(IPNSRC)"))
						((= draw "Draw_c") (setq sldName "IPN(IPNSRB)"))
						(nil())
						)
					)
					(nil())
			)
			)
			(nil())
			))

		((= prof "UPN")
			(cond
			((= view "V_Front")
			(cond	;front
				((= draw "Draw_a") (setq sldName "HEA(HFT)"))
				((= draw "Draw_b") (setq sldName "HEA(HFC)"))
				((= draw "Draw_c") (setq sldName "HEA(HFB)"))
				(nil())
			)
			)
			((= view "V_Back")
			(cond	;back
				((= draw "Draw_a") (setq sldName "UPN(UNBT)"))
				((= draw "Draw_b") (setq sldName "UPN(UNBC)"))
				((= draw "Draw_c") (setq sldName "UPN(UNBB)"))
				(nil())
			)
			)
				((= view "V_Top") 	;top
			(cond
			((= flip "0")
			(cond
				((= draw "Draw_a") (setq sldName "LGZ(LTT)"))
				((= draw "Draw_b") (setq sldName "LGZ(LTC)"))
				((= draw "Draw_c") (setq sldName "LGZ(LTB)"))
				(nil())
			))
			((= flip "1")
			(cond
				((= draw "Draw_a") (setq sldName "LGZ(LTFT)"))
				((= draw "Draw_b") (setq sldName "LGZ(LTFC)"))
				((= draw "Draw_c") (setq sldName "LGZ(LTFB)"))
				(nil())
			))
			(nil())
			)
			)
			((= view "V_Section") 	;section
			(cond
			((= flip "0")
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "UPN(UNST)"))
						((= draw "Draw_b") (setq sldName "UPN(UNSC)"))
						((= draw "Draw_c") (setq sldName "UPN(UNSB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "UPN(UNSRB)"))
						((= draw "Draw_b") (setq sldName "UPN(UNSRC)"))
						((= draw "Draw_c") (setq sldName "UPN(UNSRT)"))
						(nil())
						)
					)
					(nil())
				)
				)
			((= flip "1")
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "UPN(UNSFT)"))
						((= draw "Draw_b") (setq sldName "UPN(UNSFC)"))
						((= draw "Draw_c") (setq sldName "UPN(UNSFB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "UPN(UNSRFT)"))
						((= draw "Draw_b") (setq sldName "UPN(UNSRFC)"))
						((= draw "Draw_c") (setq sldName "UPN(UNSRFB)"))
						(nil())
						)
					)
					(nil())
				)
				)
				(nil())
			)
			)
			(nil())
			)
			)

		((= prof "UPE")
			(cond
			((= view "V_Front")
			(cond	;front
				((= draw "Draw_a") (setq sldName "HEA(HFT)"))
				((= draw "Draw_b") (setq sldName "HEA(HFC)"))
				((= draw "Draw_c") (setq sldName "HEA(HFB)"))
				(nil())
			)
			)
			((= view "V_Back")
			(cond	;back
				((= draw "Draw_a") (setq sldName "UPN(UNBT)"))
				((= draw "Draw_b") (setq sldName "UPN(UNBC)"))
				((= draw "Draw_c") (setq sldName "UPN(UNBB)"))
				(nil())
			)
			)
			((= view "V_Top") 	;top
			(cond
			((= flip "0")
			(cond
				((= draw "Draw_a") (setq sldName "LGZ(LTT)"))
				((= draw "Draw_b") (setq sldName "LGZ(LTC)"))
				((= draw "Draw_c") (setq sldName "LGZ(LTB)"))
				(nil())
			))
			((= flip "1")
			(cond
				((= draw "Draw_a") (setq sldName "LGZ(LTFT)"))
				((= draw "Draw_b") (setq sldName "LGZ(LTFC)"))
				((= draw "Draw_c") (setq sldName "LGZ(LTFB)"))
				(nil())
			))
			(nil())
			)
			)
			((= view "V_Section") 	;section
			(cond
			((= flip "0")
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "UPE(UEST)"))
						((= draw "Draw_b") (setq sldName "UPE(UESC)"))
						((= draw "Draw_c") (setq sldName "UPE(UESB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "UPE(UESRT)"))
						((= draw "Draw_b") (setq sldName "UPE(UESRC)"))
						((= draw "Draw_c") (setq sldName "UPE(UESRB)"))
						(nil())
						)
					)
					(nil())
				)
				)
			((= flip "1")
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "UPE(UESFT)"))
						((= draw "Draw_b") (setq sldName "UPE(UESFC)"))
						((= draw "Draw_c") (setq sldName "UPE(UESFB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "UPE(UESRFT)"))
						((= draw "Draw_b") (setq sldName "UPE(UESRFC)"))
						((= draw "Draw_c") (setq sldName "UPE(UESRFB)"))
						(nil())
						)
					)
					(nil())
				)
				)
				(nil())
			)
			)
			(nil())
			)
			)

		((= prof "L GZ")  ;(= prof "L OZ")
			(cond
			((= view "V_Front") ;front
			(cond
			((= flip "0")
			(cond
				((= draw "Draw_a") (setq sldName "LGZ(LFT)"))
				((= draw "Draw_b") (setq sldName "LGZ(LFC)"))
				((= draw "Draw_c") (setq sldName "LGZ(LFB)"))
				(nil())
			))
			((= flip "1")
			(cond
				((= draw "Draw_a") (setq sldName "LGZ(LFFT)"))
				((= draw "Draw_b") (setq sldName "LGZ(LFFC)"))
				((= draw "Draw_c") (setq sldName "LGZ(LFFB)"))
				(nil())
			))
			(nil())
			)
			)

			((= view "V_Top") 	;top
			(cond
			((= flip "0")
			(cond
				((= draw "Draw_a") (setq sldName "LGZ(LTT)"))
				((= draw "Draw_b") (setq sldName "LGZ(LTC)"))
				((= draw "Draw_c") (setq sldName "LGZ(LTB)"))
				(nil())
			))
			((= flip "1")
			(cond
				((= draw "Draw_a") (setq sldName "LGZ(LTFT)"))
				((= draw "Draw_b") (setq sldName "LGZ(LTFC)"))
				((= draw "Draw_c") (setq sldName "LGZ(LTFB)"))
				(nil())
			))
			(nil())
			)
			)
			((= view "V_Section") 	;section
			(cond
			((= flip "0")
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "LGZ(LST)"))
						((= draw "Draw_b") (setq sldName "LGZ(LSC)"))
						((= draw "Draw_c") (setq sldName "LGZ(LSB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "LGZ(LSRT)"))
						((= draw "Draw_b") (setq sldName "LGZ(LSRC)"))
						((= draw "Draw_c") (setq sldName "LGZ(LSRB)"))
						(nil())
						)
					)
					((= rot "+180°")
						(cond
						((= draw "Draw_a") (setq sldName "LGZ(LSRFT)"))
						((= draw "Draw_b") (setq sldName "LGZ(LSRFC)"))
						((= draw "Draw_c") (setq sldName "LGZ(LSRFB)"))
						(nil())
						)
					)
					((= rot "+270°")
						(cond
						((= draw "Draw_a") (setq sldName "LGZ(LSFT)"))
						((= draw "Draw_b") (setq sldName "LGZ(LSFC)"))
						((= draw "Draw_c") (setq sldName "LGZ(LSFB)"))
						(nil())
						)
					)
					(nil())
				)
				)
			((= flip "1")
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "LGZ(LSFT)"))
						((= draw "Draw_b") (setq sldName "LGZ(LSFC)"))
						((= draw "Draw_c") (setq sldName "LGZ(LSFB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "LGZ(LST)"))
						((= draw "Draw_b") (setq sldName "LGZ(LSC)"))
						((= draw "Draw_c") (setq sldName "LGZ(LSB)"))
						(nil())
						)
					)
					((= rot "+180°")
						(cond
						((= draw "Draw_a") (setq sldName "LGZ(LSRT)"))
						((= draw "Draw_b") (setq sldName "LGZ(LSRC)"))
						((= draw "Draw_c") (setq sldName "LGZ(LSRB)"))
						(nil())
						)
					)
					((= rot "+270°")
						(cond
						((= draw "Draw_a") (setq sldName "LGZ(LSRFT)"))
						((= draw "Draw_b") (setq sldName "LGZ(LSRFC)"))
						((= draw "Draw_c") (setq sldName "LGZ(LSRFB)"))
						(nil())
						)
					)
					(nil())
				)
				)
				(nil())
			)
			)
			(nil())
			)
			)
			
			((= prof "L OZ")  ;(= prof "L OZ")
			(cond
			((= view "V_Front") ;front
			(cond
			((= flip "0")
			(cond
				((= draw "Draw_a") (setq sldName "LOZ(LOZFT)"))
				((= draw "Draw_b") (setq sldName "LOZ(LOZFC)"))
				((= draw "Draw_c") (setq sldName "LOZ(LOZFB)"))
				(nil())
			))
			((= flip "1")
			(cond
				((= draw "Draw_a") (setq sldName "LOZ(LOZFFT)"))
				((= draw "Draw_b") (setq sldName "LOZ(LOZFFC)"))
				((= draw "Draw_c") (setq sldName "LOZ(LOZFFB)"))
				(nil())
			))
			(nil())
			)
			)
			((= view "V_Back") ;back
			(cond
			((= flip "0")
			(cond
				((= draw "Draw_a") (setq sldName "LOZ(LOZBT)"))
				((= draw "Draw_b") (setq sldName "LOZ(LOZBC)"))
				((= draw "Draw_c") (setq sldName "LOZ(LOZBB)"))
				(nil())
			))
			((= flip "1")
			(cond
				((= draw "Draw_a") (setq sldName "LOZ(LOZBFT)"))
				((= draw "Draw_b") (setq sldName "LOZ(LOZBFC)"))
				((= draw "Draw_c") (setq sldName "LOZ(LOZBFB)"))
				(nil())
			))
			(nil())
			)
			)
			((= view "V_Top") 	;top
			(cond
			((= flip "0")
			(cond
				((= draw "Draw_a") (setq sldName "LOZ(LOZTT)"))
				((= draw "Draw_b") (setq sldName "LOZ(LOZTC)"))
				((= draw "Draw_c") (setq sldName "LOZ(LOZTB)"))
				(nil())
			))
			((= flip "1")
			(cond
				((= draw "Draw_a") (setq sldName "LOZ(LOZTFT)"))
				((= draw "Draw_b") (setq sldName "LOZ(LOZTFC)"))
				((= draw "Draw_c") (setq sldName "LOZ(LOZTFB)"))
				(nil())
			))
			(nil())
			)
			)
			((= view "V_Bottom") 	;top
			(cond
			((= flip "0")
			(cond
				((= draw "Draw_a") (setq sldName "LOZ(LOZOT)"))
				((= draw "Draw_b") (setq sldName "LOZ(LOZOC)"))
				((= draw "Draw_c") (setq sldName "LOZ(LOZOB)"))
				(nil())
			))
			((= flip "1")
			(cond
				((= draw "Draw_a") (setq sldName "LOZ(LOZOFT)"))
				((= draw "Draw_b") (setq sldName "LOZ(LOZOFC)"))
				((= draw "Draw_c") (setq sldName "LOZ(LOZOFB)"))
				(nil())
			))
			(nil())
			)
			)
			((= view "V_Section") 	;section
			(cond
			((= flip "0")
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "LOZ(LOZS0T)"))
						((= draw "Draw_b") (setq sldName "LOZ(LOZS0C)"))
						((= draw "Draw_c") (setq sldName "LOZ(LOZS0B)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "LOZ(LOZS9T)"))
						((= draw "Draw_b") (setq sldName "LOZ(LOZS9C)"))
						((= draw "Draw_c") (setq sldName "LOZ(LOZS9B)"))
						(nil())
						)
					)
					((= rot "+180°")
						(cond
						((= draw "Draw_a") (setq sldName "LOZ(LOZS8T)"))
						((= draw "Draw_b") (setq sldName "LOZ(LOZS8C)"))
						((= draw "Draw_c") (setq sldName "LOZ(LOZS8B)"))
						(nil())
						)
					)
					((= rot "+270°")
						(cond
						((= draw "Draw_a") (setq sldName "LOZ(LOZS7T)"))
						((= draw "Draw_b") (setq sldName "LOZ(LOZS7C)"))
						((= draw "Draw_c") (setq sldName "LOZ(LOZS7B)"))
						(nil())
						)
					)
					(nil())
				)
				)
			((= flip "1")
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "LOZ(LOZS0FT)"))
						((= draw "Draw_b") (setq sldName "LOZ(LOZS0FC)"))
						((= draw "Draw_c") (setq sldName "LOZ(LOZS0FB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "LOZ(LOZS9FT)"))
						((= draw "Draw_b") (setq sldName "LOZ(LOZS9FC)"))
						((= draw "Draw_c") (setq sldName "LOZ(LOZS9FB)"))
						(nil())
						)
					)
					((= rot "+180°")
						(cond
						((= draw "Draw_a") (setq sldName "LOZ(LOZS8FT)"))
						((= draw "Draw_b") (setq sldName "LOZ(LOZS8FC)"))
						((= draw "Draw_c") (setq sldName "LOZ(LOZS8FB)"))
						(nil())
						)
					)
					((= rot "+270°")
						(cond
						((= draw "Draw_a") (setq sldName "LOZ(LOZS7FT)"))
						((= draw "Draw_b") (setq sldName "LOZ(LOZS7FC)"))
						((= draw "Draw_c") (setq sldName "LOZ(LOZS7FB)"))
						(nil())
						)
					)
					(nil())
				)
				)
				(nil())
			)
			)
			(nil())
			)
			)
			
			
		((= prof "RHS")
			(cond
			((= view "V_Front")
			(cond	;front
				((= draw "Draw_a") (setq sldName "RH(RHFT)"))
				((= draw "Draw_b") (setq sldName "RH(RHFC)"))
				((= draw "Draw_c") (setq sldName "RH(RHFB)"))
				(nil())
			)
			)
			((= view "V_Top") 	;top
			(cond
				((= draw "Draw_a") (setq sldName "RH(RHTT)"))
				((= draw "Draw_b") (setq sldName "RH(RHTC)"))
				((= draw "Draw_c") (setq sldName "RH(RHTB)"))
				(nil())
			)
			)
			((= view "V_Section") 	;section
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "RH(RHST)"))
						((= draw "Draw_b") (setq sldName "RH(RHSC)"))
						((= draw "Draw_c") (setq sldName "RH(RHSB)"))
						(nil())
						)
					)
					((= rot "+90°")
						(cond
						((= draw "Draw_a") (setq sldName "RH(RHSRT)"))
						((= draw "Draw_b") (setq sldName "RH(RHSRC)"))
						((= draw "Draw_c") (setq sldName "RH(RHSRB)"))
						(nil())
						)
					)
					(nil())
			)
			)
			(nil())
		))
		((= prof "SHS")
			(cond
			((= view "V_Front")
			(cond	;front
				((= draw "Draw_a") (setq sldName "SHS(SHSFT)"))
				((= draw "Draw_b") (setq sldName "SHS(SHSFC)"))
				((= draw "Draw_c") (setq sldName "SHS(SHSFB)"))
				(nil())
			)
			)
			((= view "V_Section") 	;section
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "SHS(SHSST)"))
						((= draw "Draw_b") (setq sldName "SHS(SHSSC)"))
						((= draw "Draw_c") (setq sldName "SHS(SHSSB)"))
						(nil())
						)
					)
					(nil())
			)
			)
			(nil())
		))		
		((= prof "CHS")
			(cond
			((= view "V_Front")
			(cond	;front
				((= draw "Draw_a") (setq sldName "R(RFT)"))
				((= draw "Draw_b") (setq sldName "R(RFC)"))
				((= draw "Draw_c") (setq sldName "R(RFB)"))
				(nil())
			)
			)
			((= view "V_Section") 	;section
				(cond
					((= rot "+0°")
						(cond
						((= draw "Draw_a") (setq sldName "R(RST)"))
						((= draw "Draw_b") (setq sldName "R(RSC)"))
						((= draw "Draw_c") (setq sldName "R(RSB)"))
						(nil())
						)
					)
					(nil())
			)
			)
			(nil())
		))


	(nil())
	)
	;;;--- Get the width of the slide
	(setq width (dimx_tile "image"))

	;;;--- Get the height of the slide
	(setq height (dimy_tile "image"))

	;;;--- Start the slide definition
	(start_image "image")

	;;;--- Wipe out the background
	(fill_image 0 0 width height 0)

	;;;--- Put the slide in the image area
	(slide_image 0 0 width height sldName)

	;;;--- Finish the slide definition
	(end_image)
	sldName
	)
(defun KTS_Libary ( / list1@)
	(setq list1@ '(         ;	G		h		b		tw	tf	A		Ømax	Iy		Iz
			("HEA"
				("HEA 100" (	16.7	96.0	100.0	5	8	2120	10	3492000		1338000))
				("HEA 120" (	19.9	114.0	120.0	5	8	2530	12	6062000		2309000))
				("HEA 140" (	24.7	133.0	140.0	5.5	8.5	3140	16	10330000	3893000))
				("HEA 160" (	30.4	152.0	160.0	6	9	3880	20	16730000	6156000))
				("HEA 180" (	35.5	171.0	180.0	6	9.5	4530	24	25100000	9246000))
				("HEA 200" (	42.3	190.0	200.0	6.5	10	5380	27	36920000	13360000))
				("HEA 220" (	50.5	210.0	220.0	7	11	6430	27	54100000	19550000))
				("HEA 240" (	60.3	230.0	240.0	7.5	12	7680	27	77630000	27690000))
				("HEA 260" (	68.2	250.0	260.0	7.5	12.5	8680	27	104500000	36680000))
				("HEA 280" (	76.4	270.0	280.0	8	13	9730	27	136700000	47630000))
				("HEA 300" (	88.3	290.0	300.0	8.5	14	11250	27	182600000	63100000))
				("HEA 320" (	97.6	310.0	300.0	9	15.5	12440	27	229300000	69850000))
				("HEA 340" (	105		330.0	300.0	9.5	16.5	13350	27	276900000	74360000))
				("HEA 360" (	112		350.0	300.0	10	17.5	14280	27	330900000	78870000))
				("HEA 400" (	125		390.0	300.0	11	19	15900	27	450700000	85640000))
				("HEA 450" (	140		440.0	300.0	11.5	21	17800	27	637200000	94650000))
				("HEA 500" (	155		490.0	300.0	12	23	19750	27	869700000	103700000))
				("HEA 550" (	166		540.0	300.0	12.5	24	21180	27	1119000000	108200000))
				("HEA 600" (	178		590.0	300.0	13	25	22650	27	1412000000	112700000))
				("HEA 650" (	190		640.0	300.0	13.5	26	24160	27	1752000000	117200000))
				("HEA 700" (	204		690.0	300.0	14.5	27	26050	27	2153000000	121800000))
				("HEA 800" (	224		790.0	300.0	15	28	28580	27	3034000000	126400000))
				("HEA 900" (	252		890.0	300.0	16	30	32050	27	4221000000	135500000))
				("HEA 1000"(	272		990.0	300.0	16.5	31	34680	27	5538000000 	140000000))
			)
			("HEB"
				("HEB 100" (	20.4	100.0	100.0	6	10	2600	10	4495000		1673000))
				("HEB 120" (	26.7	120.0	120.0	6.5	11	3400	12	8644000		3175000))
				("HEB 140" (	33.7	140.0	140.0	7	12	4300	16	15090000	5497000))
				("HEB 160" (	42.6	160.0	160.0	8	13	5430	20	24920000	8892000))
				("HEB 180" (	51	180.0	180.0	8.5	14	6530	24	38310000	13630000))
				("HEB 200" (	61.3	200.0	200.0	9	15	7810	27	56960000	20030000))
				("HEB 220" (	71.5	220.0	220.0	9.5	16	9100	27	80910000	28430000))
				("HEB 240" (	83.2	240.0	240.0	10	17	10600	27	112600000	39230000))
				("HEB 260" (	93	260.0	260.0	10	17.5	11840	27	149200000	51350000))
				("HEB 280" (	103	280.0	280.0	10.5	18	13140	27	192700000	65950000))
				("HEB 300" (	117	300.0	300.0	11	19	14910	27	251700000	85630000))
				("HEB 320" (	127	320.0	300.0	11.5	20.5	16130	27	308200000	92390000))
				("HEB 340" (	134	340.0	300.0	12	21.5	17090	27	366600000	96900000))
				("HEB 360" (	142	360.0	300.0	12.5	22.5	18060	27	431900000	101400000))
				("HEB 400" (	155	400.0	300.0	13.5	24	19780	27	576800000	108200000))
				("HEB 450" (	171	450.0	300.0	14	26	21800	27	798900000	117200000))
				("HEB 500" (	187	500.0	300.0	14.5	28	23860	27	1072000000	126200000))
				("HEB 550" (	199	550.0	300.0	15	29	25410	27	1367000000	130800000))
				("HEB 600" (	212	600.0	300.0	15.5	30	27000	27	1710000000	135300000))
				("HEB 650" (	225	650.0	300.0	16	31	28630	27	2106000000	139800000))
				("HEB 700" (	241	700.0	300.0	17	32	30640	27	2569000000	144400000))
				("HEB 800" (	262	800.0	300.0	17.5	33	33420	27	3591000000	149000000))
				("HEB 900" (	291	900.0	300.0	18.5	35	37130	27	4941000000	158200000))
				("HEB 1000"(	314	1000.0	300.0	19	36	40000	27	6447000000	162800000))
			)
			("HEM"
				("HEM 100" (	41.8 	120	106	12	20	53.2 	12	11400000	3990000	))						
				("HEM 120" (	52.1 	140	126	12.5 	21	66.4 	16	20200000	7030000	))						
				("HEM 140" (	63.2 	160	146	13	22	80.6 	20	32900000	11400000 ))							
				("HEM 160" (	76.2 	180	166	14	23	97.1 	20	51000000	17600000 ))							
				("HEM 180" (	88.9 	200	186	14.5 	24	113	24	74800000	25800000 ))							
				("HEM 200" (	103	220	206	15	25	131	24	106400000	36500000 ))							
				("HEM 220" (	117	240	226	15.5 	26	149	24	146000000	50100000 ))							
				("HEM 240" (	157	270	248	18	32	200	24	242900000	81500000 ))							
				("HEM 260" (	172	290	268	18	32.5 	220	24	313100000	104500000 ))							
				("HEM 280" (	189	310	288	18.5 	33	240	24	395500000	131600000 ))							
				("HEM 300" (	238	340	310	21	39	303	24	592000000	194000000 ))							
				("HEM 320" (	245	359	309	21	40	312	27	681300000	197100000 ))							
				("HEM 340" (	248	377	309	21	40	316	27	763700000	197100000 ))							
				("HEM 360" (	250	395	308	21	40	319	27	848700000	195200000 ))							
				("HEM 400" (	256	432	307	21	40	326	27	1041000000	193300000 ))							
				("HEM 450" (	263	478	307	21	40	335	27	1315000000	193400000 ))							
				("HEM 500" (	270	524	306	21	40	344	27	1619000000	191500000 ))							
				("HEM 550" (	278	572	306	21	40	354	27	1980000000	191800000 ))							
				("HEM 600" (	285	620	305	21	40	364	27	2374000000	189700000 ))							
				("HEM 650" (	293	668	305	21	40	374	27	2817000000	189800000 ))							
				("HEM 700" (	301	716	304	21	40	383	27	3293000000	188000000 ))							
				("HEM 800" (	317	814	303	21	40	404	27	4426000000	185300000 ))							
				("HEM 900" (	333	910	302	21	40	424	27	5704000000	184500000 ))							
				("HEM 1000" (	349	1008	302	21	40	444	27	7223000000	184600000 ))			
			)
			("IPE"
				("IPE 80"  (	6.0	80.0	46.0	3.8	5.2	764	""	801000		849000))
				("IPE 100" (	8.1	100.0	55.0	4.1	5.7	1030	""	1710000		159000))
				("IPE 120" (	10.4	120.0	64.0	4.4	6.3	1320	""	3180000		277000))
				("IPE 140" (	12.9	140.0	73.0	4.7	6.9	1640	""	5410000		449000))
				("IPE 160" (	15.8	160.0	82.0	5.0	7.4	2010	""	8690000		683000))
				("IPE 180" (	18.8	180.0	91.0	5.3	8.0	2390	10	13170000	1010000))
				("IPE 200" (	22.4	200.0	100.0	5.6	8.5	2850	10	19430000	1420000))
				("IPE 220" (	26.2	220.0	110.0	5.9	9.2	3340	12	27720000	2050000))
				("IPE 240" (	30.7	240.0	120.0	6.2	9.8	3910	12	38920000	2840000))
				("IPE 270" (	36.1	270.0	135.0	6.6	10.2	4590	16	57900000	4200000))
				("IPE 300" (	42.2	300.0	150.0	7.1	10.7	5380	16	83560000	6040000))
				("IPE 330" (	49.1	330.0	160.0	7.5	11.5	6260	16	117700000	7880000))
				("IPE 360" (	57.1	360.0	170.0	8.0	12.7	7270	22	162700000	10430000))
				("IPE 400" (	66.3	400.0	180.0	8.6	13.5	8450	22	231300000	13180000))
				("IPE 450" (	77.6	450.0	190.0	9.4	14.6	9880	24	337400000	16760000))
				("IPE 500" (	90.7	500.0	200.0	10.2	16.0	11600	24	482000000	21420000))
				("IPE 550" (	106.0	550.0	210.0	11.1	17.2	13400	24	671200000	26680000))
				("IPE 600" (	122.0	600.0	220.0	12.0	19.0	15600	27	920800000	33870000))
			)
			("IPN"
				("IPN 80"  (	5.94	80.0	42.0	3.9	5.9	757	""	778000		629000))
				("IPN 100" (	8.34	100.0	50.0	4.5	6.8	1060	""	1710000		122000))
				("IPN 120" (	11.1	120.0	58.0	5.1	7.7	1420	""	3280000		215000))
				("IPN 140" (	14.3	140.0	66.0	5.7	8.6	1820	""	5730000		352000))
				("IPN 160" (	17.9	160.0	74.0	6.3	9.5	2280	""	9350000		547000))
				("IPN 180" (	21.9	180.0	82.0	6.9	10.4	2790	""	14500000	813000))
				("IPN 200" (	26.2	200.0	90.0	7.5	11.3	3340	""	21400000	1170000))
				("IPN 220" (	31.1	220.0	98.0	8.1	12.2	3950	10	30600000	1620000))
				("IPN 240" (	36.2	240.0	106.0	8.7	13.1	4610	10	42500000	2210000))
				("IPN 260" (	41.9	260.0	113.0	9.4	14.1	5330	12	57400000	2880000))
				("IPN 280" (	47.9	280.0	119.0	10.1	15.2	6100	12	75900000	3640000))
				("IPN 300" (	54.2	300.0	125.0	10.8	16.2	6900	12	98000000	4510000))
				("IPN 320" (	61.0	320.0	131.0	11.5	17.3	7770	12	125100000	5550000))
				("IPN 340" (	68.0	340.0	137.0	12.2	18.3	8670	12	157000000	6740000))
				("IPN 360" (	76.1	360.0	143.0	13	19.5	9700	12	196100000	8180000))
				("IPN 380" (	84.0	380.0	149.0	13.7	20.5	10700	16	240100000	9750000))
				("IPN 400" (	92.4	400.0	155.0	14.4	21.6	11800	16	292100000	11600000))
				("IPN 450" (	115.0	450.0	170.0	16.2	24.3	14700	16	458500000	17300000))
				("IPN 500" (	141.0	500.0	185.0	18	27	17900	20	687400000	24800000))
				("IPN 550" (	166.0	550.0	200.0	19	30	21200	22	991800000	34900000))
				("IPN 600" (	199.0	600.0	215.0	21.6	32.4	25400	24	1390000000	46700000))
			)
			("UPE"
				("UPE 80"   ( 	7.90 	80.0	50.0 	4.0 	7.0 	1010  	""	1070000 	255000))
				("UPE 100"  ( 	9.82 	100.0	55.0 	4.5 	7.5 	1250  	12 	2070000 	383000))
				("UPE 120"  ( 	12.1 	120.0	60.0 	5.0 	8.0 	1540  	12 	3640000	 	555000))
				("UPE 140"  ( 	14.5 	140.0	65.0 	5.0 	9.0 	1840  	16 	6000000 	788000))
				("UPE 160"  (	17.0 	160.0	70.0 	5.5 	9.5 	2170  	16 	9110000 	1070000))
				("UPE 180"  ( 	19.7 	180.0	75.0 	5.5 	10.5 	2510 	16 	13500000 	1440000))
				("UPE 200"  ( 	22.8 	200.0	80.0 	6.0 	11.0 	2900  	20 	19100000 	1870000))
				("UPE 220"  ( 	26.6 	220.0	85.0 	6.5 	12.0 	3390  	22 	26800000 	2470000))
				("UPE 240"  ( 	30.2 	240.0	90.0 	7.0 	12.5 	3850  	24 	36000000 	3110000))
				("UPE 270"  ( 	35.2 	270.0 	95.0 	7.5 	13.5 	4480  	27 	52500000 	4010000))
				("UPE 300"  ( 	44.4 	300.0 	100.0 	9.5 	15.0 	5660  	27 	78200000 	5380000))
				("UPE 330"  ( 	53.2 	330.0 	105.0 	11.0 	16.0 	6780  	27 	110100000 	6810000))
				("UPE 360"  ( 	61.2 	360.0 	110.0 	12.0 	17.0 	7790  	27 	148300000 	8440000))
				("UPE 400"  ( 	72.2 	400.0 	115.0 	13.5 	18.0 	9190  	27 	209800000 	10450000))
			)
			("UPN"
				;("UPN 50"   (	5.59	50.0	38.0	5.0	7	712	""	264000		912000	))
				;("UPN 65"   (	7.09	65.0	42.0	5.5	7.5	903	""	575000		141000	))
				("UPN 80"   (	8.64	80.0	45.0	6.0	8	1100	""	1060000		194000	))
				("UPN 100"  (	10.6	100.0	50.0	6.0	8.5	1350	""	2060000		293000	))
				("UPN 120"  (	13.4	120.0	55.0	7.0	9	1700	""	3640000		432000	))
				("UPN 140"  (	16.0	140.0	60.0	7.0	10	2040	12	6050000		627000	))
				("UPN 160"  (	18.8	160.0	65.0	7.5	10.5	2400	12	9250000		853000	))
				("UPN 180"  (	22.0	180.0	70.0	8.0	11	2800	16	13500000	1140000	))
				("UPN 200"  (	25.3	200.0	75.0	8.5	11.5	3220	16	19100000	1480000	))
				("UPN 220"  (	29.4	220.0	80.0	9.0	12.5	3740	16	26900000	1970000	))
				("UPN 240"  (	33.2	240.0	85.0	9.5	13	4230	20	36000000	2480000	))
				("UPN 260"  (	37.9	260.0	90.0	10	14	4830	22	48200000	3170000	))
				("UPN 280"  (	41.8	280.0	95.0	10	15	5330	22	62800000	3990000	))
				("UPN 300"  (	46.2	300.0	100.0	10	16	5880	24	80300000	4950000	))
				("UPN 320"  (	59.5	320.0	100.0	14	17.5	7580	22	108700000	5970000	))
				("UPN 350"  (	60.6	350.0	100.0	14	16	7730	22	128400000	5700000	))
				("UPN 380"  (	63.1	380.0	102.0	13.5	16	8040	24	157600000	6150000	))
				("UPN 400"  (	71.8	400.0	110.0	14	18	9150	27	203500000	8460000))
			)
			("L GZ"		;	G	h	b	t	A	Ø	Iy		Iz
				("L 20 x 20 x 3"(	0.88	20.0	20.0	3	112	""	3900		3900))
				("L 25 x 25 x 3"(	1.11	25.0	25.0	3	142	""	8000		8000))
				("L 25 x 25 x 4"(	1.45	25.0	25.0	4	185	""	10100		10100))
				("L 30 x 30 x 3"(	1.36	30.0	30.0	3	174	""	14000		14000))
				("L 30 x 30 x 4"(	1.78	30.0	30.0	4	227	""	18000		18000))
				("L 35 x 35 x 4"(	2.09	35.0	35.0	4	267	""	29500		29500))
				("L 40 x 40 x 4"(	2.42	40.0	40.0	4	308	""	44700		44700))
				("L 40 x 40 x 5"(	2.97	40.0	40.0	5	379	""	54300		54300))
				("L 45 x 45 x 4"(	2.74	45.0	45.0	4	349	""	64300		64300))
				("L 45 x 45 x 5"(	3.38	45.0	45.0	5	430	""	78400		78400))
				("L 50 x 50 x 4"(	3.06	50.0	50.0	4	389	""	89700		89700))
				("L 50 x 50 x 5"(	3.77	50.0	50.0	5	480	""	109600		109600))
				("L 50 x 50 x 6"(	4.47	50.0	50.0	6	569	""	128400		128400))
				("L 50 x 50 x 7"(	5.15	50.0	50.0	7	656	""	146100		146100))
				("L 55 x 55 x 5"(	4.18	55.0	55.0	5	532	""	147100		147100))
				("L 55 x 55 x 6"(	4.95	55.0	55.0	6	631	""	172900		172900))
				("L 60 x 60 x 4"(	3.7		60.0	60.0	4	471	12	157800		157800))
				("L 60 x 60 x 5"(	4.57	60.0	60.0	5	582	12	193700		193700))
				("L 60 x 60 x 6"(	5.42	60.0	60.0	6	691	12	227900		227900))
				("L 60 x 60 x 8"(	7.09	60.0	60.0	8	903	12	291500		291500))
				("L 65 x 65 x 6"(	5.91	65.0	65.0	6	753	16	291900		291900))
				("L 65 x 65 x 7"(	6.83	65.0	65.0	7	870	16	334300		334300))
				("L 65 x 65 x 8"(	7.73	65.0	65.0	8	985	16	374900		374900))
				("L 70 x 70 x 6"(	6.38	70.0	70.0	6	813	16	368800		368800))
				("L 70 x 70 x 7"(	7.38	70.0	70.0	7	940	16	423000		423000))
				("L 70 x 70 x 8"(	8.37	70.0	70.0	8	1067	16	472700		472700))
				("L 70 x 70 x 9"(	9.32	70.0	70.0	9	1188	16	524700		524700))
				("L 75 x 75 x 4"(	4.65	75.0	75.0	4	593	16	314300		314300))
				("L 75 x 75 x 5"(	5.76	75.0	75.0	5	734	16	387700		387700))
				("L 75 x 75 x 6"(	6.85	75.0	75.0	6	873	16	458300		458300))
				("L 75 x 75 x 7"(	7.93	75.0	75.0	7	1010	16	526100		526100))
				("L 75 x 75 x 8"(	8.99	75.0	75.0	8	1145	16	591300		591300))
				("L 75 x 75 x 10"(	11.06	75.0	75.0	10	1409	16	714300		714300))
				("L 80 x 80 x 5"(	6.17	80.0	80.0	5	786	16	471400		471400))
				("L 80 x 80 x 6"(	7.34	80.0	80.0	6	935	16	558200		558200))
				("L 80 x 80 x 7"(	8.49	80.0	80.0	7	1082	16	641900		641900))
				("L 80 x 80 x 8"(	9.63	80.0	80.0	8	1227	16	722500		722500))
				("L 80 x 80 x 10"(	11.86	80.0	80.0	10	1511	16	875000		875000))
				("L 90 x 90 x 6"(	8.28	90.0	90.0	6	1055	24	807200		807200))
				("L 90 x 90 x 7"(	9.61	90.0	90.0	7	1224	24	925500		925500))
				("L 90 x 90 x 8"(	10.9	90.0	90.0	8	1389	24	1043800		1043800))
				("L 90 x 90 x 9"(	12.18	90.0	90.0	9	1552	24	1158300		1158300))
				("L 90 x 90 x 10"(	13.45	90.0	90.0	10	1713	24	1269100		1269100))
				("L 90 x 90 x 11"(	14.7	90.0	90.0	11	1872	24	1376400		1376400	))
				("L 100 x 100 x 6"(	9.26	100.0	100.0	6	1179	27	1110500		1110500	))
				("L 100 x 100 x 7"(	10.73	100.0	100.0	7	1366	27	1282000		1282000	))
				("L 100 x 100 x 8"(	12.18	100.0	100.0	8	1551	27	1448400		1448400	))
				("L 100 x 100 x 10"(15.04	100.0	100.0	10	1915	27	1766800		1766800	))
				("L 100 x 100 x 12"(17.83	100.0	100.0	12	2271	27	2066900		2066900	))
				("L 110 x 110 x 8"(	13.43	110.0	110.0	8	1711	27	1952900		1952900	))
				("L 110 x 110 x 10"(16.63	110.0	110.0	10	2118	27	2379800		2379800	))
				("L 110 x 110 x 12"(19.74	110.0	110.0	12	2514	27	2791100		2791100	))
				("L 120 x 120 x 8"(	14.71	120.0	120.0	8	1874	27	2554300		2554300	))
				("L 120 x 120 x 10"(18.2	120.0	120.0	10	2318	27	3129400		3129400	))
				("L 120 x 120 x 11"(19.92	120.0	120.0	11	2537	27	3406400		3406400	))
				("L 120 x 120 x 12"(21.62	120.0	120.0	12	2754	27	3676700		3676700	))
				("L 120 x 120 x 13"(23.31	120.0	120.0	13	2969	27	3940400		3940400	))
				("L 120 x 120 x 15"(26.64	120.0	120.0	15	3393	27	4448900		4448900	))
				("L 120 x 120 x 16"(28.3	120.0	120.0	16	3600	27	4694000		4694000	))
				("L 130 x 130 x 10"(19.79	130.0	130.0	10	2521	27	4011200		4011200	))
				("L 130 x 130 x 12"(23.53	130.0	130.0	12	2997	27	4721700		4721700	))
				("L 130 x 130 x 13"(25.37	130.0	130.0	13	3232	27	5065000		5065000	))
				("L 130 x 130 x 14"(27.2	130.0	130.0	14	3465	27	5400600		5400600	))
				("L 130 x 130 x 16"(30.81	130.0	130.0	16	3925	27	6049600		6049600	))
				("L 150 x 150 x 10"(22.98	150.0	150.0	10	2927	27	6240400		6240400	))
				("L 150 x 150 x 12"(27.35	150.0	150.0	12	3483	27	7369100		7369100	))
				("L 150 x 150 x 13"(29.5	150.0	150.0	13	3760	27	7917000		7917000	))
				("L 150 x 150 x 14"(31.65	150.0	150.0	14	4031	27	8454000		8454000	))
				("L 150 x 150 x 15"(33.77	150.0	150.0	15	4302	27	8980500		8980500	))
				("L 150 x 150 x 16"(	35.9	150.0	150.0	16	4570	27	9497000		9497000	))
				("L 150 x 150 x 18"(	40.06	150.0	150.0	18	5103	27	10499700	10499700))
				("L 150 x 150 x 20"(	44.2	150.0	150.0	20	5630	27	11460000	11460000))
				("L 160 x 160 x 14"(	33.87	160.0	160.0	14	4315	27	10337800	10337800))
				("L 160 x 160 x 15"(	36.16	160.0	160.0	15	4606	27	10988300	10988300))
				("L 160 x 160 x 16"(	38.43	160.0	160.0	16	4895	27	11627000	11627000))
				("L 160 x 160 x 17"(	40.68	160.0	160.0	17	5182	27	12254000	12254000))
				("L 180 x 180 x 13"(	35.68	180.0	180.0	13	4546	27	13960900	13960900))
				("L 180 x 180 x 14"(	38.3	180.0	180.0	14	4879	27	14931200	14931200))
				("L 180 x 180 x 15"(	40.9	180.0	180.0	15	5210	27	15885600	15885600))
				("L 180 x 180 x 16"(	43.48	180.0	180.0	16	5539	27	16824300	16824300))
				("L 180 x 180 x 17"(	46.05	180.0	180.0	17	5866	27	17747700	17747700))
				("L 180 x 180 x 18"(	48.6	180.0	180.0	18	6191	27	18656000	18656000))
				("L 180 x 180 x 19"(	51.13	180.0	180.0	19	6514	27	19549600	19549600))
				("L 180 x 180 x 20"(	53.65	180.0	180.0	20	6835	27	20428800	20428800))
				("L 200 x 200 x 15"(	45.61	200.0	200.0	15	5810	27	22092500	22092500))
				("L 200 x 200 x 16"(	48.5	200.0	200.0	16	6179	27	23413600	23413600))
				("L 200 x 200 x 17"(	51.38	200.0	200.0	17	6546	27	24715100	24715100))
				("L 200 x 200 x 18"(	54.25	200.0	200.0	18	6911	27	25997400	25997400))
				("L 200 x 200 x 19"(	57.1	200.0	200.0	19	7274	27	27260900	27260900))
				("L 200 x 200 x 20"(	59.93	200.0	200.0	20	7635	27	28505800	28505800))
				("L 200 x 200 x 21"(	62.75	200.0	200.0	21	7994	27	29732600	29732600))
				("L 200 x 200 x 22"(	65.55	200.0	200.0	22	8351	27	30941400	30941400))
				("L 200 x 200 x 23"(	68.34	200.0	200.0	23	8706	27	32132700	32132700))
				("L 200 x 200 x 24"(	71.11	200.0	200.0	24	9059	27	33306600	33306600))
				("L 200 x 200 x 25"(	73.87	200.0	200.0	25	9410	27	34463600	34463600))
				("L 200 x 200 x 26"(	76.61	200.0	200.0	26	9759	27	35604000	35604000))
				("L 250 x 250 x 20"(	75.63	250.0	250.0	20	9635	27	57425700	57425700))
				("L 250 x 250 x 21"(	79.24	250.0	250.0	21	10094	27	59971500	59971500))
				("L 250 x 250 x 22"(	82.82	250.0	250.0	22	10551	27	62487200	62487200))
				("L 250 x 250 x 23"(	86.4	250.0	250.0	23	11006	27	64973200	64973200))
				("L 250 x 250 x 24"(	89.95	250.0	250.0	24	11459	27	67430000	67430000))
				("L 250 x 250 x 25"(	93.49	250.0	250.0	25	11910	27	69857900	69857900))
				("L 250 x 250 x 26"(	97.02	250.0	250.0	26	12359	27	72257400	72257400))
				("L 250 x 250 x 27"(	100.53	250.0	250.0	27	12806	27	74628800	74628800))
				("L 250 x 250 x 28"(	104.02	250.0	250.0	28	13251	27	76972500	76972500))
				("L 250 x 250 x 35"(	128.03	250.0	250.0	35	16310	27	92635500	92635500))

			)
			("L OZ"		;	G	h	b	t	A		Iy		Iz
				("L 100 x 65 x 7"(	8.77	100.0	65.0	7	1117		1125000		375800))
				("L 100 x 65 x 8"(	9.94	100.0	65.0	8	1267		1268000		422300))
				("L 100 x 65 x 9"(	11.11	100.0	65.0	9	1415		1406400		467000))
				("L 100 x 65 x 10"(	12.25	100.0	65.0	10	1561		1540500		509800))
				("L 100 x 65 x 12"(	14.5	100.0	65.0	12	1847		1796200		590700))
				("L 110 x 70 x 10"(	13.43	110.0	70.0	10	1711		2066200		650700))
				("L 110 x 70 x 12"(	15.91	110.0	70.0	12	2027		2414700		755400))
				("L 120 x 80 x 8"(	12.16	120.0	80.0	8	1549		2256500		807600))
				("L 120 x 80 x 10"(	15.02	120.0	80.0	10	1913		2755300		981100))
				("L 120 x 80 x 12"(	17.81	120.0	80.0	12	2269		3228300		1143300))
				("L 125 x 75 x 8"(	12.16	125.0	75.0	8	1549		2473000		676100))
				("L 125 x 75 x 9"(	13.6	125.0	75.0	9	1732		2750200		749600))
				("L 125 x 75 x 10"(	15.02	125.0	75.0	10	1913		3020200		820500))
				("L 125 x 75 x 12"(	17.81	125.0	75.0	12	2269		3539700		955200))
				("L 130 x 90 x 10"(	16.6	130.0	90.0	10	2115		3596500		1417900))
				("L 130 x 90 x 12"(	19.71	130.0	90.0	12	2511		4203800		1645300))
				("L 130 x 90 x 14"(	22.76	130.0	90.0	14	2899		4814100		1879400))
				("L 140 x 90 x 8"(	14.04	140.0	90.0	8	1789		3600100		1182500))
				("L 140 x 90 x 10"(	17.37	140.0	90.0	10	2213		4408900		1440700))
				("L 140 x 90 x 12"(	20.64	140.0	90.0	12	2629		5181400		1683700))
				("L 140 x 90 x 14"(	23.84	140.0	90.0	14	3037		5919400		1912800))
				("L 150 x 75 x 9"(	15.38	150.0	75.0	9	1959		4551900		779100))
				("L 150 x 75 x 10"(	17	150.0	75.0	10	2165		5006000		853700))
				("L 150 x 75 x 11"(	18.6	150.0	75.0	11	2369		5449900		925700))
				("L 150 x 75 x 12"(	20.19	150.0	75.0	12	2571		5883900		995500))
				("L 150 x 90 x 10"(	18.18	150.0	90.0	10	2315		5331400		1460700))
				("L 150 x 90 x 11"(	19.9	150.0	90.0	11	2534		5807300		1586500))
				("L 150 x 90 x 12"(	21.6	150.0	90.0	12	2750		6273000		1709000))
				("L 150 x 90 x 15"(	26.6	150.0	90.0	15	3390		7611000		2055000))
				("L 150 x 100 x 10"(	18.96	150.0	100.0	10	2415		5526000		1984800))
				("L 150 x 100 x 12"(	22.54	150.0	100.0	12	2871		6505500		2325900))
				("L 150 x 100 x 14"(	26.06	150.0	100.0	14	3319		7444200		2648800))
				("L 200 x 100 x 10"(	22.95	200.0	100.0	10	2924		12185800	2103400))
				("L 200 x 100 x 12"(	27.32	200.0	100.0	12	348		14400600	2472200))
				("L 200 x 100 x 14"(	31.62	200.0	100.0	14	4028		16541300	2822400))
				("L 200 x 100 x 15"(	33.7	200.0	100.0	15	4300		17580000	2991000))
			)
			("SHS"		;	G	h	b	t	A		I
				("SHS 40 x 4"(		4.39	40	40	4.0		559		118000))
				("SHS 40 x 5"(		5.28	40	40	5.0		673		134000))
				("SHS 50 x 3.2"(	4.62	50	50	3.2		588		212000))
				("SHS 50 x 4"(		5.64	50	50	4.0		719		250000))
				("SHS 50 x 5"(		6.85	50	50	5.0		873		289000))
				("SHS 50 x 6.3"(	8.31	50	50	6.3		1060	328000))
				("SHS 60 x 4"(		6.9		60	60	4.0		879		454000))
				("SHS 60 x 5"(		8.42	60	60	5.0		1070	533000))
				("SHS 60 x 6.3"(	10.3	60	60	6.3		1310	616000))
				("SHS 70 x 3.6"(	7.4		70	70	3.6		942		686000))
				("SHS 70 x 5"(		9.99	70	70	5.0		1270	885000))
				("SHS 80 x 3.6"(	8.53	80	80	3.6		1090	1050000))
				("SHS 80 x 5"(		11.6	80	80	5.0		1470	1370000))
				("SHS 80 x 6.3"(	14.2	80	80	6.3		1810	1620000))
				("SHS 80 x 8"(		17.5	80	80	8.0		2235	1890000))
				("SHS 90 x 4"(		0		90	90	4.0		0		0	))
				("SHS 90 x 5"(		13.1	90	90	5.0		1670	2000000))
				("SHS 90 x 6.3"(	16.2	90	90	6.3		2070	2380000))
				("SHS 90 x 8"(		20.1	90	90	8.0		2560	2810000))
				("SHS 100 x 4"(		11.9	100	100	4.0		1520	2320000))
				("SHS 100 x 5"(		14.7	100	100	5.0		1870	2790000))
				("SHS 100 x 6.3"(	18.2	100	100	6.3		2320	3360000))
				("SHS 100 x 8"(		22.6	100	100	8.0		2880	4000000))
				("SHS 100 x 10"(	27.4	100	100	10.0	3490	4620000))
				("SHS 120 x 5"(		1.8		120	120	5.0		2270	4980000))
				("SHS 120 x 6.3"(	22.2	120	120	6.3		2820	6030000))
				("SHS 120 x 8"(		27.6	120	120	8.0		3520	7260000))
				("SHS 120 x 10"(	33.7	120	120	10.0	4290	8520000))
				("SHS 120 x 12.5"(	40.9	120	120	12.5	5210	9820000))
				("SHS 140 x 5"(		21		140	140	5.0		2670	8070000))
				("SHS 140 x 6.3"(	26.1	140	140	6.3		3330	9840000))
				("SHS 140 x 8"(		32.6	140	140	8.0		4160	11950000))
				("SHS 140 x 10"(	40		140	140	10.0	5090	14160000))
				("SHS 140 x 12.5"(	48.7	140	140	12.5	6210	16530000))
				("SHS 150 x 5"(		22.6	150	150	5.0		2870	10020000))
				("SHS 150 x 6.3"(	28.1	150	150	6.3		3580	12230000))
				("SHS 150 x 8"(		35.1	150	150	8.0		4480	14910000))
				("SHS 150 x 10"(	43.1	150	150	10.0	5490	17730000))
				("SHS 150 x 12.5"(	52.7	150	150	12.5	6710	20800000))
				("SHS 160 x 5"(		24.1	160	160	5.0		3070	12250000))
				("SHS 160 x 6.3"(	30.1	160	160	6.3		3830	14990000))
				("SHS 160 x 8"(		37.6	160	160	8.0		4800	18310000))
				("SHS 160 x 10"(	46.3	160	160	10.0	5890	21860000))
				("SHS 180 x 6.3"(	34		180	180	6.3		4330	21680000))
				("SHS 180 x 8"(		42.7	180	180	8.0		5440	26610000))
				("SHS 180 x 10"(	52.5	180	180	10.0	6690	31930000))
				("SHS 180 x 12.5"(	64.4	180	180	12.5	8210	37900000))
				("SHS 180 x 16"(	80.2	180	180	16.0	10200	45040000))
				("SHS 200 x 5"(		30.4	200	200	5.0		3870	24450000))
				("SHS 200 x 6.3"(	38		200	200	6.3		4840	30110000))
				("SHS 200 x 8"(		47.7	200	200	8.0		6080	37090000))
				("SHS 200 x 10"(	58.8	200	200	10.0	7490	44710000))
				("SHS 200 x 12.5"(	72.3	200	200	12.5	9210	53360000))
				("SHS 200 x 16"(	90.3	200	200	16.0	11500	63940000))
				("SHS 250 x 6.3"(	47.9	250	250	6.3		6100	60140000))
				("SHS 250 x 8"(		60.3	250	250	8.0		7680	74550000))
				("SHS 250 x 10"(	74.5	250	250	10.0	9490	90550000))
				("SHS 250 x 12.5"(	91.9	250	250	12.5	11700	109150000))
				("SHS 250 x 16"(	115		250	250	16.0	14700	132670000))
				("SHS 300 x 8"(		72.8	300	300	8.0		9280	131280000))
				("SHS 300 x 10"(	90.2	300	300	10.0	11500	160260000))
				("SHS 300 x 12.5"(	112		300	300	12.5	14200	194420000))
				("SHS 300 x 16"(	141		300	300	16.0	17900	238500000))
				("SHS 350 x 8"(		85.4	350	350	8.0		10900	211290000))
				("SHS 350 x 10"(	106		350	350	10.0	13500	258840000))
				("SHS 350 x 12.5"(	131		350	350	12.5	16700	315410000))
				("SHS 350 x 16"(	166		350	350	16.0	21100	389420000))
				("SHS 400 x 10"(	122		400	400	10.0	15500	391280000))
				("SHS 400 x 12.5"(	151		400	400	12.5	19200	478390000))
				("SHS 400 x 16"(	191		400	400	16.0	24300	593440000))
	)
			("RHS"		;	G	h	b	t	A		Iy 		Iz	
				("RHS 90 x 50 x 5"(		90	50	5	7.5	5	9.99	1270	1270000	492000))
				("RHS 90 x 50 x 6"(		90	50	6	9	6	11.8	1500	1450000	554000))
				("RHS 100 x 50 x 3"(	100	50	3	4.5	3	6.71	854	1100000	368000))
				("RHS 100 x 50 x 3.2"(	100	50	3.2	4.8	3.2	7.13	908	1160000	388000))
				("RHS 100 x 50 x 4"(	100	50	4	6	4	8.78	1120	1400000	462000))
				("RHS 100 x 50 x 5"(	100	50	5	7.5	5	10.8	1370	1670000	543000))
				("RHS 100 x 50 x 6.3"(	100	50	6.3	9.45	6.3	13.3	1690	1970000	630000))
				("RHS 100 x 50 x 8"(	100	50	8	12	8	16.3	2080	2300000	717000))
				("RHS 100 x 60 x 5"(	100	60	5	7.5	5	11.6	1470	1890000	836000))
				("RHS 100 x 60 x 6.3"(	100	60	6.3	9.45	6.3	14.2	1810	2250000	981000))
				("RHS 100 x 60 x 8"(	100	60	8	12	8	17.5	2240	2640000	1130000))
				("RHS 120 x 60 x 3.6"(	120	60	3.6	5.4	3.6	9.66	1230	2270000	763000))
				("RHS 120 x 60 x 5"(	120	60	5	7.5	5	13.1	1670	2990000	988000))
				("RHS 120 x 60 x 6.3"(	120	60	6.3	9.45	6.3	16.2	2070	3580000	1160000))
				("RHS 120 x 60 x 8"(	120	60	8	12	8	20.1	2560	4250000	1350000))
				("RHS 120 x 80 x 5"(	120	80	5	7.5	5	14.7	1870	3650000	1930000))
				("RHS 120 x 80 x 6.3"(	120	80	6.3	9.45	6.3	18.2	2320	4400000	2300000))
				("RHS 120 x 80 x 8"(	120	80	8	12	8	22.6	2880	5250000	2730000))
				("RHS 120 x 80 x 10"(	120	80	10	15	10	27.4	3490	6090000	3130000))
				("RHS 150 x 100 x 5"(	150	100	5	7.5	5	18.6	2370	7390000	3920000))
				("RHS 150 x 100 x 6.3"(	150	100	6.3	9.45	6.3	23.1	2950	8980000	4740000))
				("RHS 150 x 100 x 8"(	150	100	8	12	8	28.9	3680	10870000	5690000))
				("RHS 150 x 100 x 10"(	150	100	10	15	10	35.3	4490	12820000	6650000))
				("RHS 150 x 125 x 10"(	150	125	10	10	0	0		0		0			0))
				("RHS 160 x 80 x 4"(	160	80	4	6	4	14.4	1840	6120000	2070000))
				("RHS 160 x 80 x 5"(	160	80	5	7.5	5	17.8	2270	7440000	2490000))
				("RHS 160 x 80 x 6.3"(	160	80	6.3	9.45	6.3	22.2	2820	9030000	2990000))
				("RHS 160 x 80 x 8"(	160	80	8	12	8	27.6	3520	10910000	3560000))
				("RHS 160 x 80 x 10"(	160	80	10	15	10	33.7	4290	12840000	4110000))
				("RHS 200 x 100 x 5"(	200	100	5	7.5	5	22.6	2870	14950000	5050000))
				("RHS 200 x 100 x 6.3"(	200	100	6.3	9.45	6.3	28.1	3580	18290000	6130000))
				("RHS 200 x 100 x 8"(	200	100	8	12	8	35.1	4480	22340000	7390000))
				("RHS 200 x 100 x 10"(	200	100	10	15	10	43.1	5490	26640000	8690000))
				("RHS 200 x 100 x 12.5"(	200	100	12.5	18.75	12.5	52.7	6710	31360000	10040000))
				("RHS 200 x 120 x 5"(		200	120	5		0		0		0		0		0			0))
				("RHS 200 x 120 x 6.3"(	200	120	6.3	12	8	29.9	3800	20390000	9190000))
				("RHS 200 x 120 x 8"(	200	120	8	15	10	37.3	4760	24900000	11140000))
				("RHS 200 x 120 x 10"(	200	120	10	18	12	45.9	5850	29780000	13200000))
				("RHS 200 x 150 x 8"(	200	150	8	0	0	0		0		0			0))
				("RHS 200 x 150 x 10"(	200	150	10	0	0	0		0		0			0))
				("RHS 250 x 150 x 5"(	250	150	5	7.5	5	30.4	3870	33600000	15270000))
				("RHS 250 x 150 x 6.3"(	250	150	6.3	9.45	6.3	38	4840	41430000	18740000))
				("RHS 250 x 150 x 8"(	250	150	8	12	8	47.7	6080	51110000	22980000))
				("RHS 250 x 150 x 10"(	250	150	10	15	10	58.8	7490	61740000	27550000))
				("RHS 250 x 150 x 12"(	250	150	12	18	12	69.6	8870	71540000	31680000))
				("RHS 250 x 150 x 12.5"(	250	150	12.5	18.75	12.5	72.3	9210	73870000	32650000))
				("RHS 250 x 150 x 16"(	250	150	16	24	16	90.3	11500	88790000	38730000))
				("RHS 300 x 100 x 8"(	300	100	8	0	0	0		0		0			0))
				("RHS 300 x 100 x 10"(	300	100	10	0	0	0		0		0			0))
				("RHS 300 x 200 x 6.3"(	300	200	6.3	9.45	6.3	47.9	6100	78290000	41930000))
				("RHS 300 x 200 x 8"(	300	200	8	12	8	60.3	7680	97170000	51840000))
				("RHS 300 x 200 x 10"(	300	200	10	15	10	74.5	9490	118190000	62780000))
				("RHS 300 x 200 x 12.5"(	300	200	12.5	18.75	12.5	91.9	11700	142730000	75370000))
				("RHS 300 x 200 x 16"(	300	200	16	24	16	115	14700	173900000	91090000))
				("RHS 400 x 200 x 8"(	400	200	8	12	8	72.8	9280	195620000	66600000))
				("RHS 400 x 200 x 10"(	400	200	10	15	10	90.2	11500	239140000	80840000))
				("RHS 400 x 200 x 12.5"(	400	200	12.5	18.75	12.5	112	14200	290630000	97380000))
				("RHS 400 x 200 x 16"(	400	200	16	24	16	141	17900	357380000	118240000))
				("RHS 450 x 250 x 8"(	450	250	8	0	0	0	0		0			0))
				("RHS 450 x 250 x 10"(	450	250	10	15	10	106	13500	368950000	148190000))
				("RHS 450 x 250 x 12.5"(	450	250	12.5	18.75	12.5	131	16700	450260000	179730000))
				("RHS 450 x 250 x 16"(	450	250	16	24	16	166	21100	557050000	220410000))
				("RHS 500 x 300 x 10"(	500	300	10	15	10	122	15500	537620000	244390000))
				("RHS 500 x 300 x 16"(	500	300	16	24	16	191	24300	817830000	367680000))
			)
			("CHS"		;	G	h	b	t	A		Iy 		Iz	
				("CHS 48.3 x 5"( 		48.3 	5		5.34	))
				("CHS 60.3 x 5"( 		60.3 	5		6.82	))
				("CHS 76.1 x 3.2"( 		76.1 	3.2 	5.75	))
				("CHS 76.1 x 5"( 		76.1 	5		8.77	))
				("CHS 88.9 x 3.2"( 		88.9 	3.2 	6.76	))
				("CHS 88.9 x 4"( 		88.9 	4		8.38	))
				("CHS 88.9 x 5"( 		88.9 	5		10.30	))
				("CHS 114.3 x 3.6"( 	114.3 	3.6 	9.83	))
				("CHS 114.3 x 5"( 		114.3 	5		13.50	))
				("CHS 114.3 x 6.3"( 	114.3 	6.3 	16.80	))
				("CHS 139.7 x 5"( 		139.7 	5		16.60))	
				("CHS 139.7 x 6.3"( 	139.7 	6.3 	20.70	))
				("CHS 139.7 x 8"( 		139.7 	8		26.00	))
				("CHS 139.7 x 10"( 		139.7 	10		32.00	))
				("CHS 168.3 x 5"( 		168.3 	5		20.10	))
				("CHS 168.3 x 6.3"( 	168.3 	6.3 	25.20	))
				("CHS 168.3 x 8"( 		168.3 	8		31.60	))
				("CHS 168.3 x 10"( 		168.3 	10		39.00	))
				("CHS 193.7 x 5"( 		193.7 	5		23.30	))
				("CHS 193.7 x 6.3"( 	193.7 	6.3 	29.10	))
				("CHS 193.7 x 8"( 		193.7 	8		36.60	))
				("CHS 193.7 x 10"( 		193.7 	10		45.30	))
				("CHS 219.1 x 5"( 		219.1 	5		26.40	))
				("CHS 219.1 x 6.3"( 	219.1 	6.3 	33.10	))
				("CHS 219.1 x 8"( 		219.1 	8		41.60	))
				("CHS 219.1 x 10"( 		219.1 	10		51.60	))
				("CHS 219.1 x 12.5"( 	219.1 	12.5 	63.70	))
				("CHS 244.5 x 16"( 		244.5 	16		90.20	))
				("CHS 273 x 6.3"( 		273		6.3 	41.40	))
				("CHS 273 x 8"( 		273		8		52.30	))
				("CHS 273 x 10"( 		273		10		64.90	))
				("CHS 273 x 12.5"( 		273		12.5 	80.30	))
				("CHS 273 x 16"( 		273		16		101.00	))
				("CHS 323.9 x 6.3"( 	323.9 	6.3 	49.30	))
				("CHS 323.9 x 8"( 		323.9 	8		62.30	))
				("CHS 323.9 x 10"( 		323.9 	10		77.40	))
				("CHS 323.9 x 12.5"( 	323.9 	12.5 	96.00	))
				("CHS 323.9 x 16"( 		323.9 	16		121.00	))
				("CHS 406.4 x 8"(		406.4	8		0	))
				("CHS 406.4 x 10"( 		406.4 	10		97.80	))
				("CHS 406.4 x 12.5"( 	406.4 	12.5 	121.00	))
				("CHS 406.4 x 16"( 		406.4 	16		154.00	))
				("CHS 457 x 8"(			457		8		0	))
				("CHS 457 x 10"( 		457		10		110.00	))
				("CHS 457 x 12.5"( 		457		12.5 	137.00	))
				("CHS 457 x 16"( 		457		16		174.00	))
				("CHS 508 x 10"( 		508		10		123.00	))
		)
	))
	list1@
	)
	
(defun KTS_Rotlist ( val / anglist)
	(if (= val 0)
	(setq anglist '("+0°"))
	)
	(if (= val 1)
	(setq anglist '("+0°" "+90°"))
	)
	(if (= val 2)
	(setq anglist '("+0°" "+90°" "+180°" "+270°"))
	)
	anglist
)

(defun C:KTSUpdate ( / )
 (if (= (KTS_vercheck) 1)
 (KTS_update) 
 (alert "U already have the latest version of KiTek Steel") 
 )
 (princ)
)



(defun KTS_updatebannerfile ( / list1 newverint KTSPathSource KTSPathDest count scriptfile)
   ;Default paden
  (if (KTS_urlping "kitek.be")
  (progn	
  (setq KTSFileSource (strcat (getenv "Temp") "\\banner.slb"))
  (setq KTSFileDest (strcat (vl-filename-directory (findfile "KT_Stl.lin"))"\\banner.slb"))
  
  (setq scriptfile (create_dlvbs)) 
  (startapp (strcat "CSCRIPT.EXE //nologo " (vl-prin1-to-string scriptfile) " " (vl-prin1-to-string "http://www.kitek.be/data/banner.slb")))
  
  (setq count 0)
  
  (while (and 
			(<= count 30)
			(not
				(findfile KTSFileSource)
		))
  (KTS_wait 1)
  (princ "/")
  (setq count (+ count 1))
  ) 
    
  (vl-file-delete KTSFileDest)
  (vl-file-delete scriptfile)
  (vl-file-copy KTSFileSource KTSFileDest T)
  (setenv "KTS_Datestamp2" (vl-prin1-to-string  (atoi (substr (rtos (getvar "CDATE") 2 0) 1 8)) ))
  )
  )
  (princ)
)

(defun KTS_needbanner ( / CurDate Month filedate2)
    (setq CurDate (rtos (getvar "CDATE") 2 0))
    (setq Month (atoi (substr CurDate 1 7))) ;ex 201309
	
	(if (setq filedate2 (getenv "KTS_Datestamp2"))
		(progn
			(setq filedate2 (atoi(substr (itoa (read filedate2)) 1 7)))
			(if (< filedate2 Month)
				(KTS_updatebannerfile)
			)
		)
	
	(setenv "KTS_Datestamp2" (vl-prin1-to-string  (atoi (substr (rtos (getvar "CDATE") 2 0) 1 8)) ))
	)
)
	
(defun KTS_needupdate ( / dateint1 dateint2 dateint3 date filedate1 filedate2 filedate3 CurDate setting *error*)
 
    (setq *error* KTS_needupdate_error)				;redefine local error handler
	(setq CurDate (rtos (getvar "CDATE") 2 0))
	(setq dateint1 (atoi (substr CurDate 1 8)))		
	(setq dateint2 (atoi (substr CurDate 1 7)))
	(setq dateint3 (atoi (substr CurDate 1 6)))	
	(setq dateint4 (atoi (substr CurDate 1 4)))
	(if (getenv "KTS_UpdateSettings")
	(setq setting (read(getenv "KTS_UpdateSettings")))
	(progn (setq setting 2) (setenv "KTS_UpdateSettings" (vl-princ-to-string 2)))
	)
	
	
(if (= setting 1)	
	(progn
	(if (setq filedate1 (getenv "KTS_Datestamp"));Read from registry
		(progn
			(setq filedate1 (read filedate1))
			(if (< filedate1 dateint1)
				(KTS_updaterunner dateint1 0)
			)
		)
		(KTS_updaterunner dateint1 0)
	)		
	)
)
(if (= setting 2)	
	(progn
	(if (setq filedate2 (getenv "KTS_Datestamp"));Read from registry
		(progn
		(setq filedate2 (atoi(substr (itoa (read filedate2)) 1 7)))
		(if (< filedate2 dateint2)
			(KTS_updaterunner dateint1 0)
		)
		)
		(KTS_updaterunner dateint1 0)
	)		
	)
)
(if (= setting 3)	
	(progn
	(if (setq filedate3 (getenv "KTS_Datestamp"));Read from registry
		(progn
		(setq filedate3 (atoi(substr (itoa (read filedate2)) 1 6)))
		(if (< filedate3 dateint2)
				(KTS_updaterunner dateint1 0)
		)
		)
			(KTS_updaterunner dateint1 0)
	)
	)
)

(if (setq filedate3 (getenv "KTS_Datestamp"));Read from registry
		(progn
		(setq filedate3 (atoi(substr (itoa (read filedate3)) 1 4)))
		(if (< filedate3 dateint4)
				(KTS_updaterunner dateint1 1)
		)
		)
			(KTS_updaterunner dateint1 1)
)


	(princ)
)

(defun KTS_updaterunner ( dateint1 forced )
	(if (KTS_urlping "kitek.be")
				(progn				
				(if (= (KTS_vercheck) 1)
					(progn
					(setenv "KTS_Datestamp" (vl-prin1-to-string dateint1))
					(if (= forced 1)
					(KTS_Update) 
					(KTS_Update1)
					)
					)
					(setenv "KTS_Datestamp" (vl-prin1-to-string dateint1))
				)
				)
	)
	(princ)
)
 

 (defun KTS_Update1 ( / temp list1 Dcl_Id%)
	(setq Dcl_Id% (load_dialog "KT_Stlsettings.dcl"))
	(if (not (new_dialog "KTSUpdate1" Dcl_Id%))
	(exit))
	(action_tile "delay" "(setq temp 0)(done_dialog)")
	(action_tile "next" "(setq temp 1)(done_dialog)")
	(setq Return# (start_dialog))
	(unload_dialog Dcl_Id%)
	(if (= temp 1) 
		(KTS_Update) 
	)
)




(defun KTS_needupdate_error ( msg )
    (if (not (member msg '("Function cancelled" "quit / exit abort")))
		(progn 	
			(setenv "KTS_UpdateSettings" (vl-princ-to-string 2))
			(setenv "KTS_Datestamp" (vl-prin1-to-string (atoi (substr (rtos (getvar "CDATE") 2 0) 1 8))))
			(alert "An error has occurred while checking for an update. \nIf the problem persists contact developers at www.kitek.be.")
			(KT_dialog)
		)
    )
    (princ)
 )



(defun KTS_Savelayers ( / savefile fp)
  (setq savefile (getfiled "Save As" "c:/" "ktsl" 1))
  (if (/= savefile nil)
  (progn
  (vl-file-delete savefile)
  (if
  (vl-file-copy (findfile "lay.ktsl") savefile )
  (progn
  (setq fp (open savefile "w"))
  (write-line (vl-prin1-to-string (KTS_deleteposition 0 (KTS_getlaylist (KTS_getslotpos)))) fp)
  (close fp)
  (alert "Settings successfully saved to slot")
  (KTS_Settings1 1)
  )
  (progn
  (alert "You cannot save to this location.\nPlease try to save your settings to a different directory.\nIf problems persist contact us on www.kitek.be.")
  (KTS_Savelayers)
  )
  )
  )
  (KTS_Settings1 1)
  )
)




(defun KTS_Loadlayers ( / tmp fp col lst lt tmp2 *error*)
  (defun *error* ( msg )
  (if (not (member msg '("Function cancelled" "quit / exit abort")))
		(progn 	
			(alert "There was an error loading the file.\nIf problem persists contact us on www.kitek.be.")
		)
  )
  (princ)
  )
  
  (setq tmp2 0)
  
  (setq Dcl_Id% (load_dialog "KT_Stlsettings.dcl"))
  
  (if (not (new_dialog "KTSYesNo" Dcl_Id%))
  (exit))
  
  (set_tile "title" "WARNING!")
  (set_tile "line1" "You are about to overwrite current slot settings.")
  (set_tile "line2" "Do you wish to continue?")
  
  (action_tile "no" "(setq tmp2 0)")
  (action_tile "yes" "(setq tmp2 1)(done_dialog)")
  
  (setq Return# (start_dialog))
  (unload_dialog Dcl_Id%)
 
  (if (= tmp2 1)
  (progn
  (setq col (KTS_Colorlist))
  (setq lt  (KTS_Linetypelist))
  (setq tmp (getfiled "Import KiTek Steel settings" "c:/program files/" "ktsl" 0))
  (if (/= tmp nil)
  (progn
  
   (setq fp (open tmp "r") )
   (while (setq l (read-line fp))(setq lst (cons l lst)))
   (close fp)
   
   (setq lst (read (car (reverse lst))))
   (if 
		(and (member (nth 2 lst) col)(member (nth 7 lst) col)(member (nth 12 lst) col)(member (nth 17 lst) col)(member (nth 24 lst) col)
		(member (nth 4 lst) lt)(member (nth 9 lst) lt)(member (nth 14 lst) lt)(member (nth 19 lst) lt) )  
   
		(progn
		(setq lst (cons (KTS_getslotpos) lst))
		(KTS_savelaylist lst)
		(alert (strcat "Setting successfully imported to slot " (itoa (KTS_getslotpos))))
		(KTS_Settings1 1)  
		)   
   
		(progn
		(alert "Not a valid *.ktsl 1.1 file")
		(KTS_Loadlayers)
		)
    )
  )
  (KTS_Settings1 1)
  )
  )
  (KTS_Settings1 1)
  )
)

(defun KTS_Colorlist (/ Colorlist)
(setq Colorlist (list  "Blue" "Green" "Magenta" "Red" "Cyan" "White" "Yellow" "Other"))
Colorlist
)

(defun KTS_Linetypelist ( / Linetypelist)
(setq Linetypelist (list  "Continuous" "Border" "Border2" "Center" "Center2" "Continuous" "Dashdot" "Dashdot2" "Divide" "Divide2" "Hidden" "Hidden2" "Phantom" "Phantom2" "Dashed" "Dashed2"))
Linetypelist
)

(defun KTS_Lineweight ( / Linetypelist)
(setq Lineweightlist (list  "Default" "0.00 mm" "0.05 mm" "0.09 mm" "0.13 mm" "0.15 mm" "0.18 mm" "0.20 mm" "0.25 mm" "0.30 mm" "0.35 mm" "0.40 mm" "0.50 mm" "0.53 mm" "0.60 mm" "0.70 mm" "0.80 mm" "0.90 mm" "1.00 mm" "1.06 mm" "1.20 mm" "1.40 mm" "1.58 mm" "2.00 mm" "2.11 mm"))
Lineweightlist
)



(defun KTS_Addprefix (lst / tmp counter)
(setq tmp '())
(setq counter 1)
(foreach n lst
(setq tmp (cons  (strcat (itoa counter) ". " n)  tmp))
(setq counter (+ 1 counter))
)
(setq tmp (reverse tmp)) 
tmp
)

(defun KTS_Settings1 (fresh / editset Slotlistintern index temp Radio1$ list1 Slotname Laylist Linetypelist Lineweightlist Colorlist LayNewCo LayNewHi LayExCo LayExHi ColNewCo ColNewHi ColExCo ColNewHi ColExCo ColExHi LtNewCo LtNewHi LtExCo LtExHi LwNewCo LwNewHi
 LwExCo LwExHi txtanno txthei txtlay txtcol Textcolor TextcolorCust TextcolorCu txtfont Slotlist Slotpos LabScale ExAdd *error*)

	(defun *error* ( msg )
		(if (not (member msg '("Function cancelled" "quit / exit abort")))
			(KTS_reset)
		)
		(princ)
    )
	
	(setq Dcl_Id% (load_dialog "KT_Stlsettings.dcl"))
	(if (not (new_dialog "KTSSettings1" Dcl_Id%))
	(exit))
	
	(if (= fresh 1)
	(progn
	
	(if (setq Radio1$ (getenv "KTS_UpdateSettings"))
	nil
	(setenv "KTS_UpdateSettings" (setq Radio1$(vl-princ-to-string 2)))
	)
	
	(setq Laylist (KTS_getlaylist (KTS_getslotpos)))
	(setq Linetypelist (KTS_Linetypelist))
	(setq Lineweightlist (KTS_Lineweight))
	(setq Slotlist (KTS_getslotlist))
	
	(setq Slotlistintern (KTS_Addprefix Slotlist ))
	
	(setq Slotpos (KTS_getslotpos))
	(setq Colorlist (KTS_Colorlist))
	(setq Slotname (nth 1 Laylist))
	(setq LayNewCo (nth 2 Laylist))
	(setq LayNewHi (nth 7 Laylist))
	(setq LayExCo (nth 12 Laylist))
	(setq LayExHi (nth 17 Laylist))
	
	(setq ColNewCo (nth 3 Laylist))
	(setq ColNewHi (nth 8 Laylist))
	(setq ColExCo (nth 13 Laylist))
	(setq ColExHi (nth 18 Laylist))
	
	(setq ColNewCoCust (nth 4 Laylist))
	(setq ColNewHiCust (nth 9 Laylist))
	(setq ColExCoCust (nth 14 Laylist))
	(setq ColExHiCust (nth 19 Laylist))
	
	(setq LtNewCo (nth 5 Laylist))
	(setq LtNewHi (nth 10 Laylist))
	(setq LtExCo (nth 15 Laylist))
	(setq LtExHi (nth 20 Laylist))
	
	(setq LwNewCo (nth 6 Laylist))
	(setq LwNewHi (nth 11 Laylist))
	(setq LwExCo (nth 16 Laylist))
	(setq LwExHi (nth 21 Laylist))
	
	(setq txtanno (nth 22 Laylist))
	(setq txthei (nth 23 Laylist))
	(setq txtlay (nth 24 Laylist))
	(setq Textcolor (nth 25 Laylist))
	(setq TextcolorCust (nth 26 Laylist))
	(setq txtfont (nth 27 Laylist))
	(setq LabScale (nth 28 Laylist))
	(setq ExAdd (nth 29 Laylist))
	)
	)

;userinput
	
	(setq editset  0)

	(set_tile "Radio1" Radio1$)
	
	(KTS_set_tile_list "Slots" Slotlistintern (nth (1- Slotpos) Slotlistintern))

	(KTS_settiles Slotname LayNewCo LayNewHi LayExCo LayExHi ColNewCoCust ColNewHiCust ColExCoCust ColExHiCust txthei txtanno txtlay txtfont TextcolorCust Linetypelist Lineweightlist LtNewCo LtNewHi LtExCo LtExHi LwNewCo LwNewHi LwExCo LwExHi Colorlist ColNewCo ColNewHi ColExCo ColExHi Textcolor LabScale ExAdd)

	
	;User input

	(action_tile "Slots" 
	"(setq Slotpos (1+(atoi $value)))
	(KTS_saveslotpos Slotpos)
	(setq editset 0)
	(setq Laylist (KTS_getlaylist Slotpos))
	(setq Slotname (nth 1 Laylist))
	(setq LayNewCo (nth 2 Laylist))
	(setq LayNewHi (nth 7 Laylist))
	(setq LayExCo (nth 12 Laylist))
	(setq LayExHi (nth 17 Laylist))
	(setq ColNewCo (nth 3 Laylist))
	(setq ColNewHi (nth 8 Laylist))
	(setq ColExCo (nth 13 Laylist))
	(setq ColExHi (nth 18 Laylist))
	(setq ColNewCoCust (nth 4 Laylist))
	(setq ColNewHiCust (nth 9 Laylist))
	(setq ColExCoCust (nth 14 Laylist))
	(setq ColExHiCust (nth 19 Laylist))
	(setq LtNewCo (nth 5 Laylist))
	(setq LtNewHi (nth 10 Laylist))
	(setq LtExCo (nth 15 Laylist))
	(setq LtExHi (nth 20 Laylist))
	(setq LwNewCo (nth 6 Laylist))
	(setq LwNewHi (nth 11 Laylist))
	(setq LwExCo (nth 16 Laylist))
	(setq LwExHi (nth 21 Laylist))
	(setq txtanno (nth 22 Laylist))
	(setq txthei (nth 23 Laylist))
	(setq txtlay (nth 24 Laylist))
	(setq Textcolor (nth 25 Laylist))
	(setq TextcolorCust (nth 26 Laylist))
	(setq txtfont (nth 27 Laylist))
	(setq LabScale (nth 28 Laylist))
	(setq ExAdd (nth 29 Laylist))
	(KTS_settiles Slotname LayNewCo LayNewHi LayExCo LayExHi ColNewCoCust ColNewHiCust ColExCoCust ColExHiCust txthei txtanno txtlay txtfont TextcolorCust Linetypelist Lineweightlist LtNewCo LtNewHi LtExCo LtExHi LwNewCo LwNewHi LwExCo LwExHi Colorlist ColNewCo ColNewHi ColExCo ColExHi Textcolor LabScale ExAdd)
	") 
	
	(action_tile "Slotname" "(setq Slotname $value)(setq editset 1)")
	(action_tile "TxtNewCo" "(setq LayNewCo $value)(setq editset 1)")
	(action_tile "TxtNewHi" "(setq LayNewHi $value)(setq editset 1)")
	(action_tile "TxtExCo" "(setq LayExCo $value)(setq editset 1)")
	(action_tile "TxtExHi" "(setq LayExHi $value)(setq editset 1)")
	(action_tile "Textheight" "(KTS_check_editreal \"txthei\")(setq editset 1)")
	(action_tile "Textanno" "(setq txtanno $value)(if (or (not(findfile \"LAB2012.mnl\"))(= txtanno \"1\")) (progn(mode_tile \"LabScale\" 1)(setq LabScale \"0\"))(mode_tile \"LabScale\" 0))(setq editset 1)")
	(action_tile "Textlayer" "(setq txtlay $value)(setq editset 1)")
	(action_tile "Textfont" "(setq txtfont $value)(setq editset 1)")
	(action_tile "ColNewCoCust" "(KTS_check_editreal \"ColNewCoCust\")(setq editset 1)")
	(action_tile "ColNewHiCust" "(KTS_check_editreal \"ColNewHiCust\")(setq editset 1)")
	(action_tile "ColExCoCust" "(KTS_check_editreal \"ColExCoCust\")(setq editset 1)")
	(action_tile "ColExHiCust" "(KTS_check_editreal \"ColExHiCust\")(setq editset 1)")
	(action_tile "TextcolorCust" "(KTS_check_editreal \"TextcolorCust\")(setq editset 1)")
	(action_tile "ColNewCo" "(setq ColNewCo (nth (atoi $value) Colorlist))(if (= ColNewCo \"Other\") (progn(mode_tile \"ColNewCoCust\" 0)(setq ColNewCoCu 1))(mode_tile \"ColNewCoCust\" 1))(setq editset 1)    ")
	(action_tile "ColNewHi" "(setq ColNewHi (nth (atoi $value) Colorlist))(if (= ColNewHi \"Other\") (progn(mode_tile \"ColNewHiCust\" 0)(setq ColNewHiCu 1))(mode_tile \"ColNewHiCust\" 1)) (setq editset 1)   ")
	(action_tile "ColExCo" "(setq ColExCo (nth (atoi $value) Colorlist))(if (= ColExCo \"Other\") (progn(mode_tile \"ColExCoCust\" 0)(setq ColExCoCu 1))(mode_tile \"ColExCoCust\" 1)) (setq editset 1)   ")
	(action_tile "ColExHi" "(setq ColExHi (nth (atoi $value) Colorlist))(if (= ColExHi \"Other\") (progn(mode_tile \"ColExHiCust\" 0)(setq ColExHiCu 1))(mode_tile \"ColExHiCust\" 1)) (setq editset 1)   ")
	(action_tile "Textcolor" "(setq Textcolor (nth (atoi $value) Colorlist))(if (= Textcolor \"Other\") (progn(mode_tile \"TextcolorCust\" 0)(setq txtcolorCu 1))(mode_tile \"TextcolorCust\" 1)) (setq editset 1) ")
	(action_tile "LtNewCo" "(setq LtNewCo (nth (atoi $value) Linetypelist))(setq editset 1)")
	(action_tile "LtNewHi" "(setq LtNewHi (nth (atoi $value) Linetypelist))(setq editset 1)")
	(action_tile "LtExCo" "(setq LtExCo (nth (atoi $value) Linetypelist))(setq editset 1)")
	(action_tile "LtExHi" "(setq LtExHi (nth (atoi $value) Linetypelist))(setq editset 1)")
	(action_tile "LwNewCo" "(setq LwNewCo (nth (atoi $value) Lineweightlist))(setq editset 1)")
	(action_tile "LwNewHi" "(setq LwNewHi (nth (atoi $value) Lineweightlist))(setq editset 1)")
	(action_tile "LwExCo" "(setq LwExCo (nth (atoi $value) Lineweightlist))(setq editset 1)")
	(action_tile "LwExHi" "(setq LwExHi (nth (atoi $value) Lineweightlist))(setq editset 1)")
	(action_tile "LabScale" "(setq LabScale $value)(if (= LabScale \"1\") (progn(mode_tile \"Textanno\" 1)(setq txtanno \"0\"))(mode_tile \"Textanno\" 0))(setq editset 1)")
	(action_tile "ExAdd" "(setq ExAdd $value)(setq editset 1)")	
	
	(action_tile "Radio1" "(setq Radio1$ $value)")
	(action_tile "ok" "(setq temp 1)(done_dialog)")
	(action_tile "check" "(setq temp 2)(done_dialog)")
	(action_tile "info" "(setq temp 3)(done_dialog)")
	(action_tile "export" 
	"(if (= editset 1)
		(progn	
		(KTS_savelaylist (list Slotpos Slotname LayNewCo ColNewCo ColNewCoCust LtNewCo LwNewCo LayNewHi ColNewHi ColNewHiCust LtNewHi LwNewHi LayExCo ColExCo ColExCoCust LtExCo LwExCo LayExHi ColExHi ColExHiCust LtExHi LwExHi txtanno txthei txtlay Textcolor TextcolorCust txtfont LabScale ExAdd))
		(alert \"Settings succesfully saved\")
		)
	)
	(setq temp 4)
	(done_dialog)
	")
	(action_tile "import" "(setq temp 5)(done_dialog)")
	(action_tile "savetoslot" "(KTS_savelaylist (list Slotpos Slotname LayNewCo ColNewCo ColNewCoCust LtNewCo LwNewCo LayNewHi ColNewHi ColNewHiCust LtNewHi LwNewHi LayExCo ColExCo ColExCoCust LtExCo LwExCo LayExHi ColExHi ColExHiCust LtExHi LwExHi txtanno txthei txtlay Textcolor TextcolorCust txtfont LabScale ExAdd))(alert \"Settings succesfully saved\")
	(KTS_set_tile_list \"Slots\" (setq slotlist (KTS_getslotlist)) (nth (1- Slotpos) Slotlist))") ;nog te maken
	
	
	(setq Return# (start_dialog))
	(unload_dialog Dcl_Id%)
	
	(if (= temp 1) ;ok
	(progn
	(setenv "KTS_UpdateSettings" Radio1$)
	(KT_dialog)
	)
	)
	(if (= temp 2) ;check for update
	(progn
	(C:KTSUpdate)
	(KT_dialog)
	)
	)
	(if (= temp 3) ;go to website
	(progn
	(c:KTS_link)
	(KTS_Settings1 1)
	)
	)
	(if (= temp 4) ;save layers
	(progn
	(KTS_Savelayers)
	)
	)
	(if (= temp 5) ;load layers
	(progn
	(KTS_Loadlayers)
	)
	)
	(princ)
)

(defun KTS_settiles (Slotname LayNewCo LayNewHi LayExCo LayExHi ColNewCoCust ColNewHiCust ColExCoCust ColExHiCust txthei txtanno txtlay txtfont TextcolorCust Linetypelist Lineweightlist LtNewCo LtNewHi LtExCo LtExHi LwNewCo LwNewHi LwExCo LwExHi Colorlist ColNewCo ColNewHi ColExCo ColExHi Textcolor LabScale ExAdd)
	(set_tile "Slotname" Slotname)
	(set_tile "TxtNewCo" LayNewCo)
	(set_tile "TxtNewHi" LayNewHi)
	(set_tile "TxtExCo" LayExCo)
	(set_tile "TxtExHi" LayExHi)
	(set_tile "ColNewCoCust" ColNewCoCust)
	(set_tile "ColNewHiCust" ColNewHiCust)
	(set_tile "ColExCoCust" ColExCoCust)
	(set_tile "ColExHiCust" ColExHiCust)
	(set_tile "Textheight" txthei)
	(set_tile "Text" txtanno)
	(if (or (not(findfile "LAB2012.mnl"))(= txtanno "1")) (progn(mode_tile "LabScale" 1)(setq LabScale "0"))(mode_tile "LabScale" 0)
	)
	(set_tile "Textlayer" txtlay)
	(set_tile "Textfont" txtfont)
	(set_tile "TextcolorCust" TextcolorCust)
	(KTS_set_tile_list "LtNewCo" Linetypelist LtNewCo)
	(KTS_set_tile_list "LtNewHi" Linetypelist LtNewHi)
	(KTS_set_tile_list "LtExCo" Linetypelist LtExCo)
	(KTS_set_tile_list "LtExHi" Linetypelist LtExHi)
	(KTS_set_tile_list "LwNewCo" Lineweightlist LwNewCo)
	(KTS_set_tile_list "LwNewHi" Lineweightlist LwNewHi)
	(KTS_set_tile_list "LwExCo" Lineweightlist LwExCo)
	(KTS_set_tile_list "LwExHi" Lineweightlist LwExHi)
	(KTS_set_tile_list "ColNewCo" Colorlist ColNewCo)
	(if (= ColNewCo "Other") (progn(mode_tile "ColNewCoCust" 0)(setq ColNewCoCu 1))(mode_tile "ColNewCoCust" 1)
	)
	(KTS_set_tile_list "ColNewHi" Colorlist ColNewHi)
	(if (= ColNewHi "Other") (progn(mode_tile "ColNewHiCust" 0)(setq ColNewHiCu 1))(mode_tile "ColNewHiCust" 1)
	)
	(KTS_set_tile_list "ColExCo" Colorlist ColExCo)
	(if (= ColExCo "Other") (progn(mode_tile "ColExCoCust" 0)(setq ColExCoCu 1))(mode_tile "ColExCoCust" 1)
	)
	(KTS_set_tile_list "ColExHi" Colorlist ColExHi)
	(if (= ColExHi "Other") (progn(mode_tile "ColExHiCust" 0)(setq ColExHiCu 1))(mode_tile "ColExHiCust" 1)
	)
	(KTS_set_tile_list "Textcolor" Colorlist Textcolor)
	(if (= Textcolor "Other") (progn(mode_tile "TextcolorCust" 0)(setq TextcolorCu 1))(mode_tile "TextcolorCust" 1)
	)
	(set_tile "LabScale" LabScale)
	(if (= LabScale "1") (progn(mode_tile "Textanno" 1)(setq txtanno "0"))(mode_tile "Textanno" 0)
	)
	(set_tile "ExAdd" ExAdd)
)

(defun KTS_vercheck ( / vcheck open_file newverint fp lst tmp temppath tempfile scriptfile)
	(setq temppath (strcat (getenv "Temp") "\\"))
	(setq tempfile (strcat temppath "kts_version.txt"))
;	(KTS_GetFileFromURL "http://www.kitek.be/data/kts_version.txt" temppath)

	(if (findfile tempfile)
		(vl-file-delete tempfile)
	)

	(setq scriptfile (create_dlvbs)) ;calls external VBScript to kill Excel instance
	(startapp (strcat "CSCRIPT.EXE //nologo " (vl-prin1-to-string scriptfile) " " (vl-prin1-to-string "https://raw.githubusercontent.com/JoakinKirschen/kitek_steel/master/kts_version.txt")))
	(setq count 0)
	(while (and (<= count 10)(not (findfile tempfile)))	(KTS_wait 1)(princ "/")(setq count (+ count 1))	)
	
	(if (findfile tempfile)
	(progn
	(progn
		(setq fp (open tempfile "r") )
		(while (setq l (read-line fp))(setq lst (cons l lst)))
		(close fp)
		(setq lst (reverse lst))
    )
	(vl-file-delete scriptfile)
	(if (/= lst nil) 
	(progn
	(setq newverint  (atof (nth 0 lst)))
	(if (< KTS_version newverint)
	(setq vcheck 1)
	(setq vcheck 0)
	)
	(princ (strcat "\nCurrent version: " (rtos KTS_version) "\nOnline  version: " (rtos newverint)"\n")) 
	)
	(progn
	(setq vcheck 0)
	(princ "\n Datafile is empty. Please retry later" )
	)
	)
	)
	(setq vcheck 0)
	)
	vcheck
)

(defun KTS_update ( / list1 newverint KTSPathSource KTSPathDest count scriptfile)
   ;Default paden
  (setq Temp (getenv "Temp"))
  (setq KTSPathSource (strcat (getenv "Temp") "\\KiTek_Steel"))
  (setq KTSPathDest (vl-filename-directory (findfile "KT_Stl.lin")))
  (setq scriptfile (create_updvbs))
  (princ "\nClosing Kitek Steel")  
  (princ "\nClosing AutoCad")
  (startapp (strcat "CSCRIPT.EXE //nologo " (vl-prin1-to-string scriptfile)
;     " " (vl-prin1-to-string LabPathSource)
     " " (vl-prin1-to-string KTSPathDest)
     " " (vl-prin1-to-string Temp)
     " " (vl-prin1-to-string "https://github.com/JoakinKirschen/kitek_steel/archive/master.zip")
     ))
  (exit)
;  (if (vl-file-directory-p KTSPathDest)
;  (progn
;  (if (vl-file-directory-p KTSPathSource)
;  (KTS_DeleteFolder KTSPathSource)
;  )
;  (vl-mkdir KTSPathSource)
;  (princ "\nDownloading Files")
 ; (KTS_GetFileFromURL "http://www.kitek.be/data/kitek_steel.exe" (strcat KTSPathSource "\\"))
; 
;  (setq scriptfile (findfile "KT_dl.vbs")) 
;  (startapp (strcat "CSCRIPT.EXE //nologo " (vl-prin1-to-string scriptfile) " " (vl-prin1-to-string "http://www.kitek.be/data/kitek_steel.exe")))
;  (setq count 0)
;  (while (and 
;			(<= count 15)
;			(not
;				(findfile (strcat (getenv "Temp") "\\kitek_steel.exe"))
;		))
;  (KTS_wait 1)
;  (princ "/")
;  (setq count (+ count 1))
;  )
;  
;  (princ "\nExtracting the file archive\n")
;  (startapp (strcat (getenv "Temp") "\\kitek_steel.exe"))
;  (setq count 0)
;  (while (and (<= count 15)
;		(not (and 
;		(vl-file-directory-p (strcat KTSPathSource "\\Blocks"))
;		(vl-file-directory-p (strcat KTSPathSource "\\Slides"))
;		)))
;  (KTS_wait 1)
;  (princ "/")
;  (setq count (+ count 1))
;  )
;  (KTS_wait 3)
;  (if (>= count 15)(progn (princ "File extraction failed")(exit)))
;  (vl-file-delete  (strcat (getenv "Temp") "\\kitek_steel.exe"))
 ; (if (vl-file-directory-p KTSPathDest)
;  (KTS_DeleteFolder KTSPathDest)
 ; )
;  (vl-mkdir KTSPathDest)
;  (KTS_CopyFolder KTSPathSource KTSPathDest)
;  )
;  (alert (strcat "Update not possible.\nMake sure KiTek Steel is installed on " KTSPathDest ))
;  )
;  (alert "Update Successful.\nPlease restart Autocad.")
;  (exit)
;  (princ)
)

(defun KTS_DeleteFolder (path / fso)
  (if (and (setq fso (vlax-get-or-create-object "Scripting.FileSystemObject"))
           (= -1 (vlax-invoke fso 'folderexists path)))
    (progn
      (vlax-invoke (vlax-invoke fso 'getfolder path) 'delete)
      (vlax-release-object fso)))
  (princ)
)

(defun KTS_CopyFolder (source target / fso)
  (setq FSO (vlax-create-object "Scripting.FilesystemObject"))
  (if (= -1 (vlax-invoke fso 'folderexists source))
    (vlax-invoke fso 'copyfolder source target)
  )
  (vlax-release-object fso)
)

(defun KTS_GetFileFromURL (url dir / byte fic file fso http ok tbl taille)
  (setq http (vlax-create-object "MSXML2.XMLHTTP")
        fso  (vlax-create-object "Scripting.FileSystemObject")
        file (strcat dir (vl-filename-base url) (vl-filename-extension url)))
  (vlax-invoke-method http 'open "get" url :vlax-false)
  (vl-mkdir dir)
  (if (vl-catch-all-error-p (vl-catch-all-apply 'vlax-invoke (list http 'send)))
    (princ (strcat "\nThe web address " url " is not valid."))
    (if (eq (vlax-get http 'status) 200)
      (if (vl-catch-all-error-p (setq taille (vl-catch-all-apply 'vlax-invoke (list http 'getResponseHeader "Content-Length"))))
        (princ "\nIncorrect file size please install manually.")
        (if (< (atoi taille) (vlax-get (vlax-invoke fso 'getdrive (substr (vlax-invoke fso 'getabsolutepathname file) 1 1)) 'freespace))
          (progn
            (princ "\nDownload in progress...")(princ)
            (while (not (eq (vlax-get http 'readystate) 4))
              (vla-eval (vlax-get-acad-object) "DoEvents")
            )
            (setq tbl (vlax-safearray->list (vlax-variant-value (vlax-get-property http 'responsebody))))
            (if (vl-catch-all-error-p (setq fic (vl-catch-all-apply 'vlax-invoke (list fso 'createtextfile file))))
              (princ (strcat "\nImpossible to create file " file))
              (progn
                (foreach byte tbl
                  (vlax-invoke fic 'write (vl-list->string (list (- 333 byte))))
                )
                (vlax-invoke fic 'close)
                (setq ok T)
              )
            )
          )
        )
      )
      (princ (strcat "\n" (vlax-get http 'statustext) "...Error " (itoa (vlax-get http 'status)) "."))
    )
  )
  (vlax-release-object http)
  (vlax-release-object fso)
  ok
)
 
(defun KTS_GetFileFromURLold  (url path / utilObj tempPath newPath voidPath)
  ;; © RenderMan 2011, CADTutor.net
  ;; Example: (download "http://www.indiesmiles.com/wp-conten...0/12/SMILE.jpg" (getvar 'dwgprefix))
  (setq utilObj (vla-get-utility
                  (vla-get-activedocument (vlax-get-acad-object))))
  (if (= :vlax-true (vla-isurl utilObj url))
    (if (vl-catch-all-error-p
          (vl-catch-all-apply
            'vla-GetRemoteFile
            (list utilObj url 'tempPath :vlax-true)))
      (prompt "\n  <!>  Error Downloading File From URL  <!> ")
      (progn
        (if (findfile
              (setq newPath
                     (strcat path
                             (vl-filename-base url)
                             (vl-filename-extension url))))
          (vl-file-rename
            newPath
            (setq voidPath
                   (strcat
                     (vl-filename-directory newPath)
                     "\\void_"
                     (vl-filename-base newPath)
                     "_"
                     (menucmd
                       "M=$(edtime,$(getvar,date),YYYY-MO-DD-HH-MM-SS)")
                     (vl-filename-extension newPath)))))
        (vl-file-copy tempPath newPath)
        (vl-file-delete tempPath)))
    (prompt "\n  <!>  Invalid URL  <!> "))
  (vl-catch-all-apply 'vlax-release-object (list utilObj))
  (princ)
 )
 
(defun KTS_MLayer (layName color linetype lineweight plot  / discipline)
(if (= lineweight "Default")
(setq lineweight (- 0 3))
(setq lineweight (fix(*(atof lineweight)100)))
)
(if (= (tblSearch "LAYER" layName) nil)
  (progn
  (If (= (TBLSEARCH "LTYPE" linetype) nil)
		(command "-linetype" "l" linetype "KT_Stl.lin" "")
  )
  (entmake (list (cons 0 "LAYER")
                 (cons 100 "AcDbSymbolTableRecord")
                 (cons 100 "AcDbLayerTableRecord")
				 (cons 290 plot)
				 (cons 370 lineweight)
                 (cons 2 layName)
				 (cons 6 linetype)
                 (cons 70 0)
                 (cons 62 (atoi color))
            )
  )
  )
)
(setvar "CLAYER" layName)
(princ)
)

(defun KTS_GetDynamicPropValue ( block prop ) 
(setq prop (strcase prop))
  (vl-some
    (function
      (lambda ( _prop )
        (if (eq prop (strcase (vla-get-propertyname _prop)))
          (vlax-get _prop 'Value)
        )
      )
    )
    (vlax-invoke block 'GetDynamicBlockProperties)
  )
)

(defun c:KTS_name1 ()
(KTS_nameman 1)
)

(defun c:KTS_name2 ()
(KTS_nameman 2)
)

(defun c:KTS_auto ()
(KTS_nameauto)
)

(defun KTS_nameman (version / ss stringa stringb stringab inpt s ang tl txtanno txthei txtlay txtcol txtfont schaal Laylist hoogte box)

  (if (setq ss (ssget "_+.:E:S" '((0 . "INSERT"))))
    (progn
	(KTS_initerr)
	(setq Laylist (KTS_getlaylist (KTS_getslotpos)))
	(setq txtanno (nth 22 Laylist))
	(setq txthei (nth 23 Laylist))
	(setq txtlay (nth 24 Laylist))
	(setq txtcol (KTSstl_findcol (nth 25 Laylist)(nth 26 Laylist)))
	(setq txtfont (nth 27 Laylist))

    (setq stringa
      (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss 0)) "Lookup")
    )
	(setq stringb
      (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss 0)) "Lookup1")
    )
	(if (/= stringa nil) 
	(progn
	
	(if (= stringb nil) 
	(setq stringb "")
	(setq stringb (KTS_replacestring stringb "t" "x" ))
	)
	(setq stringc "")
	(if (= (substr (vla-get-Effectivename (vlax-ename->vla-object (ssname ss 0))) 6 3) "EXI")
	(setq stringc (nth 29 Laylist))
	)
	(setq stringab (KTS_nostring (strcat stringa stringb stringc)))
	(setq s (ssname ss 0))
    (setq ang (cdr (assoc 50 (entget s))))
	(princ ang)
	(if (and (> ang (/ pi 2))(<= ang (/ (* 3 pi) 2)))
	(setq ang (+ ang pi))
	)
	(princ ang)
	(setvar "osmode" 0)
	(setq inpt (getpoint "\nPick the position of the text-field:"))
;	(setq inpt (vlax-get (vlax-ename->vla-object (ssname ss 0))'insertionpoint))
	(command ".-style" "KTS_Style" txtfont "" "1" "" "" "")
	(KTS_MLayer txtlay txtcol "Continuous" "Default" 1)

	(if (and (findfile "LAB2012.mnl")(= (nth 28 Laylist) "1"))
	(progn
	(setq schaal (L12_getschaal))
	)
	(if (= txtanno "0")
	(setq schaal 1)
	(setq schaal (/ 1 (getvar "cannoscalevalue")))
	)
	)
	
	(setq hoogte (* schaal (atof txthei)))
	(setq box (strcat "@" "0" "," (rtos hoogte)))

    (command "_.mtext" inpt "_height" hoogte box stringab "")

	(if (= version 2)
	(progn
	(setq  tl (entget(entlast)))
    (setq  tl (subst (cons 50 ang) (assoc 50 tl) tl))
    (setq  tl (entmod tl))
	)
	)
	)
	)
	(KTS_reset2) 
	)
  )
 
)

(defun c:KTS_getkilo (/ ss i n m kg stringa stringb len cnt1 cnt2 cnt3 lst sublst1 sublst2)
  (if (setq ss (ssget "_+.:E" '((0 . "INSERT"))))
	(progn
	(KTS_initerr)
	
	(setq 
	   i 0
       n (sslength ss)
	   kg 0
	   m 0
    )
	 
	(while (< i n)
		(KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss i)) "Lookup")
		(setq stringa (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss i)) "Lookup"))
		(setq stringb (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss i)) "Lookup1"))
		
		(setq len (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss i)) "Linear"))
		(setq cnt1 0)
		(setq cnt3 0)
		(setq lst (KTS_Libary))
		
		
		(while (< cnt1 (length lst))
			(setq sublst1 (nth cnt1 lst))
			(setq cnt2 (+ 1 cnt3))
				(while (< cnt2 (length sublst1))
					(setq sublst2 (nth cnt2 sublst1))
						(if (member stringa sublst2)
						    (progn
							(setq kg (+ kg (* (/ len 1000) (nth 0(nth 1 sublst2)))))	
							(setq cnt3 (length sublst1))
							(setq cnt1 (length lst))
							(setq m (+ m 1))
							)
						)
					(setq cnt2 (+ cnt2 1))
;					(princ " lvl2_")
				)
			(setq cnt1 (+ cnt1 1))
;			(princ " lvl1_")
;			(princ cnt1)
		)
;		(princ "lvl0_")
;	    (princ n)

	(setq i (+ i 1))
	)
	
	(prompt (strcat "\n" (itoa m) " of " (itoa n) " profiles processed.\n Total " (rtos kg) "kg \n"))
	)
  )
  (princ)
)
	

(defun KTS_nameauto ( / ss stringa stringb stringc stringab iptx ipty iptz inpt s ang tl txtanno txthei txtlay txtcol txtfont schaal Laylist hoogte box)

  (if (setq ss (ssget "_+.:E:S" '((0 . "INSERT"))))
    (progn
	(KTS_initerr)
	(setq Laylist (KTS_getlaylist (KTS_getslotpos)))
	(setq txtanno (nth 22 Laylist))
	(setq txthei (nth 23 Laylist))
	(setq txtlay (nth 24 Laylist))
	(setq txtcol (KTSstl_findcol (nth 25 Laylist)(nth 26 Laylist)))
	(setq txtfont (nth 27 Laylist))
;++++Scale settings	
	(if (and (findfile "LAB2012.mnl")(= (nth 28 Laylist) "1"))
	(progn
	(setq schaal (L12_getschaal))
	)
	(if (= txtanno "0")
	(setq schaal 1)
	(setq schaal (/ 1 (getvar "cannoscalevalue")))
	)
	)
	(setq hoogte (* schaal (atof txthei)))
;++++String settings
    (setq stringa (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss 0)) "Lookup"))
	(setq stringb (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss 0)) "Lookup1"))
	(if (/= stringa nil) 
	(progn
	
	(if (= stringb nil) 
	(setq stringb "")
	(setq stringb (KTS_replacestring stringb "t" "x" ))
	)
	(setq stringc "")
	(if (= (substr (vla-get-Effectivename (vlax-ename->vla-object (ssname ss 0))) 6 3) "EXI")
	(setq stringc (nth 29 Laylist))
	)
	(setq stringab (KTS_nostring (strcat stringa stringb stringc)))
;++++Possistioning settings	
	(setq s (ssname ss 0))
    (setq ang (cdr (assoc 50 (entget s))))
	(if (and (> ang (/ pi 2))(<= ang (/ (* 3 pi) 2)))
	(setq ang (+ ang pi))
	)
;	(princ ang)
	(setvar "osmode" 0)
;	(setq inpt (getpoint "\nPick the position of the text-field:"))
	(setq inpt (vlax-get (vlax-ename->vla-object (ssname ss 0))'insertionpoint))
	(setq iptx (car inpt))
	(setq ipty (cadr inpt))
	(setq iptz (caddr inpt))
;(+ (/ deltab 2)(/ hoogte 7)))))	
	(if (setq deltab (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss 0)) "b"))
	(progn
	(setq iptx (- iptx (* (sin ang)(+ (/ hoogte 3) (/ deltab 2)))))
	(setq ipty (+ ipty (* (cos ang)(+ (/ hoogte 3) (/ deltab 2)))))
	)
	)
	(if (setq deltah (KTS_GetDynamicPropValue (vlax-ename->vla-object (ssname ss 0)) "h"))
	(progn
	(setq iptx (- iptx (* (sin ang)(+ (/ hoogte 3) (/ deltah 2)))))
	(setq ipty (+ ipty (* (cos ang)(+ (/ hoogte 3) (/ deltah 2)))))
	)
	)
	(princ hoogte)
	(setq inpt (list iptx ipty iptz))

	(command ".-style" "KTS_Style" txtfont "" "1" "" "" "")
	(KTS_MLayer txtlay txtcol "Continuous" "Default" 1)

	
	(setq box (strcat "@" "0" "," (rtos hoogte)))

    (command "_.mtext" inpt "_justify" "BC" "_height" hoogte box stringab "")

	(setq  tl (entget(entlast)))
    (setq  tl (subst (cons 50 ang) (assoc 50 tl) tl))
    (setq  tl (entmod tl))

	)
	)
	(KTS_reset2) 
	)
  )
 
)

;vl-remove-blanks
(defun KTS_nostring (string)
(vl-list->string
  (vl-remove
    32
  (vl-string->list string )))
)

(defun KTS_replacestring (str a b / )
  ;; Remove all spaces from string
  ;; str - valid string
  ;; Alan J. Thompson, 03.20.09
  (if (eq (type str) 'STR)
    (while (vl-string-search a str)
      (setq str (vl-string-subst b a str))
    )
  )
  str
)

(defun KTS_deleteposition ( n lst / lstn )
    (setq n (1+ n))
    (foreach x lst (if (/= 0 (setq n (1- n))) (setq lstn (cons x lstn))))
    (reverse lstn)
)


(defun KTS_check_editreal (SentVar$ / Cnt# Loop Mid$ Passed Period# SubVar$)
  (setq SubVar$ (eval (read SentVar$)))
  (setq Cnt# 1 Passed t Period# 0)
  (repeat (strlen $value)
    (setq Mid$ (substr $value Cnt# 1))
    (if (not (member Mid$ (list "." "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
      (setq Passed nil)
    );if
    (if (= Mid$ ".")(setq Period# (1+ Period#)))
    (setq Cnt# (1+ Cnt#))
  );repeat
  (if (> Period# 1)(setq Passed nil))
  (if (not Passed)
    (progn
      (alert "Value must be a real number!")
      (set_tile $key SubVar$)
    );progn
    (if (= $value "")
      (set (read SentVar$) $value)
      (progn
        (setq Loop t Cnt# 8)
        (while Loop
          (setq $value (rtos (atof $value) 2 Cnt#))
          (if (= (atof $value) (atof (rtos (atof $value) 2 (1- Cnt#))))
            (setq Cnt# (1- Cnt#))
            (setq Loop nil)
          );if
          (if (= Cnt# 0) (setq Loop nil))
        );while
        (set (read SentVar$) $value)
        (set_tile $key $value)
      );progn
    );if
  );if
  (princ)
);defun check_editreal

(defun KTS_urlping (address / out ws)
  (if (setq ws (vlax-get-or-create-object "WScript.Shell"))
    (progn (setq out (vlax-invoke ws 'run (strcat "ping.exe -n 1 " address) 0 :vlax-true))
	   (and ws (vlax-release-object ws))
	   (zerop out)
    )
  )
  (princ)
)

(defun KTS_upDateBanner ( )

	(setq sldName "banner(BANNER1)")
	
	
	;;;--- Get the width of the slide
	(setq width (dimx_tile "image2"))

	;;;--- Get the height of the slide
	(setq height (dimy_tile "image2"))

	;;;--- Start the slide definition
	(start_image "image2")

	;;;--- Wipe out the background
	(fill_image 0 0 width height 0)

	;;;--- Put the slide in the image area
	(slide_image 0 0 width height sldName)

	;;;--- Finish the slide definition
	(end_image)
(princ)	
)

(defun KTS_initerr ()					;init error
  (setq oldlayer (getvar "clayer"))			;save settings
  (setq oldsnap (getvar "osmode"))
  (setq oldpick (getvar "pickbox"))
  (setq temperr *error*)				;save *error*
  (setq *error* KTS_trap)					;reassign *error*
  (princ)
)

(defun KTS_trap (errmsg)					;define trap
;  (command nil nil nil)
  (if (not (member errmsg '("console break" "Function Cancelled"))
      )
    (princ (strcat "\nError: " errmsg))			;print message
  )                 
; (command "undo" "b")					;undo back
  (setvar "clayer" oldlayer)				;reset settings
  (setvar "blipmode" 0)
  (setvar "menuecho" 0)
  (setvar "cmdecho" 1)
  (setvar "highlight" 1)
  (setvar "luprec" 2)
  (setvar "osmode" oldsnap)
  (setvar "pickbox" oldpick)
;  (princ "\nError Resetting Enviroment ")		;inform user
  (terpri)
  (setq *error* temperr)				;restore *error*
  (princ)
);defun
;;;*===========================================================
(defun KTS_reset2 ()						;define reset
  (setq *error* temperr)				;restore *error*
  (setvar "clayer" oldlayer)				;reset settings
  (setvar "blipmode" 0)
  (setvar "menuecho" 0)
  (setvar "cmdecho" 1)
  (setvar "highlight" 1)
  (setvar "luprec" 2)
  (setvar "osmode" oldsnap)
  (setvar "pickbox" oldpick)
  (princ)
)

(defun KTS_wait (seconds / stop)
(setq stop (+ (getvar "DATE") (/ seconds 86400.0)))
(while (> stop (getvar "DATE")))
);defun

(defun create_dlvbs ()

;(vl-file-delete "KT_Temp.vbs")
(setq fname (vl-filename-mktemp "KT_Temp.vbs"))

(setq fn (open fname "w"))

(write-line "Set args = WScript.Arguments
 
dim Url, myPath, a, filename
dim xHttp: Set xHttp = createobject(\"MSXML2.ServerXMLHTTP.3.0\")
dim bStrm: Set bStrm = createobject(\"Adodb.Stream\")
Const TemporaryFolder = 2

Url = Wscript.Arguments.Item(0)

a=split(Url,\"/\")
filename=a(ubound(a))

Set objFSO = CreateObject( \"Scripting.FileSystemObject\" )

myPath = objFSO.GetSpecialFolder(TemporaryFolder) & \"/\" & filename 

xHttp.Open \"GET\", Url, False
xHttp.Send
 
with bStrm
    .type = 1 '//binary
    .open
    .write xHttp.responseBody
    .savetofile myPath, 2 '//overwrite
end with

 " fn)

(close fn)

fname

)

(defun create_updvbs ()

;(vl-file-delete "KT_Temp.vbs")
(setq fname (vl-filename-mktemp "KT_Temp.vbs"))

(setq fn (open fname "w"))

(write-line "Set args = WScript.Arguments
 
'// you can get url via parameter like line below
'//Url = args.Item(0)
Dim oShell : Set oShell = CreateObject(\"WScript.Shell\")
Dim fso : Set fso = CreateObject(\"Scripting.FileSystemObject\")

Dim KTSPathDest, Temp, UserPath, PlotPath, PMPPath, PlotStyles, Plotters, sTemp, iTemp1, Url

Const TemporaryFolder = 2

oShell.Run \"taskkill /im acad.exe\", 1, True

iTemp1 = 0

set service = GetObject (\"winmgmts:\")

Do while iTemp1 = 0
	iTemp1 = 1
	for each Process in Service.InstancesOf (\"Win32_Process\")
		If Process.Name = \"acad.exe\" then
			iTemp1 = 0
			Wscript.Sleep (500)
		End If
	next
loop

Wscript.Echo \"AutoCad has been closed\"

bslash = Chr(92)
dblbslash = Chr(92) & Chr(92)

'LabPathSource = (Replace(Wscript.Arguments.Item(0),dblbslash,bslash))
KTSPathDest = (Replace(Wscript.Arguments.Item(0),dblbslash,bslash))
Temp = (Replace(Wscript.Arguments.Item(1),dblbslash,bslash))
" fn)


(write-line "Wscript.Echo \"Downloading update\"
'//Download zip from GitHub
dim myPath, a, filename
dim xHttp: Set xHttp = createobject(\"MSXML2.ServerXMLHTTP.3.0\")

Url = Wscript.Arguments.Item(2)

a=split(Url,\"/\")
filename=a(ubound(a))

myPath = fso.GetSpecialFolder(TemporaryFolder) & \"/\" & filename 

xHttp.Open \"GET\", Url, False
xHttp.Send

'Wscript.Echo \"Download-Status: \" ^& xHttp.Status ^& \" \" ^& xHttp.statusText
 
If xHttp.Status = 200 Then
    Dim objStream
    set objStream = CreateObject(\"ADODB.Stream\")
    objStream.Type = 1 'adTypeBinary
    objStream.Open
    objStream.Write xHttp.responseBody
    objStream.SaveToFile myPath,2
    objStream.Close
    set objStream = Nothing
End If
set xHttp=Nothing

Wscript.Echo \"Download complete\"

'//Delete existing version

Wscript.Echo \"Deleting existing KTS folder\"
Const ReadOnly = 1
'Set fso = CreateObject(“Scripting.fsotemObject”)
Set objFolder = fso.GetFolder(KTSPathDest)
Set colFiles = objFolder.Files
For Each objFile in colFiles
    If objFile.Attributes AND ReadOnly Then
        objFile.Attributes = objFile.Attributes XOR ReadOnly
    End If
Next

If fso.FolderExists(KTSPathDest) Then  
    fso.DeleteFolder KTSPathDest, True
End If 
" fn)

(write-line "
'//Extract new version
Wscript.Echo \"Extracting new version\"
'The location of the zip file.
ExtractTo=fso.GetSpecialFolder(TemporaryFolder) 
ZipFile=ExtractTo & bslash & filename 

Set objFolder = fso.GetFolder(ExtractTo)
Set colFiles = objFolder.Files
For Each objFile in colFiles
    If objFile.Attributes AND ReadOnly Then
        objFile.Attributes = objFile.Attributes XOR ReadOnly
    End If
Next

ExtractFolder = ExtractTo & \"\\kitek_steel-master\"

If fso.FolderExists(ExtractFolder) Then
   fso.DeleteFolder ExtractFolder, True
End If
'If NOT fso.FolderExists(ExtractTo) Then
'   fso.CreateFolder(ExtractTo)
'End If

'Extract the contants of the zip file.
set objShell = CreateObject(\"Shell.Application\")
set FilesInZip = objShell.NameSpace(ZipFile).items
objShell.NameSpace(ExtractTo).CopyHere(FilesInZip)
Set objShell = Nothing

CopySource=fso.GetSpecialFolder(TemporaryFolder) & \"\\kitek_steel-master\"

Wscript.Echo \"Copying new version\"
If fso.FolderExists(CopySource) Then 
    fso.CopyFolder CopySource, KTSPathDest 
End If

Parrent = fso.GetParentFolderName(PlotPath) & bslash

'MsgBox(Parrent)

Wscript.Echo \"Cleanup installation\"

If fso.FolderExists(ExtractFolder) Then
   fso.DeleteFolder ExtractFolder, True
End If

fso.DeleteFile(fso.GetSpecialFolder(TemporaryFolder) & bslash & filename) 'Deletes the file throught the DeleteFile function

Set fso = Nothing

MsgBox(\"Update Successful\")" fn)

(close fn)

fname

)

(princ)
