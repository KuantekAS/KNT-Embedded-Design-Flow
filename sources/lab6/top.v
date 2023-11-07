/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2022 Efinix Inc. All rights reserved.
//
// Description:
// Example top file for EfxSapphireSoc
//
// Language:  Verilog 2001
//
// ------------------------------------------------------------------------------
// REVISION:
//  $Snapshot: $
//  $Id:$
//
// History:
// 1.0 Initial Release. 
/////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module top(
output   	my_pll_rstn,
input	    my_pll_locked,
input		jtag_inst1_TCK,
input		jtag_inst1_TDI,
output		jtag_inst1_TDO,
input		jtag_inst1_SEL,
input		jtag_inst1_CAPTURE,
input		jtag_inst1_SHIFT,
input       jtag_inst1_UPDATE,
input       jtag_inst1_RESET,
output		system_spi_0_io_sclk_write,
output		system_spi_0_io_data_0_writeEnable,
input		system_spi_0_io_data_0_read,
output		system_spi_0_io_data_0_write,
output		system_spi_0_io_data_1_writeEnable,
input		system_spi_0_io_data_1_read,
output		system_spi_0_io_data_1_write,
output		system_spi_0_io_data_2_writeEnable,
input		system_spi_0_io_data_2_read,
output		system_spi_0_io_data_2_write,
output		system_spi_0_io_data_3_writeEnable,
input		system_spi_0_io_data_3_read,
output		system_spi_0_io_data_3_write,
output		system_spi_0_io_ss,

output		system_uart_0_io_txd,
input		system_uart_0_io_rxd,


input   [1:0] button,

output [3:0] led,

input       io_systemClk
//input       io_asyncResetn
);
/////////////////////////////////////////////////////////////////////////////
//Reset and PLL
wire 		reset;
wire		io_systemReset;	
wire        userInterruptA;


/////////////////////////////////////////////////////////////////////////////
//Reset and PLL
//assign reset 	= ~( io_asyncResetn & my_pll_locked);
assign reset 	= ~(my_pll_locked);
assign my_pll_rstn 	= 1'b1;


/////////////////////////////////////////////////////////////////////////////
/*
wire [15:0] io_apbSlave_0_PADDR;
wire		io_apbSlave_0_PSEL;
wire		io_apbSlave_0_PENABLE;
wire		io_apbSlave_0_PREADY;
wire		io_apbSlave_0_PWRITE;
wire [31:0] io_apbSlave_0_PWDATA;
wire [31:0] io_apbSlave_0_PRDATA;
wire		io_apbSlave_0_PSLVERROR;
*/

wire        io_peripheralReset;
wire        axi4Interrupt;
wire [7:0]  axi_awid;
wire [31:0]	axi_awaddr;
wire [7:0]	axi_awlen;
wire [2:0]	axi_awsize;
wire [1:0]	axi_awburst;
wire		axi_awlock;
wire [3:0]	axi_awcache;
wire [2:0]	axi_awprot;
wire [3:0]	axi_awqos;
wire [3:0]	axi_awregion;
wire		axi_awvalid;
wire		axi_awready;
wire [31:0]	axi_wdata;
wire [3:0]  axi_wstrb;
wire		axi_wvalid;
wire		axi_wlast;
wire		axi_wready;
wire [7:0]  axi_bid;
wire [1:0]  axi_bresp;
wire		axi_bvalid;
wire		axi_bready;
wire [7:0]	axi_arid;
wire [31:0]	axi_araddr;
wire [7:0]	axi_arlen;
wire [2:0]	axi_arsize;
wire [1:0]	axi_arburst;
wire		axi_arlock;
wire [3:0]	axi_arcache;
wire [2:0]	axi_arprot;
wire [3:0]	axi_arqos;
wire [3:0]	axi_arregion;
wire		axi_arvalid;
wire		axi_arready;
wire [7:0]	axi_rid;
wire [31:0]	axi_rdata;
wire [1:0]	axi_rresp;
wire		axi_rlast;
wire		axi_rvalid;
wire		axi_rready;

/////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
 axi4_lite_led_button led_button_axi4(
.S_AXI_ACLK(io_systemClk),
.S_AXI_ARESETN(~io_systemReset),
.S_AXI_AWADDR(axi_awaddr),
.S_AXI_AWPROT(axi_awprot),
.S_AXI_AWVALID(axi_awvalid),
.S_AXI_AWREADY(axi_awready),
.S_AXI_WDATA(axi_wdata),
.S_AXI_WSTRB(axi_wstrb),
.S_AXI_WVALID(axi_wvalid),
.S_AXI_WREADY(axi_wready),
.S_AXI_BRESP(axi_bresp),
.S_AXI_BVALID(axi_bvalid),
.S_AXI_BREADY(axi_bready),
.S_AXI_ARADDR(axi_araddr),
.S_AXI_ARPROT(axi_arprot),
.S_AXI_ARVALID(axi_arvalid),
.S_AXI_ARREADY(axi_arready),
.S_AXI_RDATA(axi_rdata),
.S_AXI_RRESP(axi_rresp),
.S_AXI_RVALID(axi_rvalid),
.S_AXI_RREADY(axi_rready),
.led(led),
.button(button)
);
 /////////////////////////////////////////////////////////////////////////
saphire_lab u_saphire_lab(
.system_spi_0_io_sclk_write(system_spi_0_io_sclk_write),
.system_spi_0_io_data_0_writeEnable(system_spi_0_io_data_0_writeEnable),
.system_spi_0_io_data_0_read(system_spi_0_io_data_0_read),
.system_spi_0_io_data_0_write(system_spi_0_io_data_0_write),
.system_spi_0_io_data_1_writeEnable(system_spi_0_io_data_1_writeEnable),
.system_spi_0_io_data_1_read(system_spi_0_io_data_1_read),
.system_spi_0_io_data_1_write(system_spi_0_io_data_1_write),
.system_spi_0_io_data_2_writeEnable(system_spi_0_io_data_2_writeEnable),
.system_spi_0_io_data_2_read(system_spi_0_io_data_2_read),
.system_spi_0_io_data_2_write(system_spi_0_io_data_2_write),
.system_spi_0_io_data_3_writeEnable(system_spi_0_io_data_3_writeEnable),
.system_spi_0_io_data_3_read(system_spi_0_io_data_3_read),
.system_spi_0_io_data_3_write(system_spi_0_io_data_3_write),
.system_spi_0_io_ss(system_spi_0_io_ss),

.system_uart_0_io_txd(system_uart_0_io_txd),
.system_uart_0_io_rxd(system_uart_0_io_rxd),


.jtagCtrl_tck(jtag_inst1_TCK),
.jtagCtrl_tdi(jtag_inst1_TDI),
.jtagCtrl_tdo(jtag_inst1_TDO),
.jtagCtrl_enable(jtag_inst1_SEL),
.jtagCtrl_capture(jtag_inst1_CAPTURE),
.jtagCtrl_shift(jtag_inst1_SHIFT),
.jtagCtrl_update(jtag_inst1_UPDATE),
.jtagCtrl_reset(jtag_inst1_RESET),

.userInterruptA(userInterruptA),
.io_systemClk(io_systemClk),
.io_asyncReset(reset),
.io_systemReset(io_systemReset),

/*
.io_apbSlave_0_PADDR(io_apbSlave_0_PADDR),
.io_apbSlave_0_PENABLE(io_apbSlave_0_PENABLE),
.io_apbSlave_0_PRDATA(io_apbSlave_0_PRDATA),
.io_apbSlave_0_PREADY(io_apbSlave_0_PREADY),
.io_apbSlave_0_PSEL(io_apbSlave_0_PSEL),
.io_apbSlave_0_PSLVERROR(io_apbSlave_0_PSLVERROR),
.io_apbSlave_0_PWDATA(io_apbSlave_0_PWDATA),
.io_apbSlave_0_PWRITE(io_apbSlave_0_PWRITE),	
*/

.axiA_awvalid(axi_awvalid),
.axiA_awready(axi_awready),
.axiA_awaddr(axi_awaddr),
.axiA_awid(),
.axiA_awregion(),
.axiA_awlen(),
.axiA_awsize(),
.axiA_awburst(),
.axiA_awlock(),
.axiA_awcache(),
.axiA_awqos(),
.axiA_awprot(axi_awprot),
.axiA_wvalid(axi_wvalid),
.axiA_wready(axi_wready),
.axiA_wdata(axi_wdata),
.axiA_wstrb(axi_wstrb),
.axiA_wlast(),
.axiA_bvalid(axi_bvalid),
.axiA_bready(axi_bready),
.axiA_bid({8{1'b0}}),
.axiA_bresp(axi_bresp),
.axiA_arvalid(axi_arvalid),
.axiA_arready(axi_arready),
.axiA_araddr(axi_araddr),
.axiA_arid(),
.axiA_arregion(),
.axiA_arlen(),
.axiA_arsize(),
.axiA_arburst(),
.axiA_arlock(),
.axiA_arcache(),
.axiA_arqos(),
.axiA_arprot(axi_arprot),
.axiA_rvalid(axi_rvalid),
.axiA_rready(axi_rready),
.axiA_rdata(axi_rdata),
.axiA_rid({8{1'b0}}),
.axiA_rresp(axi_rresp),
.axiA_rlast(1'b1),
.axiAInterrupt(1'b0)
);

endmodule

//////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2022 Efinix Inc. All rights reserved.
//
// This   document  contains  proprietary information  which   is
// protected by  copyright. All rights  are reserved.  This notice
// refers to original work by Efinix, Inc. which may be derivitive
// of other work distributed under license of the authors.  In the
// case of derivative work, nothing in this notice overrides the
// original author's license agreement.  Where applicable, the 
// original license agreement is included in it's original 
// unmodified form immediately below this header.
//
// WARRANTY DISCLAIMER.  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND 
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH 
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES, 
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR 
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED 
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.
//
// LIMITATION OF LIABILITY.  
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY 
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT 
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY 
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT, 
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY 
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF 
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR 
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN 
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER 
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR 
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT 
//     APPLY TO LICENSEE.
//
/////////////////////////////////////////////////////////////////////////////