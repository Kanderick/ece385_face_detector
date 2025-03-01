transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD {C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD/MaskOnePath.sv}
vlog -sv -work work +incdir+C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD {C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD/MaskLayer.sv}
vlog -sv -work work +incdir+C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD {C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD/ImageReg.sv}
vlog -sv -work work +incdir+C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD {C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD/ImageRead.sv}
vlog -sv -work work +incdir+C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD {C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD/ConfidenceReg.sv}
vlog -sv -work work +incdir+C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD {C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD/ImageProcess.sv}

vlog -sv -work work +incdir+C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD {C:/ece385/TRDB_DC2_v2.1_FINALVERSION_UIUPUP/TRDB_DC2_v2.1/DE2/DE2_with_VGA/DE2_CCD/testbench2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench2

add wave *
view structure
view signals
run 1000 ns
