start_gui
create_project -force prjl1
add_files "*.v"
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1 
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse "tb*.v"
update_compile_order -fileset sim_1 
update_compile_order -fileset sim_1 
update_compile_order -fileset sim_1 
#launch_runs synth_1
launch_simulation


set curr_wave [current_wave_config]
if { [string length $curr_wave] == 0 } {
  if { [llength [get_objects]] > 0} {
    add_wave /
    set_property needs_save false [current_wave_config]
  } else {
     send_msg_id Add_Wave-1 WARNING "No top level signals found. Simulator will start without a wave window. If you want to open a wave window go to 'File->New Waveform Configuration' or type 'create_wave_config' in the TCL console."
  }
}

run 1000ns




