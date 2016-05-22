KTSLicence : dialog {
    label = "Licence";
	
 spacer;

: row {
 : text {
            label = "Please enter your licence key below"; 
       }
}
 spacer;

: row {
        : edit_box {
          key = "1four";
          width = 5;
          fixed_width = true;
          alignment = left;
		  label = "";}
       : edit_box {
          key = "2four";
          width = 5;
          fixed_width = true;
          alignment = left;
		  label = "";}
       : edit_box {
          key = "3four";
          width = 5;
          fixed_width = true;
          alignment = left;
		  label = "";}
       : edit_box {
          key = "4four";
          width = 5;
          fixed_width = true;
          alignment = left;
		  label = "";}
}

 
spacer;      
  spacer;
: row {
    fixed_width = true;
    alignment = centered;
    : ok_button {
      width = 10;
      key = "verify";
      label = "Verify";
      fixed_width = true;
    }
	: cancel_button {
	  key = "next";
	  label = "Cancel";
      width = 10;
      fixed_width = true;
    }
  }
spacer; 

}


KTSUpdate1 : dialog {
    label = "AutoUpdate";
	
 spacer;

: row {
 : text {
            label = "There is a new version of KiTek Steel available."; 
       }
}
 spacer;
: row {
 : text {
            label = "Do u wish to update now?"; 
       }
}

 
spacer;      
  spacer;
: row {
    fixed_width = true;
    alignment = centered;
    : cancel_button {
      width = 10;
      key = "delay";
      label = "Cancel";
      fixed_width = true;
    }
	: ok_button {
	  key = "next";
	  label = "Yes";
      width = 10;
      fixed_width = true;
    }
  }
spacer; 

}

KTSYesNo : dialog {
    key = title;
	spacer;
	
 spacer;

: row {
 : text {
  fixed_width = true;
            key = line1; 
			width = 50;
       }
}
 spacer;
: row {
 : text {
  fixed_width = true;
            key = line2; 
			width = 50;
       }
}

 
spacer;      
  spacer;
: row {
    fixed_width = true;
    alignment = centered;
    : cancel_button {
      width = 10;
      key = "no";
      label = "No";
      fixed_width = true;
    }
	: ok_button {
	  key = "yes";
	  label = "Yes";
      width = 10;
      fixed_width = true;
    }
  }
spacer; 

}

KTSSettings1 : dialog {
    label = "KiTek Steel Settings";
 
   spacer;
		  : column {
		  alignment = centered;
		  : boxed_row {
		  label = "Current slot:";
		  alignment = centered;
		  : popup_list {
		  fixed_width = true;
          key = "Slots";
          width = 25;
          }
		  }
		  spacer;
		  : boxed_row {
		  label = "Presets:";
		  alignment = centered;
		  : edit_box {
		  label = "Slot name:";
          key = "Slotname";
          width = 30;
          fixed_width = true;
          alignment = left; 
		 }
		  spacer;

	      : button {
          width = 18;
          key = "export";
          label = "Export current slot";
          fixed_width = true;
          }
		  
		  : button {
          width = 18;
          key = "import";
          label = "Import current slot";
          fixed_width = true;
          }
		  
		  : text {
           label = "                                 ";
         }
		  }
		  }
	     : boxed_row {
		  label = "Layer Settings:";
		 : column {
		 : row {
         : text {
           label = "";
         }
         }
        : row {
         width = 2;
         fixed_width = true;    
        : text {
           label = "New Vis:";
         }
          }
		: row {
         width = 2;
         fixed_width = true;    
        : text {
           label = "New Hid:";
         }
          }
        : row {
          width = 2;
          fixed_width = true;    
	      alignment = left;
        : text {
           label = "Ex Vis:";
         }
		 }
		: row {
          width = 2;
          fixed_width = true;    
	      alignment = left;
        : text {
           label = "Ex Hid:";
         }
		 }}

		 : column {
         : text {
           label = "Layer Name:";
         }
        : row {
         width = 25;
         fixed_width = true;    
        : edit_box {
          key = "TxtNewCo";
          width = 25;
          fixed_width = true;
          alignment = left;
		  label = "";
          }
          }
		: row {
         width = 25;
         fixed_width = true;    
        : edit_box {
          key = "TxtNewHi";
          width = 25;
          fixed_width = true;
          alignment = left;
		  label = "";
          }
          }
        : row {
          width = 25;
          fixed_width = true;    
	      alignment = left;
        : edit_box {
          key = "TxtExCo";
          width = 25;
          fixed_width = true;
          alignment = left;
		  label = "";
         }}
		: row {
          width = 25;
          fixed_width = true;    
	      alignment = left;
        : edit_box {
          key = "TxtExHi";
          width = 25;
          fixed_width = true;
          alignment = left;
		  label = "";
         }}}		 
		  
        : column {
		 : row {
         : text {
           label = "Color:";
         }
         }
        : row {
         width = 12;
         fixed_width = true;    
        : popup_list {
          key = "ColNewCo";
          width = 12;
          fixed_width = true;
          alignment = left;
          }
          }
		: row {
         width = 12;
         fixed_width = true;    
        : popup_list {
          key = "ColNewHi";
          width = 12;
          fixed_width = true;
          alignment = left;
          }
          }
        : row {
          width = 12;
          fixed_width = true;    
	      alignment = left;
        : popup_list {
          key = "ColExCo";
          width = 12;
          fixed_width = true;
          alignment = left;
         }}
		: row {
          width = 12;
          fixed_width = true;    
	      alignment = left;
        : popup_list {
          key = "ColExHi";
          width = 12;
          fixed_width = true;
          alignment = left;
         }}
		 }
		         : column {
		 : row {
         : text {
           label = "";
         }
         }
        : row {
         width = 5;
         fixed_width = true;    
        : edit_box {
          key = "ColNewCoCust";
          width = 5;
          fixed_width = true;
          alignment = left;
          }
          }
		: row {
         width = 5;
         fixed_width = true;    
        : edit_box {
          key = "ColNewHiCust";
          width = 5;
          fixed_width = true;
          alignment = left;
          }
          }
        : row {
          width = 5;
          fixed_width = true;    
	      alignment = left;
        : edit_box {
          key = "ColExCoCust";
          width = 5;
          fixed_width = true;
          alignment = left;
         }}
		: row {
          width = 5;
          fixed_width = true;    
	      alignment = left;
        : edit_box {
          key = "ColExHiCust";
          width = 5;
          fixed_width = true;
          alignment = left;
         }}
		 }
       : column {
		 : row {
         : text {
           label = "LineType:";
         }
         }
        : row {
         width = 16;
         fixed_width = true;    
        : popup_list {
          key = "LtNewCo";
          width = 16;
          fixed_width = true;
          alignment = left;
          }
          }
		: row {
         width = 16;
         fixed_width = true;    
        : popup_list {
          key = "LtNewHi";
          width = 16;
          fixed_width = true;
          alignment = left;
          }
          }
        : row {
          width = 16;
          fixed_width = true;    
	      alignment = left;
        : popup_list {
          key = "LtExCo";
          width = 16;
          fixed_width = true;
          alignment = left;
         }}
		: row {
          width = 16;
          fixed_width = true;    
	      alignment = left;
        : popup_list {
          key = "LtExHi";
          width = 16;
          fixed_width = true;
          alignment = left;
         }}
		 }
      : column {
		 : row {
         : text {
           label = "LineWeight:";
         }
         }
        : row {
         width = 12;
         fixed_width = true;    
        : popup_list {
          key = "LwNewCo";
          width = 12;
          fixed_width = true;
          alignment = left;
          }
          }
		: row {
         width = 12;
         fixed_width = true;    
        : popup_list {
          key = "LwNewHi";
          width = 12;
          fixed_width = true;
          alignment = left;
          }
          }
        : row {
          width = 12;
          fixed_width = true;    
	      alignment = left;
        : popup_list {
          key = "LwExCo";
          width = 12;
          fixed_width = true;
          alignment = left;
         }}
		: row {
          width = 12;
          fixed_width = true;    
	      alignment = left;
        : popup_list {
          key = "LwExHi";
          width = 12;
          fixed_width = true;
          alignment = left;
         }}
		 }		 
		 
		 }
 
 spacer;
   : boxed_row {
         label = "Text Settings:";
         alignment = left;
		 : column {
		 : row {
         : text {
           label = "Scale:";
         }
         }
		 : row {
		 : toggle {
		 fixed_width = true;
		 label = "Annoscale";
		 key = "Textanno";
		 alignment = left; 
		 }
		 : toggle {
		 fixed_width = true;
		 label = "Labscale";
		 key = "LabScale";
		 alignment = left; 
		 }
		 : edit_box {
          key = "ExAdd";
          width = 8;
          fixed_width = true;
          alignment = left; 
		 }
		 }
		 }
		 : column {
		 : row {
         : text {
           label = "Height:";
         }
         }
		 : row {		 
		 : edit_box {
          key = "Textheight";
          width = 8;
          fixed_width = true;
          alignment = left; 
		 }
		 }
		 }
		 : column {
		 : row {
         : text {
           label = "Layer Name:";
         }
         }
		 : row {
		 : edit_box {
          key = "Textlayer";
          width = 18;
          fixed_width = true;
          alignment = left; 
		 }
		 }
		 }
		 : column {
		 : row {
         : text {
           label = "Font:";
         }
         }
		 : row {
		 : edit_box {
          key = "Textfont";
          width = 18;
          fixed_width = true;
          alignment = left; 
		 }
		 }
		 }
		 : column {
		 : row {
         : text {
           label = "Color:";
         }
         }
		 : row {
         : popup_list {
          key = "Textcolor";
          width = 14;
          fixed_width = true;
          alignment = left;
 		 }
		 }
		 }
		 : column {
		 : row {
         : text {
           label = "";
         }
         }
		 : row {
         : edit_box {
          key = "TextcolorCust";
          width = 5;
          fixed_width = true;
          alignment = left;
 		 }
		 }
		 }
      }
 
 spacer;
   : row {
      : boxed_radio_row {
         label = "When to check for updates?";
         key   = "Radio1";
         alignment = centered;
         : radio_button {
            label = "Every day";
            key   = "1";
         }
		 : radio_button {
            label = "Every 10 days";
            key   = "2";
         }
         : radio_button {
            label = "Every month";
            key   = "3";
         }
         : radio_button {
            label = "Never Check";
            key   = "9";
         }
      }}

: row {
    fixed_width = true;
    alignment = centered;
    : button {
	  width = 18;
	  key = "savetoslot";
      label = "Save settings to current slot";
      fixed_width = true;
    }
    : cancel_button {
      width = 12;
      key = "ok";
      label = "Exit";
      fixed_width = true;
    }
		: button {
      key = "check";
	  label = "Update Now";
	  width = 12;
      fixed_width = true;
    }
	: button {
      key = "info";
	  label = "About KiTek";
	  width = 12;
      fixed_width = true;
    }
  }
spacer; 

}