onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color {Violet Red} -radix unsigned /DSP48A1_tb/A_tb
add wave -noupdate -color {Violet Red} -radix unsigned /DSP48A1_tb/B_tb
add wave -noupdate -color {Violet Red} -radix unsigned /DSP48A1_tb/C_tb
add wave -noupdate -color {Violet Red} -radix unsigned /DSP48A1_tb/D_tb
add wave -noupdate /DSP48A1_tb/CLK_tb
add wave -noupdate -color Blue -radix binary /DSP48A1_tb/OPMODE_tb
add wave -noupdate -color Cyan /DSP48A1_tb/CEA_tb
add wave -noupdate -color Cyan /DSP48A1_tb/CEB_tb
add wave -noupdate -color Cyan /DSP48A1_tb/CEC_tb
add wave -noupdate -color Cyan /DSP48A1_tb/CECARRYIN_tb
add wave -noupdate -color Cyan /DSP48A1_tb/CED_tb
add wave -noupdate -color Cyan /DSP48A1_tb/CEM_tb
add wave -noupdate -color Cyan /DSP48A1_tb/CEOPMODE_tb
add wave -noupdate -color Cyan /DSP48A1_tb/CEP_tb
add wave -noupdate -color Orange /DSP48A1_tb/RSTA_tb
add wave -noupdate -color Orange /DSP48A1_tb/RSTB_tb
add wave -noupdate -color Orange /DSP48A1_tb/RSTC_tb
add wave -noupdate -color Orange /DSP48A1_tb/RSTCARRYIN_tb
add wave -noupdate -color Orange /DSP48A1_tb/RSTD_tb
add wave -noupdate -color Orange /DSP48A1_tb/RSTM_tb
add wave -noupdate -color Orange /DSP48A1_tb/RSTOPMODE_tb
add wave -noupdate -color Orange /DSP48A1_tb/RSTP_tb
add wave -noupdate -color {Light Steel Blue} /DSP48A1_tb/BCIN_tb
add wave -noupdate -color {Light Steel Blue} /DSP48A1_tb/PCIN_tb
add wave -noupdate -color {Light Steel Blue} /DSP48A1_tb/CARRYIN_tb
add wave -noupdate /DSP48A1_tb/M_tb
add wave -noupdate /DSP48A1_tb/P_tb
add wave -noupdate /DSP48A1_tb/CARRYOUT_tb
add wave -noupdate /DSP48A1_tb/CARRYOUTF_tb
add wave -noupdate /DSP48A1_tb/PCOUT_tb
add wave -noupdate /DSP48A1_tb/BCOUT_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {102 ns}
