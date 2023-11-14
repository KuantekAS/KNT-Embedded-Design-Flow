# Debugging Using Open Debugger

After completing this lab, you will be able to:  
    
- Add a VIO core in the design
- Use a VIO core to inject stimulus to the design and monitor the response
- Add an ILA core in Efinity
- Perform hardware debugging using the Open Debugger


# Steps
## Copy Lab5 Project as Lab7
 
1. Open your previous lab folder.
2. Copy your ‘lab5’ project and paste as lab7. 
3. Open Efinity by selecting Start > Efinity 2022.2 > Efinity 2022.2
4. Click Open Project from File > Open Project and search lab7 project location.
5. Select lab1.xml file in lab7 folder. Click open. 



## Add VIO/ILA Ports

1. Open top.v design file.
2. Add these codes to line 31.

        input           jtag_inst2_TCK,
        input           jtag_inst2_TDI,
        output          jtag_inst2_TDO,
        input           jtag_inst2_SEL,
        input           jtag_inst2_CAPTURE,
        input           jtag_inst2_SHIFT,
        input           jtag_inst2_UPDATE,
        input           jtag_inst2_RESET,

3. Delete these codes line 50.

        input   [1:0] butons,
        output wire  led_port_1 ,
        output wire  led_port_2, 
        output wire  led_port_3, 
        output wire  led_port_4,

4. Add these codes line 59.

        output  reg [3:0]    result,
        output  wire [3:0]   ain,
        output  wire [3:0]   bin,
        output  wire         select,

5. Add these codes line 72.

        wire [3:0]         ain_vio;
        wire [3:0]         bin_vio;
        wire               select;

6. Delete these codes in line 176.

        .led_port_1(led_port_1),
        .led_port_2(led_port_2),
        .led_port_3(led_port_3),
        .led_port_4(led_port_4)

7. And add these codes line 176.

        .ain(ain),
        .bin(bin)

8. Then add these codes line 265.

        always@(posedge io_systemClk)begin
        if(io_systemReset)begin
        result = 0;
        end
        else if (select) begin
        result <= ain_vio + bin_vio;
        end
        else begin
        result <= ain + bin;
        end
        end

9. Save the file and open axi4_lite design file.
10. Delete lines 18-21 and replace with these codes.

        output wire  [3:0]   ain,
        output wire  [3:0]   bin,
        output wire          select,

11. Delete lines  112. (slv_reg3 registers) 228, (slv_reg3< =0) 262. (2’h3 case) 260, ( slv_reg3 <= slv_reg3;) 255, ( 2'h3 : reg_data_out <= slv_reg3;), 272 (reg_data_out <= slv_reg3;)

12. Delete these line 397:

	assign led_port_1 = slv_reg0;  
        assign led_port_2 = slv_reg1;  
        assign led_port_3 = slv_reg2;  
        assign led_port_4 = slv_reg3;

13. Add these line 397.

        assign ain          = slv_reg0[3:0];
        assign bin          = slv_reg1[3:0];
        assign select       = slv_reg2 ;

## Set Debug Settings

1. Open debugger.  
![](https://imgur.com/a32ucH0.png)  

2. Add ILA core and add these probes like below.  
![](https://imgur.com/46lAMFp.png)  

3. Add VIO core and add these sources like below.  
![](https://imgur.com/ECBPYP4.png)   

4. Then click generate and close window.

## Add Debug Design File and Edit top.v File.

1. Click right Design then add , select debug_top.v file from source folder. Select Copy to Project and click open.  
![](https://imgur.com/oUX25CI.png)  

2. Open top.v and add these codes line 133.(These codes generated from debugger and it is included debug_TEMPLATE.v file.)  

        edb_top edb_top_inst(
        .bscan_CAPTURE      ( jtag_inst2_CAPTURE ),
        .bscan_DRCK         ( jtag_inst2_DRCK ),
        .bscan_RESET        ( jtag_inst2_RESET ),
        .bscan_RUNTEST      ( jtag_inst2_RUNTEST ),
        .bscan_SEL          ( jtag_inst2_SEL ),
        .bscan_SHIFT        ( jtag_inst2_SHIFT ),
        .bscan_TCK          ( jtag_inst2_TCK ),
        .bscan_TDI          ( jtag_inst2_TDI ),
        .bscan_TMS          ( jtag_inst2_TMS ),
        .bscan_UPDATE       ( jtag_inst2_UPDATE ),
        .bscan_TDO          ( jtag_inst2_TDO ),
        .la0_clk            ( io_systemClk ),
        .la0_ain            ( ain ),
        .la0_bin            ( bin ),
        .la0_ain_vio        ( ain_vio ),
        .la0_bin_vio        ( bin_vio ),
        .la0_result         ( result ),
        .la0_select         ( select ),
        .la0_axi_awvalid    ( axi_awvalid ),
        .la0_axi_awready    ( axi_awready ),
        .la0_axi_wready     ( axi_wready ),
        .la0_axi_wvalid     ( axi_wvalid ),
        .vio0_clk           ( io_systemClk ),
        .vio0_ain_vio       ( ain_vio ),
        .vio0_bin_vio       ( bin_vio ),
        .vio0_select        ( select )
        );

3. Code must be look like this.  
![](https://imgur.com/uFyp9di.png)  

## Update .sdc File with Inteface Designer.

1. Open interface designer and right click JTAG User Tap and create block and select USER2.   
![](https://imgur.com/h3lOtcH.png)  

2. Delete buttons an leds pins. 

3. Then click check design. If there is no problem after checking , for generate constraint file click generate efinity constraint files button.  
![](https://imgur.com/nhJZCQe.png)   

## Run Software Flow the Design

1. Click Synthesis under the dashboard for start software flow.

2. After the generated bitstream files, open programmer from tools toolbar. Connect Xyloni with USB to your computer and click refresh. Device will be connect automatically.Then on image menu, click ‘select image file’ and select {projectname}.bit file. Programming mode will be JTAG and JTAG options will be default. Click start program. You can check programming process from console.  

## Debug the Hardware

1. After generated bitstream open Open Debugger and load bit file in configuration window. Then select USER2 and connect debugger.   
![](https://imgur.com/0Szzr5v.png)   

2. In vio tab, our source bits set like this.  
![](https://imgur.com/vdyyATo.png)   
3. In ila tab , add select bit and trigger value should be logic 1 and click run.   
![](https://imgur.com/s8FyMYG.png)     
![](https://imgur.com/EzVc8aU.png)   
4. After clicking run , go vio tab and change select 0 to 1 . Output signal wave should be like this.   
![](https://imgur.com/heJvKkO.png)   
5. After then, close debugger.

## Opening the SDK Project with Efinity RISC-V IDE

1. Open Efinity RISC-V IDE program. Click browse and select project folder as C:/Efinity/Embedded/Lab7/embedded_sw. Click Launch.
2. From project explorer click import project. Efinix Projects > Efinix Makefile Project> BSP location  and click browse ,embedded_sw > lab7 and select bsp folder then click next. Select ‘axi4Demo’ and finish.  

3. Open main.c file in src folder and Delete lines 138 and 139.  
![](https://imgur.com/8DG44Lv.png)   

4. Run the program. After the running , terminate program from console.Turn back to debugger and connect debugger again. On ILA tab , change trigger value of select 1 to 0. When select bit go from 1 to 0 then ila will be triggered.

5. Then go VIO tab , change value of select 1 to 0.  
![](https://imgur.com/3tQEZmw.png) 

6. Signal wave should be like this.  
![](https://imgur.com/qgccJu0.png) 
  

# 
# 
