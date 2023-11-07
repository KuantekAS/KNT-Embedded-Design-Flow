
# Efinity Interface Designer SDC
# Version: 2022.2.322.2.14
# Date: 2023-03-01 09:16

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: T8F81
# Project: lab1
# Timing Model: C2 (final)

# PLL Constraints
#################
create_clock -period 49.6601 -waveform {24.8301 49.6601} [get_ports {io_systemClk}]

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {butons[0]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {butons[0]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {butons[1]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {butons[1]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {my_pll_refclk}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {my_pll_refclk}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_uart_0_io_rxd}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_uart_0_io_rxd}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {leds[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {leds[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {leds[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {leds[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {leds[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {leds[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {leds[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {leds[3]}]
set_output_delay -clock io_systemClk -max -3.903 [get_ports {system_spi_0_io_sclk_write}]
set_output_delay -clock io_systemClk -min -1.784 [get_ports {system_spi_0_io_sclk_write}]
set_output_delay -clock io_systemClk -max -3.903 [get_ports {system_spi_0_io_ss}]
set_output_delay -clock io_systemClk -min -1.784 [get_ports {system_spi_0_io_ss}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_uart_0_io_txd}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_uart_0_io_txd}]
set_input_delay -clock io_systemClk -max 5.958 [get_ports {system_spi_0_io_data_0_read}]
set_input_delay -clock io_systemClk -min 2.128 [get_ports {system_spi_0_io_data_0_read}]
set_output_delay -clock io_systemClk -max -3.903 [get_ports {system_spi_0_io_data_0_write}]
set_output_delay -clock io_systemClk -min -1.784 [get_ports {system_spi_0_io_data_0_write}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_spi_0_io_data_0_writeEnable}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_spi_0_io_data_0_writeEnable}]
set_input_delay -clock io_systemClk -max 5.958 [get_ports {system_spi_0_io_data_1_read}]
set_input_delay -clock io_systemClk -min 2.128 [get_ports {system_spi_0_io_data_1_read}]
set_output_delay -clock io_systemClk -max -3.903 [get_ports {system_spi_0_io_data_1_write}]
set_output_delay -clock io_systemClk -min -1.784 [get_ports {system_spi_0_io_data_1_write}]
set_output_delay -clock io_systemClk -max -3.913 [get_ports {system_spi_0_io_data_1_writeEnable}]
set_output_delay -clock io_systemClk -min -1.786 [get_ports {system_spi_0_io_data_1_writeEnable}]
set_input_delay -clock io_systemClk -max 5.958 [get_ports {system_spi_0_io_data_2_read}]
set_input_delay -clock io_systemClk -min 2.128 [get_ports {system_spi_0_io_data_2_read}]
set_output_delay -clock io_systemClk -max -3.903 [get_ports {system_spi_0_io_data_2_write}]
set_output_delay -clock io_systemClk -min -1.784 [get_ports {system_spi_0_io_data_2_write}]
set_output_delay -clock io_systemClk -max -3.913 [get_ports {system_spi_0_io_data_2_writeEnable}]
set_output_delay -clock io_systemClk -min -1.786 [get_ports {system_spi_0_io_data_2_writeEnable}]
set_input_delay -clock io_systemClk -max 5.958 [get_ports {system_spi_0_io_data_3_read}]
set_input_delay -clock io_systemClk -min 2.128 [get_ports {system_spi_0_io_data_3_read}]
set_output_delay -clock io_systemClk -max -3.903 [get_ports {system_spi_0_io_data_3_write}]
set_output_delay -clock io_systemClk -min -1.784 [get_ports {system_spi_0_io_data_3_write}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {system_spi_0_io_data_3_writeEnable}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {system_spi_0_io_data_3_writeEnable}]

# JTAG Constraints
####################
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_TCK}]
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_DRCK}]
set_output_delay -clock jtag_inst1_TCK -max 0.155 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min -0.053 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.374 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.374 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.374 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.323 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.116 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.374 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.449 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.161 [get_ports {jtag_inst1_SHIFT}]
