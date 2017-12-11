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
(if (not KT_Blt_Lib_EN)(LOAD "KT_Blt_Lib_EN"))

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
	(if (not *KT_Blt@)
		(setq *KT_Blt@ (list nil "" "" "" "" "" "" "" "" "" ""))
	)
	
	;need to set layers in register


	; set up data
	(setq 	Value1$ (nth 1 *KT_Blt@)      ;Value list string value list 1 (Main section)
			Value2$ (nth 2 *KT_Blt@)      ;Value list string value list 2 (Sub section)
			Value3$ (nth 3 *KT_Blt@)      ;Value list atoi value list 1
			Value4$ (nth 4 *KT_Blt@)      ;Value list atoi value list 2
			Value5$ (nth 5 *KT_Blt@)      ;Value list atoi value list 3
			Radio1$ (nth 6 *KT_Blt@)      ;Value radio 1
			;Radio2$ (nth 7 *KT_Stl@)      ;Value radio 2
			Image1$ (nth 8 *KT_Blt@)	   ;Image value
			;Value6$ (nth 9 *KT_Stl@)	   ;Rotation (Rot)
			;Toggle2$ (nth 10 *KT_Stl@)	   ;Flip     (Flip)
	)

	(setq list1@ (KT_Blt_Lib_EN))
	(setq mainlist (mapcar 'car list1@))	;M8 M10; M12 etc

	; Load the DCL file.
	(setq Dcl_Id% (load_dialog "KT_Blt.dcl"))
	(if (not (new_dialog "KT_Blt" Dcl_Id%))    ; Initialize the dialog.
		(exit)                                  ; Exit if this doesn't work
	)                                           ; work.



	; Preset data
			;; fill "popup" with CAR item of myList
			(start_list "list_1")
			(mapcar 'add_list mainlist)
			(end_list)

			;; fill "listbox" according to default value of "popup" (value
			;; of zero unless otherwise specified in the dcl definition)
		(if (= Value1$ "") (setq Value1$ (caar list1@))) ;M8;M10;etc
		(if (= Value2$ "") (setq Value2$ (car(cadr(car list1@))))) ;SBS SHS
		(if (= Value3$ "") (setq Value3$ 0)) ;M8;M10;etc
		(if (= Value4$ "") (setq Value4$ 0)) ;SBS SHS
		(if (= Value5$ "") (setq Value5$ 0))
		(if (= Radio1$ "") (setq Radio1$ "V_Front")) ;View
		;(if (= Radio2$ "") (setq Radio2$ "Draw_a")) Top Center Bottom
		(if (= Image1$ "") (setq Image1$ "BOLT_SBS_SIDE"))
		;(if (= Value6$ "") (setq Value6$ "+0°")) Rotate
		;(if (= Toggle2$ "") (setq Toggle2$ "0")) Flip
		


	; Preset data
		(set_tile "ver_kts" (strcat "KiTek Bolt v" (rtos KTS_version 2 2 ) " --- by Joakin Kirschen --- info@kitek.be"))
		(set_tile "Radio1" Radio1$) ;View front top bottom
		;(set_tile "Radio2" Radio2$)
		;(set_tile "Rot" Value6$)
		;(set_tile "Flip" Toggle2$)
		(KTS_set_tile_list "list_1" mainlist Value1$) ;M8 etc dropdownlist
		(setq subitems (KTS_populate_list "list_2" Value3$ list1@ '("editbox")))
		(KTS_set_tile_list "list_2" subitems Value2$)
		(setq proplist (KTB_Proplist Value1$ Value3$ Value4$ list1@ ))
		;(setq anglist (KTS_Rotlist Value5$))
		;(KTS_set_tile_list "list_3" anglist Value6$)
		(setq Image1$ (KTB_upDateImage Value2$ Radio1$ Image1$))
		(KTS_upDateBanner)

	; Actions

			;; define callback to populate "listbox" according to
			;; users choice in the "popup" tile. Save list of items
			;; in order to extract an item from the list_box tile
			;; (also clear any choices in affected tiles when replacing list)
		(action_tile "list_1" "(setq subitems (KTS_populate_list \"list_2\" (atoi $value) list1@ '(\"editbox\")))
		(setq Value3$ (atoi $value))
		(setq temp Value1$)

		(KTS_set_list_value \"mainlist\" \"Value1$\")

		(KTS_set_tile_list \"list_2\" subitems Value2$)
		(setq proplist (KTB_Proplist Value1$ Value3$ Value4$ list1@ ))
		(setq Image1$ (KTB_upDateImage Value2$ Radio1$ Image1$))
		")

			;; define callback to populate "editbox" and save current
			;; choice in order to return it
		; bepaalt de size (M8;M10 etc)
		(action_tile "list_2" "(set_tile \"editbox\" (setq item (nth (setq Value4$ (atoi $value)) subitems)))
		(KTS_set_list_value \"subitems\" \"Value2$\")	
		(setq proplist (KTB_Proplist Value1$ Value3$ Value4$ list1@ ))
		(setq Image1$ (KTB_upDateImage Value2$ Radio1$ Image1$))
		")
		
		; bepaalt de view (front top back etc.)
		(action_tile "Radio1" "(setq Radio1$ $value)
		(setq anglist (KTS_Rotlist Value5$))
		(setq Image1$ (KTB_upDateImage Value2$ Radio1$ Image1$))
		")

		(action_tile "cancel" "(setq ddiag 1)(done_dialog)")
		(action_tile "Draw_N" "(setq ddiag 2)(done_dialog)")
		(action_tile "Draw_E" "(setq ddiag 3)(done_dialog)")
		(action_tile "Settings"   "(setq ddiag 4)(done_dialog)")
		(action_tile "image2"   "(startapp \"explorer\" \"http://www.kitek.be\")")
		(setq Return# (start_dialog))
	; Unload Dialog
		(unload_dialog Dcl_Id%)
			(princ "Value1$")(princ Value1$)
	(princ "Value2$")(princ Value2$)
	(princ "Value3$")(princ Value3$)
	(princ "Value4$")(princ Value4$)
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
		(setq *KT_Blt@ (list nil Value1$ Value2$ Value3$ Value4$ Value5$ Radio1$ Radio2$ Image1$ Value6$ Toggle2$))
		(Cond
		(
		(= Radio1$ "V_Front")
		(Cond
			;((= Value1$ "M8") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			;((= Value1$ "M10") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			;((= Value1$ "M12") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			;((= Value1$ "M16") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			;((= Value1$ "M20") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			;((= Value1$ "M24") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			;((= Value1$ "M30") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "M8") (KTB_run1 Value1$ Value2$ Radio1$ prestring ddiag))
			((= Value1$ "M10") (KTB_run1 Value1$ Value2$ Radio1$ prestring ddiag))
			((= Value1$ "M12") (KTB_run1 Value1$ Value2$ Radio1$ prestring ddiag))
			((= Value1$ "M16") (KTB_run1 Value1$ Value2$ Radio1$ prestring ddiag))
			((= Value1$ "M20") (KTB_run1 Value1$ Value2$ Radio1$ prestring ddiag))
			((= Value1$ "M24") (KTB_run1 Value1$ Value2$ Radio1$ prestring ddiag))
			((= Value1$ "M30") (KTB_run1 Value1$ Value2$ Radio1$ prestring ddiag))
			(nil ())
			)
		)
		(
		(= Radio1$ "V_Top")
		(Cond
		((= Value1$ "M8") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "M10") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "M12") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "M16") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "M20") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "M24") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			((= Value1$ "M30") (KTB_run1 Value1$ Value2$ Radio1$ Radio2$ Value6$ Toggle2$ proplist prestring ddiag))
			(nil ())
			)
		)
		(
		(= Radio1$ "V_Section")
		(Cond
			((= Value1$ "M10") (KTB_run1 Value1$ Value2$ Radio1$ proplist prestring ddiag))
			((= Value1$ "M12") (KTB_run1 Value1$ Value2$ Radio1$ proplist prestring ddiag))
			((= Value1$ "M16") (KTB_run1 Value1$ Value2$ Radio1$ proplist prestring ddiag))
			((= Value1$ "M20") (KTB_run1 Value1$ Value2$ Radio1$ proplist prestring ddiag))
			((= Value1$ "M24") (KTB_run1 Value1$ Value2$ Radio1$ proplist prestring ddiag))
			((= Value1$ "M30") (KTB_run1 Value1$ Value2$ Radio1$ proplist prestring ddiag))
			(nil ())
			)
		)
		(nil ())
		)
	)
	)
	(princ)
	)
	
(defun KTB_Proplist (val1 val3 val4 lst / level1 level2 val2)
	(setq index (+ val4 1))
	(setq level1 (nth val3 lst))
	(setq level2 (cadr(nth index level1)))
	(Cond
		((= val1 "M8")
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
		((= val1 "M10")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
		))
		((= val1 "M12")
			(progn
			(set_tile "shp_e" (strcat "Weight:\t "  (rtos (nth 0 level2 ) 2 1) "\t kg/m"))
			(set_tile "shp_a" (strcat "Height:\t "    (rtos (nth 1 level2 ) 2 1) "\t mm"))
			(set_tile "shp_b" (strcat "Width:\t "   (rtos (nth 2 level2 ) 2 1) "\t mm"))
			(set_tile "shp_c" (strcat "Web:\t "      (rtos (nth 3 level2 ) 2 1) "\t mm"))
			(set_tile "shp_d" (strcat "Flange:\t "   (rtos (nth 4 level2 ) 2 1) "\t mm"))
			(set_tile "shp_f" (strcat "Area:\t "    (rtos (nth 5 level2 ) 2 1) "\t mm²"))
			(set_tile "shp_g" (strcat "Ø max:\t "   (if (=(nth 6 level2 ) "")""(strcat "M"(rtos (nth 6 level2 ) 2 1))) ))
		))
		((= val1 "M16")
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
		((= val1 "M20")
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
			((= val1 "M24")
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
		((= val1 "M30")
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
	)
	(princ)
	level2
	)
	
	(defun KTB_upDateImage (washer view sldName /)

	(cond
		((= washer "NONE")
			(cond
			((= view "V_Front")(setq sldName "BOLT(BOLT_HEAD)"))
			((= view "V_Top")(setq sldName "BOLT(BOLT_NUT)"))
			((= view "V_Section")(setq sldName "BOLT(BOLT_NONE_SIDE)"))
			(nil())
			))
		((= washer "SBS")
			(cond
			((= view "V_Front")(setq sldName "BOLT(BOLT_HEAD_WASHER)"))
			((= view "V_Top")(setq sldName "BOLT(BOLT_NUT_WASHER)"))
			((= view "V_Section")(setq sldName "BOLT(BOLT_SBS_SIDE)"))
			(nil())
		))
		((= washer "SHV")
			(cond
			((= view "V_Front")(setq sldName "BOLT(BOLT_HEAD_WASHER)"))
			((= view "V_Top")(setq sldName "BOLT(BOLT_NUT_WASHER)"))
			((= view "V_Section")(setq sldName "BOLT(BOLT_SHV_SIDE)"))
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
	
	(defun KTB_run1 (boltsize washer view prestring ddiag / ppt1 ppt2 ppt3 osv dist ang  iptx ipty bptx bpty ipt width height fl ang2)
	;(if (and (setq ppt1 (getpoint "\nFirst insertion point"))(setq ppt2 (getpoint ppt1 "\nSecond insertion point")))
	(if (setq ppt1 (getpoint "\nFirst insertion point"))
	(progn
	;(setq dist (distance ppt1 ppt2))
	;(if (> (car ppt1) (car ppt2))
	;	(progn
	;		(setq ppt3 ppt1)
	;		(setq ppt1 ppt2)
	;		(setq ppt2 ppt3)
	;	)
	;)
	;(setq factor (Unitfactor))
	;(setq height (* (nth 1 props) factor))
	;(setq width (* (nth 2 props) factor))
	;(setq ang  (*(/ (angle ppt1 ppt2)Pi)180))
	(setq ang 0)
	;(setq ang2 (angle ppt1 ppt2))
	(setq iptx (car ppt1))
	(setq ipty (cadr ppt1))
	;(setq fl 1)
	;(setq iptx (+ bptx   (*(cos ang2) 500 factor fl)))
	;(setq ipty (+ bpty   (*(sin ang2) 500 factor fl)))
;	(setq ipty (+(+ bpty (*(sin ang2) 500 factor fl)) (*(cos ang2)(/ height 2) )))
;	(setq iptx (-(+ bptx (*(cos ang2) 500 factor fl)) (*(sin ang2)(/ height 2) )))
		(setq ipt (list iptx ipty))
;		(Cond
;		((= boltsize "HEA") (KTB_InsDynBlock "HEA_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "HEB") (KTB_InsDynBlock "HEB_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "HEM") (KTB_InsDynBlock "HEM_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "IPE") (KTB_InsDynBlock "IPE_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "IPN") (KTB_InsDynBlock "IPN_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "UPE") (KTB_InsDynBlock "UPE_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "UPN") (KTB_InsDynBlock "UPN_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "SHS") (KTB_InsDynBlock "SHS_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "RHS") (KTB_InsDynBlock "RHS_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "CHS") (KTB_InsDynBlock "CHS_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" washer)) prestring ddiag))
;		((= boltsize "L GZ") (KTB_InsDynBlock "LGZ_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 1 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring ddiag))
;		((= boltsize "L OZ") (KTB_InsDynBlock "LOZ_FRONT" ipt ang (list (cons "Linear" dist) (cons "Lookup" (strcat "L " (rtos(nth 1 props)2 0)))(cons "Lookup1" (strcat "t " (rtos(nth 3 props)2 0)))) prestring ddiag))
;		(nil ())
;		)
(princ ipt)
	(KTB_InsDynBlock "BOLT" ipt ang (list (cons "Size" boltsize) (cons "Visibility" washer)) prestring ddiag)	
		
	)	  ;end cond
	)
	(exit)
	
	(princ)
	)				;end run 1

(defun KTB_InsDynBlock (bName position rotation params prestring ddiag / Laylist LayNewCo LayNewHi LayExCo LayExHi ColNewCo ColNewHi ColExCo ColExHi LtNewCo LtNewHi 
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
	(princ bNameNew)
		(if (tblsearch "block" bNameNew)
			(command "_.INSERT" bNameNew position "1" "1" rotation) ;Start Insert command
			(command "_.INSERT" (strcat bNameNew "=" bName) position "1" "1" rotation);Start Insert command
			)
			(princ "2ollllllaallal")
		
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
(princ "ollllllaallal")
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
	)
