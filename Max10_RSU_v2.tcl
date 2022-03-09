namespace eval boardInit {

    set ::boardInit::masterPath	[ lindex [ get_service_paths master ] 0 ]

}

namespace eval AVMM_PR_dashboard {

proc start_image1_programming {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	variable filename [dashboard_get_property ${::AVMM_PR_dashboard::dash} mytext text]
	set file [open $filename r]
	fconfigure $file -translation binary
	set bindata [read $file]
	close $file
	variable hex
	binary scan $bindata c* signedchars
	set length [llength $signedchars]
	
	master_write_32 ${::boardInit::masterPath} 0x200004 0xf7ffffff
	master_write_32 ${::boardInit::masterPath} 0x200004 0xf7dfffff
	
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	while { [ expr $STATUSID & 0x3 ] > 0 } {
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	}
			
	while { [ expr $STATUSID & 0x10 ] < 1 } {
		puts "Erased Failed"
		master_write_32 ${::boardInit::masterPath} 0x200004 0xf7dfffff
		puts "Erase Again"
		after 100
		while { [ expr $STATUSID & 0x3 ] > 0 } {
			set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
		}
	}
	
	set count 0
	set bytes 0
	set data ""
	variable address 0x2b000
	
	foreach byte $signedchars {
		set temp1 [format 0x%02x [expr {$byte & 0xff}]]
		binary scan [format %c $temp1] b* temp2
		if { $bytes < 3 } {
			set data $data$temp2
			incr bytes
		} else {
			set data $data$temp2
			binary scan [binary format B* $data] H* hex
			master_write_32 ${::boardInit::masterPath} $address 0x$hex			
			set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
			while { [ expr $STATUSID & 0x3 ] > 0 } {
				set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
				puts $address
				puts $STATUSID
			}
			if { [ expr $STATUSID & 0x8 ] < 1 } {
				send_message error Write_Failed
			}
			incr address 0x4
			set data ""
			set bytes 0
		}
		incr count
		set c [expr {$count * 100/$length}]
		dashboard_set_property $dash mylabel2 text $c\%
	}
	if { $bytes > 0 } {
		while { $bytes < 4 } {
			set data "$data11111111"
			incr bytes
		}
		binary scan [binary format B* $data] H* hex
		if { $hex != "ffffffff" } {
			master_write_32 ${::boardInit::masterPath} $address 0x$hex
		}
		
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
		while { [ expr $STATUSID & 0x3 ] > 0 } {
			set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
		}
	}
	
	close_service master ${::boardInit::masterPath}
	
}

proc start_image2_programming {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	variable filename [dashboard_get_property ${::AVMM_PR_dashboard::dash} mytext text]
	set file [open $filename r]
	fconfigure $file -translation binary
	set bindata [read $file]
	close $file
	variable hex
	binary scan $bindata c* signedchars
	set length [llength $signedchars]
	
	master_write_32 ${::boardInit::masterPath} 0x200004 0xf9ffffff
	master_write_32 ${::boardInit::masterPath} 0x200004 0xf9bfffff
	
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	while { [ expr $STATUSID & 0x3 ] > 0 } {
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	}
			
	while { [ expr $STATUSID & 0x10 ] < 1 } {
		puts "Erased Failed"
		master_write_32 ${::boardInit::masterPath} 0x200004 0xf9bfffff
		puts "Erase Again"
		after 100
		while { [ expr $STATUSID & 0x3 ] > 0 } {
			set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
		}
	}
	
	master_write_32 ${::boardInit::masterPath} 0x200004 0xf9cfffff
	
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	while { [ expr $STATUSID & 0x3 ] > 0 } {
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	}
			
	while { [ expr $STATUSID & 0x10 ] < 1 } {
		puts "Erased Failed"
		master_write_32 ${::boardInit::masterPath} 0x200004 0xf9cfffff
		puts "Erase Again"
		after 100
		while { [ expr $STATUSID & 0x3 ] > 0 } {
			set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
		}
	}
	
	set count 0
	set bytes 0
	set data ""
	variable address 0x8000
	
	foreach byte $signedchars {
		set temp1 [format 0x%02x [expr {$byte & 0xff}]]
		binary scan [format %c $temp1] b* temp2
		if { $bytes < 3 } {
			set data $data$temp2
			incr bytes
		} else {
			set data $data$temp2
			binary scan [binary format B* $data] H* hex
			master_write_32 ${::boardInit::masterPath} $address 0x$hex			
			set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
			while { [ expr $STATUSID & 0x3 ] > 0 } {
				set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
				puts $address
				puts $STATUSID
			}
			if { [ expr $STATUSID & 0x8 ] < 1 } {
				send_message error Write_Failed
			}
			incr address 0x4
			set data ""
			set bytes 0
		}
		incr count
		set c [expr {$count * 100/$length}]
		dashboard_set_property $dash mylabel2 text $c\%
	}
	if { $bytes > 0 } {
		while { $bytes < 4 } {
			set data "$data11111111"
			incr bytes
		}
		binary scan [binary format B* $data] H* hex
		if { $hex != "ffffffff" } {
			master_write_32 ${::boardInit::masterPath} $address 0x$hex
		}
		
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
		while { [ expr $STATUSID & 0x3 ] > 0 } {
			set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
		}
	}
	
	close_service master ${::boardInit::masterPath}
	
}

proc update_file {} {
	variable dash
	variable filename [string trim [dashboard_get_property ${::AVMM_PR_dashboard::dash} myfile1 paths] \{\}]
	dashboard_set_property $dash mytext text $filename
}

proc read_SYSID {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	set FLASHID [master_read_32 ${::boardInit::masterPath} 0x290000 0x1]
	dashboard_set_property $dash mytext22 text $FLASHID
	close_service master ${::boardInit::masterPath}
}

proc read_STATUSID {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	dashboard_set_property $dash mytext21 text $STATUSID
	close_service master ${::boardInit::masterPath}
}

proc ufm1_erase {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	master_write_32 ${::boardInit::masterPath} 0x200004 0xff7fffff
	master_write_32 ${::boardInit::masterPath} 0x200004 0xff1fffff
	
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	while { [ expr $STATUSID & 0x3 ] > 0 } {
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	}
	if { [ expr $STATUSID & 0x10 ] > 0 } {
	dashboard_set_property $dash EraseSTled color "green"
	} else {
	dashboard_set_property $dash EraseSTled color "red"
	}
	
	close_service master ${::boardInit::masterPath}
}
proc ufm0_erase {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	master_write_32 ${::boardInit::masterPath} 0x200004 0xfeffffff
	master_write_32 ${::boardInit::masterPath} 0x200004 0xfeafffff
	
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	while { [ expr $STATUSID & 0x3 ] > 0 } {
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	}
	if { [ expr $STATUSID & 0x10 ] > 0 } {
	dashboard_set_property $dash EraseSTled color "green"
	} else {
	dashboard_set_property $dash EraseSTled color "red"
	}
	
	close_service master ${::boardInit::masterPath}
}
proc cfm2_erase {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	master_write_32 ${::boardInit::masterPath} 0x200004 0xfdffffff
	master_write_32 ${::boardInit::masterPath} 0x200004 0xfdbfffff
	
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	while { [ expr $STATUSID & 0x3 ] > 0 } {
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	}
	if { [ expr $STATUSID & 0x10 ] > 0 } {
	dashboard_set_property $dash EraseSTled color "green"
	} else {
	dashboard_set_property $dash EraseSTled color "red"
	}
	
	close_service master ${::boardInit::masterPath}
	
	close_service master ${::boardInit::masterPath}
}
proc cfm1_erase {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	master_write_32 ${::boardInit::masterPath} 0x200004 0xfbffffff
	master_write_32 ${::boardInit::masterPath} 0x200004 0xfbcfffff
	
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	while { [ expr $STATUSID & 0x3 ] > 0 } {
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	}
	if { [ expr $STATUSID & 0x10 ] > 0 } {
	dashboard_set_property $dash EraseSTled color "green"
	} else {
	dashboard_set_property $dash EraseSTled color "red"
	}
	
	close_service master ${::boardInit::masterPath}
	close_service master ${::boardInit::masterPath}
}
proc cfm0_erase {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	master_write_32 ${::boardInit::masterPath} 0x200004 0xf7ffffff
	master_write_32 ${::boardInit::masterPath} 0x200004 0xf7dfffff
	
	set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	while { [ expr $STATUSID & 0x3 ] > 0 } {
		set STATUSID [master_read_32 ${::boardInit::masterPath} 0x200000 0x1]
	}
	if { [ expr $STATUSID & 0x10 ] > 0 } {
	dashboard_set_property $dash EraseSTled color "green"
	} else {
	dashboard_set_property $dash EraseSTled color "red"
	}
	
	close_service master ${::boardInit::masterPath}
	close_service master ${::boardInit::masterPath}
}

proc read_data {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	variable address [dashboard_get_property ${::AVMM_PR_dashboard::dash} mytext20 text]
	set data [master_read_32 ${::boardInit::masterPath} $address 0x1]
	dashboard_set_property $dash mytext10 text $data
	close_service master ${::boardInit::masterPath}
}
proc write_data {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	variable address [dashboard_get_property ${::AVMM_PR_dashboard::dash} mytext20 text]
	variable data [dashboard_get_property ${::AVMM_PR_dashboard::dash} mytext10 text]
	master_write_32 ${::boardInit::masterPath} $address $data
	close_service master ${::boardInit::masterPath}
}

proc read_watchdog {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	set timeout [master_read_32 ${::boardInit::masterPath} 0x4000048 0x1]
	dashboard_set_property $dash myRSUtext1 text $timeout
	close_service master ${::boardInit::masterPath}
}
proc write_watchdog {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	variable timeout [dashboard_get_property ${::AVMM_PR_dashboard::dash} myRSUtext1 text]
	master_write_32 ${::boardInit::masterPath} 0x4000048 $timeout
	close_service master ${::boardInit::masterPath}
}

proc Img1config {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	master_write_32 ${::boardInit::masterPath} 0x200104 0x1
	master_write_32 ${::boardInit::masterPath} 0x200108 0x8
	set config [master_read_32 ${::boardInit::masterPath} 0x8011c 0x1]
	dashboard_set_property $dash myRSUtext2 text $config
	close_service master ${::boardInit::masterPath}
}

proc Img2config {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	master_write_32 ${::boardInit::masterPath} 0x200104 0x3
	master_write_32 ${::boardInit::masterPath} 0x200108 0x8
	set config [master_read_32 ${::boardInit::masterPath} 0x8011c 0x1]
	dashboard_set_property $dash myRSUtext2 text $config
	close_service master ${::boardInit::masterPath}
}
proc Triconfig {} {
	open_service master ${::boardInit::masterPath}
	master_write_32 ${::boardInit::masterPath} 0x200100 0x1
	close_service master ${::boardInit::masterPath}
}

proc RSUBusy {} {
	open_service master ${::boardInit::masterPath}
	variable dash
	set status [master_read_32 ${::boardInit::masterPath} 0x20010c 0x1]
	if { [ expr $status & 0x1 ] > 0 } {
	dashboard_set_property $dash Busyled color "red"
	} else {
	dashboard_set_property $dash Busyled color "green"
	}
	close_service master ${::boardInit::masterPath}
}

set dash [add_service dashboard Max10_Dual_Boot_dashboard "Max10 Dual Boot Dashboard " "Tools/Example"]
dashboard_set_property $dash self developmentMode true
dashboard_add $dash RSUGroup group self
dashboard_set_property $dash RSUGroup expandableX false
dashboard_set_property $dash RSUGroup expandableY false
dashboard_set_property $dash RSUGroup itemsPerRow 1
dashboard_set_property $dash RSUGroup title "RSU Controller"

dashboard_add $dash RSU3Group group RSUGroup
dashboard_set_property $dash RSU3Group expandableX false
dashboard_set_property $dash RSU3Group expandableY false
dashboard_set_property $dash RSU3Group itemsPerRow 2
dashboard_set_property $dash RSU3Group title ""
dashboard_add $dash Busyled led RSU3Group
dashboard_set_property $dash Busyled color "red_off"
dashboard_set_property $dash Busyled text "RSU Busy"
dashboard_add $dash myRSUbutton button RSU3Group
dashboard_set_property $dash myRSUbutton text "Check RSU Busy"
dashboard_set_property $dash myRSUbutton onClick {::AVMM_PR_dashboard::RSUBusy}
dashboard_add $dash RSU2Group group RSUGroup
dashboard_set_property $dash RSU2Group expandableX false
dashboard_set_property $dash RSU2Group expandableY false
dashboard_set_property $dash RSU2Group itemsPerRow 2
dashboard_set_property $dash RSU2Group title ""
dashboard_add $dash myRSUlabel1 label RSU2Group
dashboard_set_property $dash myRSUlabel1 text "Watchdog Timer:"
dashboard_add $dash myRSUtext1 text RSU2Group
dashboard_set_property $dash myRSUtext1 text "0x0"
dashboard_set_property $dash myRSUtext1 preferredWidth 100
dashboard_add $dash myRSUbutton1 button RSU2Group
dashboard_set_property $dash myRSUbutton1 text "Read Watchdog"
dashboard_set_property $dash myRSUbutton1 onClick {::AVMM_PR_dashboard::read_watchdog}

dashboard_add $dash RSU4Group group RSUGroup
dashboard_set_property $dash RSU4Group expandableX false
dashboard_set_property $dash RSU4Group expandableY false
dashboard_set_property $dash RSU4Group itemsPerRow 2
dashboard_set_property $dash RSU4Group title ""

dashboard_add $dash myRSUlabel2 label RSU4Group
dashboard_set_property $dash myRSUlabel2 text "Image Select"
dashboard_add $dash myRSUtext2 text RSU4Group
dashboard_set_property $dash myRSUtext2 text "0x0"
dashboard_set_property $dash myRSUtext2 preferredWidth 100

dashboard_add $dash myRSUbutton5 button RSU4Group
dashboard_set_property $dash myRSUbutton5 text "Select Image1"
dashboard_set_property $dash myRSUbutton5 onClick {::AVMM_PR_dashboard::Img1config}

dashboard_add $dash myRSUbutton6 button RSU4Group
dashboard_set_property $dash myRSUbutton6 text "Select Image2"
dashboard_set_property $dash myRSUbutton6 onClick {::AVMM_PR_dashboard::Img2config}

dashboard_add $dash myRSUbutton7 button RSUGroup
dashboard_set_property $dash myRSUbutton7 text "Trigger Configuration"
dashboard_set_property $dash myRSUbutton7 onClick {::AVMM_PR_dashboard::Triconfig}

dashboard_add $dash OnChipWrapperGroup group self
dashboard_set_property $dash OnChipWrapperGroup expandableX false
dashboard_set_property $dash OnChipWrapperGroup expandableY false
dashboard_set_property $dash OnChipWrapperGroup itemsPerRow 1
dashboard_set_property $dash OnChipWrapperGroup title "ASMI Controller"
dashboard_add $dash ReadIDGroup group OnChipWrapperGroup
dashboard_set_property $dash ReadIDGroup expandableX false
dashboard_set_property $dash ReadIDGroup expandableY false
dashboard_set_property $dash ReadIDGroup itemsPerRow 2
dashboard_set_property $dash ReadIDGroup title ""
dashboard_add $dash StatusGroup group OnChipWrapperGroup
dashboard_set_property $dash StatusGroup expandableX false
dashboard_set_property $dash StatusGroup expandableY false
dashboard_set_property $dash StatusGroup itemsPerRow 2
dashboard_set_property $dash StatusGroup title ""

dashboard_add $dash thirdGroup group OnChipWrapperGroup
dashboard_set_property $dash thirdGroup expandableX false
dashboard_set_property $dash thirdGroup expandableY false
dashboard_set_property $dash thirdGroup itemsPerRow 2
dashboard_set_property $dash thirdGroup title ""

dashboard_add $dash EraseSTled led thirdGroup
dashboard_set_property $dash EraseSTled color "red_off"
dashboard_set_property $dash EraseSTled text "Erase State"

dashboard_add $dash myUFM1 button thirdGroup
dashboard_set_property $dash myUFM1 text "UFM1 Erase"
dashboard_set_property $dash myUFM1 onClick {::AVMM_PR_dashboard::ufm1_erase}
dashboard_add $dash myUFM0 button thirdGroup
dashboard_set_property $dash myUFM0 text "UFM0 Erase"
dashboard_set_property $dash myUFM0 onClick {::AVMM_PR_dashboard::ufm0_erase}
dashboard_add $dash myCFM2 button thirdGroup
dashboard_set_property $dash myCFM2 text "CFM2 Erase"
dashboard_set_property $dash myCFM2 onClick {::AVMM_PR_dashboard::cfm2_erase}
dashboard_add $dash myCFM1 button thirdGroup
dashboard_set_property $dash myCFM1 text "CFM1 Erase"
dashboard_set_property $dash myCFM1 onClick {::AVMM_PR_dashboard::cfm1_erase}
dashboard_add $dash myCFM0 button thirdGroup
dashboard_set_property $dash myCFM0 text "CFM0 Erase"
dashboard_set_property $dash myCFM0 onClick {::AVMM_PR_dashboard::cfm0_erase}


dashboard_add $dash mylabel20 label ReadIDGroup
dashboard_set_property $dash mylabel20 text "System ID:"
dashboard_add $dash mytext22 text ReadIDGroup
dashboard_set_property $dash mytext22 text ""
dashboard_set_property $dash mytext22 preferredWidth 100
dashboard_add $dash mybutton20 button ReadIDGroup
dashboard_set_property $dash mybutton20 text "Read System ID"
dashboard_set_property $dash mybutton20 onClick {::AVMM_PR_dashboard::read_SYSID}

dashboard_add $dash mylabel21 label StatusGroup
dashboard_set_property $dash mylabel21 text "On-Chip Flash Status:"
dashboard_add $dash mytext21 text StatusGroup
dashboard_set_property $dash mytext21 text ""
dashboard_set_property $dash mytext21 preferredWidth 100
dashboard_add $dash mybutton21 button StatusGroup
dashboard_set_property $dash mybutton21 text "Read Flash Status"
dashboard_set_property $dash mybutton21 onClick {::AVMM_PR_dashboard::read_STATUSID}


dashboard_add $dash OnChipTopGroup group OnChipWrapperGroup
dashboard_set_property $dash OnChipTopGroup expandableX false
dashboard_set_property $dash OnChipTopGroup expandableY false
dashboard_set_property $dash OnChipTopGroup itemsPerRow 2
dashboard_set_property $dash OnChipTopGroup title ""
dashboard_add $dash ASMIManGroup group OnChipTopGroup
dashboard_set_property $dash ASMIManGroup expandableX false
dashboard_set_property $dash ASMIManGroup expandableY false
dashboard_set_property $dash ASMIManGroup itemsPerRow 1
dashboard_set_property $dash ASMIManGroup title "Single Address accesing"

dashboard_add $dash SingleDataGroup group ASMIManGroup
dashboard_set_property $dash SingleDataGroup expandableX false
dashboard_set_property $dash SingleDataGroup expandableY false
dashboard_set_property $dash SingleDataGroup itemsPerRow 2
dashboard_set_property $dash SingleDataGroup title ""

dashboard_add $dash mylabel20 label SingleDataGroup
dashboard_set_property $dash mylabel20 text "Flash Address:"
dashboard_add $dash mytext20 text SingleDataGroup
dashboard_set_property $dash mytext20 text "0x0"
dashboard_set_property $dash mytext20 preferredWidth 100

dashboard_add $dash mylabel10 label SingleDataGroup
dashboard_set_property $dash mylabel10 text "Flash Data:"
dashboard_add $dash mytext10 text SingleDataGroup
dashboard_set_property $dash mytext10 text "0x0"
dashboard_set_property $dash mytext10 preferredWidth 100
dashboard_add $dash mybutton4 button SingleDataGroup
dashboard_set_property $dash mybutton4 text "Read Data"
dashboard_set_property $dash mybutton4 onClick {::AVMM_PR_dashboard::read_data}
dashboard_add $dash mybutton5 button SingleDataGroup
dashboard_set_property $dash mybutton5 text "Write Data"
dashboard_set_property $dash mybutton5 onClick {::AVMM_PR_dashboard::write_data}



dashboard_add $dash OnChipGroup group OnChipTopGroup
dashboard_set_property $dash OnChipGroup expandableX false
dashboard_set_property $dash OnChipGroup expandableY false
dashboard_set_property $dash OnChipGroup itemsPerRow 1
dashboard_set_property $dash OnChipGroup title "Full Image"

dashboard_add $dash topGroup group OnChipGroup
dashboard_set_property $dash topGroup expandableX false
dashboard_set_property $dash topGroup expandableY false
dashboard_set_property $dash topGroup itemsPerRow 2
dashboard_set_property $dash topGroup title ""
dashboard_add $dash mylabel1 label topGroup
dashboard_set_property $dash mylabel1 text "Programming Progress: "
dashboard_add $dash mylabel2 label topGroup
dashboard_set_property $dash mylabel2 text "Not Started"
dashboard_add $dash secGroup group OnChipGroup
dashboard_set_property $dash secGroup expandableX false
dashboard_set_property $dash secGroup expandableY false
dashboard_set_property $dash secGroup itemsPerRow 3
dashboard_set_property $dash secGroup title ""
dashboard_add $dash mylabel3 label secGroup
dashboard_set_property $dash mylabel3 text "Input File:"
dashboard_add $dash mytext text secGroup
dashboard_set_property $dash mytext text ""
dashboard_set_property $dash mytext preferredWidth 300
dashboard_add $dash myfile1 fileChooserButton secGroup
dashboard_set_property $dash myfile1 text "Select File"
dashboard_set_property $dash myfile1 onChoose {::AVMM_PR_dashboard::update_file}
dashboard_set_property $dash myfile1 chooserButtonText "Select"
dashboard_add $dash ConfGroup group OnChipGroup
dashboard_set_property $dash ConfGroup expandableX false
dashboard_set_property $dash ConfGroup expandableY false
dashboard_set_property $dash ConfGroup itemsPerRow 2
dashboard_set_property $dash ConfGroup title ""
dashboard_add $dash mybutton3 button ConfGroup
dashboard_set_property $dash mybutton3 text "Start Image1 Configure"
dashboard_set_property $dash mybutton3 onClick {::AVMM_PR_dashboard::start_image1_programming}
dashboard_add $dash mybutton6 button ConfGroup
dashboard_set_property $dash mybutton6 text "Start Image2 Configure"
dashboard_set_property $dash mybutton6 onClick {::AVMM_PR_dashboard::start_image2_programming}

dashboard_set_property $dash self itemsPerRow 1
dashboard_set_property $dash self visible true}

