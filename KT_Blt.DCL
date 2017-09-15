KT_Blt : dialog {
 
	key = ver_kts;
	spacer;
	
	  spacer;
    : row {
      : column {
         label = "Your logo here?                                 ";
         alignment = centered;
         : image_button { 
		 key = "image2"; 
     	 color = 0;
          height = 5;
		 fixed_height = true;
         alignment = centered;
	 }
 	 }}
 
    spacer;
        : row {
         : text {
           label = "Select shape:";
         }
          }
        : row {
        : column {
         width = 24;
     
        : popup_list {
		
          key = "list_1";//Value1$ from lsp file (Boltsize)
          alignment = left;
          }
          }
        : column {  
	 alignment = left;
        : popup_list {
		  width = 20;
          key = "list_2";//Value2$ from lsp file (Washertype)
          alignment = left;
         }}}
         
   spacer;
    : row {
      : boxed_column {
         label = "Shape Data";
         width = 24;
 
         : text {
            label = "";
            key = shp_a;
            height = 1.0;
         }
         : text {
            label = "";
            key = shp_b;
            height = 1.0;
         }
         : text {
            label = "";
            key = shp_c;
            height = 1.0;
         }
         : text {
            label = "";
            key = shp_d;
            height = 1.0;
         }
 
         : text {
            label = "";
            key = shp_e;
            height = 1.0;
         }
         : text {
            label = "";
            key = shp_f;
            height = 1.0;
         }
         : text {
            label = "";
            key = shp_g;
            height = 1.0;
         }
                  : text {
            label = "";
            key = shp_h;
            height = 1.0;
         }
         : text {
            label = "";
            key = shp_i;
            height = 1.0;
         }}
        
      : boxed_column {
         label = "Preview";
         alignment = centered;
		 : row {
		 width = 20;
		 alignment = centered;
		 fixed_width = true;
         : image { 
  	 key = "image"; 
     	 color = 0;
         width = 20;
         height = 9;
         alignment = centered;
	 }}
//      spacer;
//      : text {
//      label = "Rotate:";		//Text2$ from lsp file
//      key = "Rot";		//Value2$ from lsp file
//      }
//	  : popup_list {
//          key = "list_3";
//         }
//	  spacer;
//      : toggle {
//      fixed_width = true;
//      label = "Flip";		//Text2$ from lsp file
//      key = "Flip";		//Value2$ from lsp file
//      }
    

	 }}
   : row {
      : boxed_radio_row {
         label = "View Mode";
         key   = "Radio1";
         alignment = centered;
         : radio_button {
            label = "Front";
            key   = "V_Front";
         }
//         : radio_button {
//            label = "Back";
//            key   = "V_Back";
//         }
         : radio_button {
            label = "Top";
            key   = "V_Top";
         }
		 : radio_button {
            label = "Bottom";
            key   = "V_Bottom";
         }
//         : radio_button {
//            label = "Section";
//            key   = "V_Section";
//         }
      }}
//      : row {
//      : boxed_radio_row {
//         label = "Draw Mode";
//         key   = "Radio2";
//         alignment = centered;
//         : radio_button {
//            label = "T.O.S. ";
//            key   = "Draw_a";
//         }
//         : radio_button {
//            label = "Center ";
//            key   = "Draw_b";
//         }
//         : radio_button {
//            label = "B.O.S. ";
//            key   = "Draw_c";
//       }}}
  spacer;        
   
 : row {
    fixed_width = true;
    alignment = centered;
    : button {
      width = 13;
	  key = "Draw_N";
      label = "Draw New";
      fixed_width = true;
    }
	: button {
      width = 13;
	  key = "Draw_E";
      label = "Draw Exist";
      fixed_width = true;
    }
    : cancel_button {
      width = 10;
      fixed_width = true;
    }
    : button {
      width = 10;
      key = "Settings";
      label = "Settings";
      fixed_width = true;
    }

  }
  
 
}
