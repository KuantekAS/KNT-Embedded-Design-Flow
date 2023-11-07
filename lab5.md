# Use Efinity to build an Embedded System

After completing this lab, you will be able to:  
    
- Add additional IP to a hardware design
- Setup some of the compiler settings

# Steps
## Copy Lab4 Project as Lab5
 
1. Open your previous lab folder.
2. Copy your ‘lab4’ project and paste as lab5. 
3. Open Efinity by selecting Start > Efinity 2022.2 > Efinity 2022.2
4. Click Open Project from File > Open Project and search lab5 project location.
5. Select lab1.xml file in lab5 folder. Click open. 

![](https://imgur.com/9NX2CY6.png)

## Add AXI4-LITE IP to the Project
1. In the Project pane, right-click the Design and select Add. Browse to the C:\Efinity\Embedded\sources\Lab5 directory, select axi4_lite.v and copy to project. Click open button.


## Edit top.v Design File and Configure the Sapphire IP

1. Right click the saphire IP and select Configure buuton.
2. In IP configuration window, click AXI4 and enable AXI4 Slave Interface. Select AXI Slave size as 64KB.
3. Click generate. This it will  open AXI4 bus on our processor.
4. Then open top module and instantiate our AXI4-LITE signals.
5.  Add these codes line 80.
    
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

6. Add these codes line 141.
        
        .axi4_lite led_buton_axi4(  
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
        .led_port_1(led_port_1),  
        .led_port_2(led_port_2),  
        .led_port_3(led_port_3),  
        .led_port_4(led_port_4)  
        );

7. Add these codes line 214.
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

8. Add these codes line 51
    
        output wire  led_port_1 ,   
        output wire  led_port_2,  
        output wire  led_port_3,  
        output wire  led_port_4,         

9. Delete line 49( This code line should be like ‘input [3:0] leds line’.).Save top module  file and open interface designer.
10. Delete leds[3:0] bus and add a GPIO block for each led. GPIO mode should be output mode.Then, open resource assigner and assign gpio pins to leds.
11. Check design from toolbar and if not exist an issue , generate constraint file.Then add sdc file from project toolbar.

## Run Software Flow the Design

1. Click Synthesis under the dashboard for start software flow.

2. After the generated bitstream files, open programmer from tools toolbar. Connect Xyloni with USB to your computer and click refresh. Device will be connect automatically.Then on image menu, click ‘select image file’ and select {projectname}.bit file. Programming mode will be JTAG and JTAG options will be default. Click start program. You can check programming process from console.    
![](https://imgur.com/qLU61Ey.png)


## Opening the SDK Project with Efinity RISC-V IDE

1.	Open Efinity RISC-V IDE program. Click browse and select project folder as C:/Efinity/Embedded/Lab5/embedded_sw. Click Launch.
2.	From project explorer click import project. Efinix Projects > Efinix Makefile Project> BSP location  and click browse embedded_sw > lab4 and select bsp folder then click next. Select ‘axi4Demo’ and finish.    
![](https://imgur.com/MqpN59c.png)
3.	Open main.c file in src folder and  add these codes to line 51.  

        #define MY_LED_IP_S00_AXI_SLV_REG0_OFFSET 0
        #define MY_LED_IP_S00_AXI_SLV_REG1_OFFSET 4
        #define MY_LED_IP_S00_AXI_SLV_REG2_OFFSET 8
        #define MY_LED_IP_S00_AXI_SLV_REG3_OFFSET 12

        #define MY_LED_IP_mWriteReg(Data,BaseAddress, RegOffset) \
        write_u32((u32)(Data),(BaseAddress) + (RegOffset))

5. Delete the all lines codes in main function.  
6. Add these codes to main function.

        MY_LED_IP_mWriteReg(0x1, SYSTEM_AXI_A_BMB,MY_LED_IP_S00_AXI_SLV_REG0_OFFSET );
        MY_LED_IP_mWriteReg(0x1, SYSTEM_AXI_A_BMB,MY_LED_IP_S00_AXI_SLV_REG1_OFFSET );
        MY_LED_IP_mWriteReg(0x0, SYSTEM_AXI_A_BMB,MY_LED_IP_S00_AXI_SLV_REG2_OFFSET );
        MY_LED_IP_mWriteReg(0x1, SYSTEM_AXI_A_BMB,MY_LED_IP_S00_AXI_SLV_REG3_OFFSET );
  
6. You can build your code with CTRL+B. If there is not exist error , our code is correct.
7. Click run button and select run configuration.  
6. In the open window expand  GBD OpenOCD Debugging and select axi4Demo_trion and click Run. Program will be running.    
![](https://imgur.com/8bU6rVh.png)
7. After the running the program , Xyloni card should look like this.:  
![](https://imgur.com/Kc2QgyG.png)


# 
# 
