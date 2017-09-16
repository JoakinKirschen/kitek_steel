(prompt "\nType \"KTSSetup\" to run......")
;support funkties FSO file scripting objects 
(defun stu:DeleteFolder (path / fso)
  (if (and (setq fso (vlax-create-object "Scripting.FilesystemObject"))
           (= -1 (vlax-invoke fso 'folderexists path)))
    (progn
      (vlax-invoke (vlax-invoke fso 'getfolder path) 'delete)
      (vlax-release-object fso)
	)
   )
  (princ)
)

(defun stu:CopyFolder (source target / fso)
  (setq fso (vlax-create-object "Scripting.FilesystemObject"))
  (if (= -1 (vlax-invoke fso 'folderexists source))
    (vlax-invoke fso 'copyfolder source target)
  )
  (vlax-release-object fso)
)

(defun stu:CreateFolder (path / fso)
 (setq fso (vlax-create-object "Scripting.FilesystemObject"))
 (if (not (= -1 (vlax-invoke fso 'folderexists path)))
 (vlax-invoke-method fso 'CreateFolder path))
 (vlax-release-object fso)
 (princ)
)

(defun stu:CopyFile (source target / fso)
(setq fso (vlax-create-object "Scripting.FilesystemObject"))
(vlax-invoke-method fso 'CopyFile source target :vlax-true)
(vlax-release-object fso)
)

(defun KTS_GetLastFolder ( path / i j )
(if (eq "" path) path
(progn
(while
(and
(< 0 (setq i (strlen path)))
(member (ascii (substr path i)) '(47 92))
)
(setq path (substr path 1 (1- i)))
)
(while (and (null j) (< 1 i))
(if (member (ascii (substr path (setq i (1- i)))) '(47 92))
(setq j i)
)
)
(if j (substr path (1+ j)) path)
)
)
)

(defun setup_wait (seconds / stop)
(setq stop (+ (getvar "DATE") (/ seconds 86400.0)))
(while (> stop (getvar "DATE")))
)

;main function
(defun c:KTSSETUP ( / temp usname defpath vrs CD YR acadprofiles actprofile targ source targ1 targ2 targ3 targ4 targ5 source2 source3 source4 npname maincui #Files #Layout mcui)
(vl-load-com)
(setvar "impliedface" 0)
(setvar "cmdecho" 0)

(setq CD (rtos (getvar "CDATE") 2 4))
(setq YR (strcat (substr CD 7 2)"-" (substr CD 5 2) "-" (substr CD 1 4)))

(setq vrs (KTS_GetLastFolder(vl-filename-directory (findfile (strcat (getvar "PROGRAM") ".exe")))))

(setq targ1 (strcat (getenv "Appdata") "\\" vrs ))  
(setq targ2 (strcat targ1 "\\KiTek_Steel" ))   


(princ "\nDownloading Files")
(setq KTSPathSource (strcat (getenv "Temp") "\\KiTek_Steel"))
  (if (vl-file-directory-p KTSPathSource)
	(stu:DeleteFolder KTSPathSource)
  )
  
(vl-mkdir KTSPathSource)

(KTS_GetFileFromURL "http://www.kitek.be/data/kitek_steel.exe" (strcat (getenv "Temp") "\\"))
  (setq count 0)
  (while (and 
			(<= count 15)
			(not
				(findfile (strcat (getenv "Temp") "\\kitek_steel.exe"))
		))
  (command "._'delay" 1500)
  (princ "/")
  (setq count (+ count 1))
  )
  
  (princ "\nExtracting the file archive\n")
  (startapp (strcat (getenv "Temp") "\\kitek_steel.exe"))
  (setq count 0)
  (while (and (<= count 15)
		(not (and 
		(vl-file-directory-p (strcat KTSPathSource "\\Blocks"))
		(vl-file-directory-p (strcat KTSPathSource "\\Slides"))
		)))
  (command "._'delay" 1500)
  (princ "/")
  (setq count (+ count 1))
  )
  (command "._'delay" 3000)
  (if (>= count 15)(progn (princ "File extraction failed")(exit)))
  (vl-file-delete  (strcat (getenv "Temp") "\\kitek_steel.exe"))

(princ "Copying files... This can take a while please be patient!")

(if (not(vl-file-directory-p targ1))
(stu:CreateFolder targ1)
)

(if (vl-file-directory-p targ2)
(stu:DeleteFolder targ2)
)

(stu:CreateFolder targ2)
(stu:CopyFolder KTSPathSource targ2)

(setq acadprofiles (vla-get-profiles (vla-get-preferences (vlax-get-Acad-Object))))

;get the active profile
(setq actprofile (vla-get-ActiveProfile acadprofiles))

;(setq newProfile (vlax-invoke-method acadprofiles 'ImportProfile "LAB2012" (strcat source2 "\\LAB2012.arg") :vlax-true))
;if it's not, copy the existing profile, renaming it "AfraLisp".
;(vlax-invoke-method acadProfiles 'CopyProfile actProfile (strcat "L12_" YR))
;reset the active profile
;(vlax-invoke-method acadProfiles 'ResetProfile (strcat "L12_" YR))
;then make it the active profile
;(vla-put-ActiveProfile acadProfiles "LAB2012")


;(setq list2 (vl-directory-files targ2 nil -1))    Te testen op netwerk locaties
;(setq list3 (vl-directory-files targ3 nil -1))    Te testen op netwerk locaties

;store the default paths
(setq defpath (getenv "ACAD"))

;set up the support paths
(setenv "ACAD" (strcat 
defpath ";"
targ2 ";"
targ2 "\\" "Blocks ;"
))
(setq winmain (substr (getvar 'LOCALROOTPREFIX) 1 3))
;funktie nog aan te passen aan versiecheck
;(progn
;(setq maincui "0")
;(while (and (/= maincui nil)(/= (vl-filename-base maincui) "LAB2012"))
;(setq maincui (getfiled "Search acad.cui*" "acad.cui*" "cui" 0))
;)
;(stu:CopyFile maincui (setq mcui(strcat targ4 "\\acadcust_" YR ".cuix")))
;)


(prompt "Setting profile")
  
(stu:menuload "KT_Stl.cui")

;(setvar "WSCURRENT" "Lab2012")
(alert
      (strcat
        "KiTek_Steel  has been successfully installed.\n\n"
        "      Please restart AutoCAD."
      ) ;_ strcat
) ;_ alert
)


;-------------------------------------------------------
(defun stu:printers ( LabPathSource / PlotPath PMPPath PlotStyles DirNew DirLengthNew FILE)
    (setq PlotPath (strcat(getenv "PrinterConfigDir")"\\"))
    (setq PMPPath (strcat(getenv "PrinterDescDir")"\\"))
    (setq PlotStyles (strcat(getenv "PrinterStyleSheetDir")"\\"))
	(setq DirNew  (vl-directory-files  (strcat LabPathSource "\\Files\\Plotters") "*.*" 0))
    (setq DirLengthNew (vl-list-length  DirNew))
    (while (> DirLengthNew 0)
      (progn
        (setq DirLengthNew (- DirLengthNew 1))
        (vl-file-delete  (strcat PlotPath (nth DirLengthNew DirNew)))
        (vl-file-copy (strcat LabPathSource "\\Files\\Plotters\\" (nth DirLengthNew DirNew))
                      (strcat PlotPath (nth DirLengthNew DirNew))
        )
      )
    )

    (setq DirNew  (vl-directory-files  (strcat LabPathSource "\\Files\\PMP Files") "*.*" 0))
    (setq DirLengthNew (vl-list-length  DirNew))
    (while (> DirLengthNew 0)
      (progn
        (setq DirLengthNew (- DirLengthNew 1))
        (vl-file-delete  (strcat PMPPath (nth DirLengthNew DirNew)))
        (vl-file-copy (strcat LabPathSource "\\Files\\PMP Files\\" (nth DirLengthNew DirNew))
                      (strcat PMPPath (nth DirLengthNew DirNew))
        )
      )
    )

    (setq DirNew  (vl-directory-files  (strcat LabPathSource "\\Files\\Plot Styles") "*.*" 0))
    (setq DirLengthNew (vl-list-length  DirNew))
    (while (> DirLengthNew 0)
      (progn
        (setq DirLengthNew (- DirLengthNew 1))
        (vl-file-delete  (strcat PlotStyles (nth DirLengthNew DirNew)))
        (vl-file-copy   (strcat LabPathSource "\\Files\\Plot Styles\\" (nth DirLengthNew DirNew))
                        (strcat PlotStyles (nth DirLengthNew DirNew))
        )
      )
    )
    (princ "\nPlotters Updated")
)


(defun stu:menuload (CUIFILE / FILE)
(if (= (menugroup CUIFILE) nil)
(progn
(if (setq FILE (findfile CUIFILE))
(progn (SETVAR "FILEDIA" 0)
(command "menuload" CUIFILE)
(SETVAR "FILEDIA" 1)
))
)
)
)
;(ppn_menuload_tb) 
;; Voorbeeldfuncties

(defun RGB->Bits(RGB_List)
  (if(vl-every
       '(lambda(c)(and(< -1 c)(> 256 c)))RGB_List)
     (apply '+(mapcar '* RGB_List '(65536 256 1)))
    ); end if
  ); end of RGB->Bits


(defun Bits->RGB(Bits / r g)
  (if(and(< -1 Bits)(> 16777216 Bits))
  (list(setq r(/ Bits 65536))
       (setq g(/(- Bits(* r 65536))256))
       (- Bits(+(* r 65536)(* g 256)))
       ); end list
    ); end if
  ); end Bits->RGB

 (defun KTS_GetFileFromURL  (url path / utilObj tempPath newPath voidPath)
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
;  call example   
;  (RGB->Bits '(255 0 255))
;  (Bits->RGB 16711935)


;;;
;;;    Copyright (C) 2002 by Autodesk, Inc.
;;;
;;;    Permission to use, copy, modify, and distribute this software
;;;    for any purpose and without fee is hereby granted, provided
;;;    that the above copyright notice appears in all copies and
;;;    that both that copyright notice and the limited warranty and
;;;    restricted rights notice below appear in all supporting
;;;    documentation.
;;;
;;;    AUTODESK PROVIDES THIS PROGRAM "AS IS" AND WITH ALL FAULTS.
;;;    AUTODESK SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTY OF
;;;    MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.  AUTODESK, INC.
;;;    DOES NOT WARRANT THAT THE OPERATION OF THE PROGRAM WILL BE
;;;    UNINTERRUPTED OR ERROR FREE.
;;;
;;;    Use, duplication, or disclosure by the U.S. Government is subject to
;;;    restrictions set forth in FAR 52.227-19 (Commercial Computer
;;;    Software - Restricted Rights) and DFAR 252.227-7013(c)(1)(ii) 
;;;    (Rights in Technical Data and Computer Software), as applicable.
;;;
;;;
;;; DESCRIPTION: 
;;;  Sample profile manipulation utilities. All functions return T on success and nil 
;;  on failure. See comments above each function for additional details.
;;;
;;; EXAMPLES:
;;;   
;;; - Set active profile: 
;;;     (L12-profile-set-active "MyProfile")
;;;
;;; - Import a profile:
;;;     (L12-profile-import "c:\\myExportedProfile.arg" "MyFavoriteProfile" T)
;;;
;;; - Delete a profile:
;;;     (L12-profile-delete "unwanted")
;;;
;;;
;;; - Import a profile, even if it already exists, and set it active.
;;;
;;;    (L12-profile-import "c:\\CompanyProfile.arg" "MyProfile" T)
;;;    (L12-profile-set-active "MyProfile")
;;;
;;;
;;; - Import a profile, if not already present, and set it active
;;;
;;;    (if (not (L12-profile-exists "myProfile"))
;;;        (progn
;;;         (L12-profile-import "c:\\CompanyProfile.arg" "MyProfile" T)
;;;         (L12-profile-set-active "MyProfile")
;;;        )
;;;    )
;;;
;;;
;;; - Import a profile and set it active when AutoCAD is first started.
;;;  Place the following code in acaddoc.lsp with the desired ".arg" filename 
;;;  and profile name...
;;;
;;;    (defun s::startup ()
;;;      (if (not (vl-bb-ref ':L12-imported-profile)) ;; have we imported the profile yet?
;;;          (progn
;;;  
;;;            ;; Set a variable on the bulletin-board to indicate that we've been here before.
;;;            (vl-bb-set ':L12-imported-profile T) 
;;;          
;;;            ;; Import the profile and set it active
;;;            (L12-profile-import "c:\\CompanyProfile.arg" "MyProfile" T)
;;;            (L12-profile-set-active "MyProfile")
;;;   
;;;          );progn then
;;;      );if
;;;    );defun s::startup
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This helper function gets the profiles object.
;;
(defun L12-get-profiles-object ( / app pref profs )
 (vl-load-com)
 (and
  (setq   app (vlax-get-acad-object))
  (setq  pref (vla-get-preferences app))
  (setq profs (vla-get-profiles pref))
 )
 profs
);defun L12-get-profiles-object

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Determine if a profile exists. Returns T if the specified profile name exists, and nil if not.
;;
(defun L12-profile-exists ( name / profs )
 (and name
      (setq names (L12-profile-names))
      (member (strcase name) (mapcar 'strcase names))
 )
);defun L12-profile-exists

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set the active profile. 
;; NOTES: 
;;  - If the specified profile name is already active then the function returns T and makes no additional 
;;    changes.
;;
;;  - The specified profile must exist. (You can import a profile using the  'L12-profile-import' 
;;    function.) If the specified profile does not exist, the function returns nil.
;;
(defun L12-profile-set-Active ( name / profs )
 (and
  name
  (setq profs (L12-get-profiles-object))
  (or (equal (strcase name) (strcase (getvar "cprofile")))
      (not (vl-catch-all-error-p (vl-catch-all-apply 'vla-put-activeProfile (list profs name))))
  )
 );and
);defun L12-profile-set-Active

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Delete the specified profile. Fails if the specified profile is current.
;; 
(defun L12-profile-delete ( name / profs )
 (and
  name
  (setq profs (L12-get-profiles-object))
  (not (vl-catch-all-error-p (vl-catch-all-apply 'vla-deleteprofile (list profs name))))
 )
);defun L12-profile-delete
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copy profile.
;;
(defun acad-pref-profile-copy ( source target / profs )
 (and
  source
  target
  (setq profs (L12-get-profiles-object))
  (not (vl-catch-all-error-p (vl-catch-all-apply 'vla-CopyProfile (list profs source target))))
 )
);defun L12-profile-copy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get a list of profile names
;;
(defun L12-profile-names ( / profs result )
 (and
  (setq profs (L12-get-profiles-object))
  (not (vl-catch-all-error-p (vl-catch-all-apply 'vla-GetAllProfileNames (list profs 'result))))
  result
  (setq result (vlax-safearray->list result))
 )
 result
);defun L12-profile-names

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rename
;;
(defun L12-profile-rename ( oldName newName / profs )
 (and
  oldName
  newName
  (setq profs (L12-get-profiles-object))
  (not (vl-catch-all-error-p (vl-catch-all-apply 'vla-RenameProfile (list profs oldName newName))))
 )
);defun L12-profile-rename

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get a unique profile name. This function returns a unique profile name that is guaranteed 
;; to not be present in the current list of profiles.
;;
(defun L12-get-unique-profile-name (sendid / names n name )
 (setq names (L12-profile-names)
       names (mapcar 'strcase names)
        name sendid
           n 1
 )
 (while (member (strcase (setq name (strcat name (itoa n)))) names)
  (setq n (+ n 1))
 )
 name
);defun L12-get-unique-profile-name

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Import
;; This function imports the specified .arg file and creates a new profile with the provided profile name.
;; If the specified profile already exists, it will be overwritten.
;; If the 'bUsePathInfo' parameter is non-nil then path information will be imported from the specified 
;; file. Otherwise, path information will be ignored.
;;
;; NOTES: 
;;  This function does not set the active profile. If you import a new profile 
;;  it will not become active unless it matches the name of the existing active profile. 
;;
;;  You can set the active profile by calling: 
;;    (L12-profile-set-active "ProfileName")
;;
(defun l12-profile-import ( filename profileName bUsePathInfo / L12-oldError profs isCProfile tempProfile result )

 ;; Set up an error handler so, if something goes wrong, we can put things back the way we found them
 (setq L12-oldError *error*)
 (defun *error* ( msg / )
  (if (and profileName
           tempProfile
           (equal tempProfile (getvar "cprofile"))
      )
      (progn
       ;; Something went wrong so put things back the way they were.
       (L12-profile-rename tempProfile profileName)
       (L12-profile-set-active profileName)
       (L12-profile-delete tempProfile)
      );progn then
  );if
  (setq *error* L12-oldError)
  (if msg
      (*error* msg)
      (princ)
  )
 );defun *error*

 (if (and bUsePathInfo
          (not (equal :vlax-false bUsePathInfo))
     )
     (setq bUsePathInfo :vlax-true)
     (setq bUsePathInfo :vlax-false)
 )
 (if (and filename
          (setq filename (findfile filename))
          profileName
          (setq profs (L12-get-profiles-object))
     );and
     (progn
      ;; We can't import directly to the current profile, so if the provided profile name matches 
      ;; the current profile, we'll need to:
      ;;  - rename the current profile to a unique name
      ;;  - import
      ;;  - set the new one current
      ;;  - delete the old one with the temp name
      (setq isCProfile (equal (strcase (getvar "cprofile")) (strcase profileName)))
      (if isCProfile
          (progn
           (setq tempProfile (L12-get-unique-profile-name))
           (L12-profile-rename (getvar "cprofile") tempProfile)
          );progn then
      );if

      ;; Import          
      (setq result (not (vl-catch-all-error-p (vl-catch-all-apply 'vla-ImportProfile (list profs profileName filename bUsePathInfo)))))

      (if isCProfile
          (progn
           ;;  Handle current profile case...
           ;;  If the import was successful, then set the new profile active and delete the original
           ;;  else if something went wrong, then put the old profile back
           (if (and result
                    (setq result (L12-profile-set-Active profileName)) ;; set the newly imported profile active
               );and
               (L12-profile-delete tempProfile)            ;; then delete the old profile
               (L12-profile-rename tempProfile profileName);; else rename the original profile back to its old name
           );if
          );progn then
      );if
     );progn then
 );if

 (*error* nil) ;; quietly restore the original error handler
 result
);defun L12-profile-import

(princ)

(princ)

;CODING ENDS HERE