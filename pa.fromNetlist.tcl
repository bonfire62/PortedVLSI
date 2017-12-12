
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name PortedVLSI -dir "C:/Users/kenbo/Documents/XilinxProjects/PortedVLSI/planAhead_run_2" -part xc7a100tcsg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/kenbo/Documents/XilinxProjects/PortedVLSI/VGA_Controller.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/kenbo/Documents/XilinxProjects/PortedVLSI} }
set_property target_constrs_file "VGA_Controller.ucf" [current_fileset -constrset]
add_files [list {VGA_Controller.ucf}] -fileset [get_property constrset [current_run]]
link_design
