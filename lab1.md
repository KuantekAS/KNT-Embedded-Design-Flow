# Use Efinity to build an Embedded System

After completing this lab, you will be able to:  
    
- Create an Efinity project for a Sapphire system.  
- Use the IP Manager to create a hardware system  
- Use RISC-V SDK(Software Development Kit) to create an uart echo example project  
- Run the test application on the board and hence verify hardware functionality

# Steps
## Create Efinity Project 
 
1. Open Efinity by selecting Start > Efinity 2022.2 > Efinity 2022.2
2. Click File > Create Project… to start the wizard. You will see Project Editor dialog box. 
3. Click the Browse button of the Project location field of the New Project form, browse to C:/Efinity/Embedded/Lab1. 
4. Enter Lab1 in the Project name field. Make sure that the Family field selected Trion and device field selected the T8F8. Click Design tab.
![Project Name and Location entry](/image/lab1/1.png "Project Name and Location entry.")


## Creating the System Using the IP Manager

1.	In the Project pane, right-click the IP and click New IP to open IP Catalog.

![This is a alt text.](/image/lab1/3.png "This is a sample image.")

2.	Expand Installed IP > Efinix > Processors and Peripherals then select Sapphire SoC and click Next button.

![This is a alt text.](/image/lab1/4.png "This is a sample image.")

3.	 IP Configuration page will be opened. Enter the module name as Lab1. In SoC tab, deselect ‘Cache’ and set Frequency as 20 MHz.

4.	 Deselect include the external memory AXI interface option in Cache/Memory tab. On-Chip Ram size should be 4KB. 

5.	 In Debug tab select target board as Xyloni.

6.	 On UART tab, only UART0 will be enabled and UART interrupt ID should be 1.

7.	 On I2C tab, deselect I2C 0 option.

8.	 On GPIO tab, deselect GPIO 0 option.

9.	 On AXI4 tab, deselect AXI Slave option.

10.	 And leave default other settings. After these configuration,ip will seen like this.

![This is a alt text.](/image/lab1/5.png "This is a sample image.")

11.	 Click generate and IP will be generated.


## Add Top Design File

1.	Enter top_soc in the Top Module/Entity field.

2.	In the Project pane, right-click the Design and select Add. Browse to the C:\Efinity\Embedded\sources\Lab1 directory, select top.v design file and copy to project and click open button.  
![This is a alt text.](/image/lab1/6.png "This is a sample image.")

## Create the lab1.pt.sdc source.

1.	Open Efinity Interface Designer.

![This is a alt text.](/image/lab1/interface.png "This is a sample image.")

2.	Right click to GPIO and select create block. Enter the block name as

    **i.** system_uart_0_io_rxd and select mode as input and pull option weak pullup.  

    **ii.** system_uart_0_io_txd and select mode as output.                            

    **iii.** io_asyncResetn. Select mode as input and pull option weak pullup. 

    **iv.** my_pll_refclk. Select mode as input and select Connection type as pll_clkin. Select Pull option weak pullup.  

    **v.** system_spi_0_io_data_0. Select mode as inout. In the Input tab enter pin name as system_spi_0_io_data_0_read, select Register and enter clock name as io_systemClk. In the Output tab enter pin name as system_spi_0_io_data_0_write and enter clock name as io_systemClk. In the Output Enable tab enter pin name as system_spi_0_io_data_0_writeEnable and select register.  

    **vi.** system_spi_0_io_data_1. Select mode as inout. In the Input tab enter pin name as system_spi_0_io_data_1_read, select Register and enter clock name as io_systemClk. In the Output tab enter pin name as system_spi_0_io_data_1_write, select Register and enter clock name as io_systemClk. In the Output Enable tab enter pin name as system_spi_0_io_data_1_writeEnable and select register.  

    **vii.** system_spi_0_io_sclk_write. Select mode as output. Select Register and enter clock name as io_systemClk.  

    **viii.** system_spi_0_io_ss. Select mode as output. Select Register and enter clock name as io_systemClk.  

    **ix.** system_spi_0_io_data_2. Select mode as inout. In the Input tab enter pin name as system_spi_0_io_data_2_read, select Register and enter clock name as io_systemClk. In the Output tab enter pin name as system_spi_0_io_data_2_write, select Register and enter clock name as io_systemClk. In the Output Enable tab enter pin name as system_spi_0_io_data_2_writeEnable and select register.   

    **x.** system_spi_0_io_data_3. Select mode as inout. In the Input tab enter pin name as system_spi_0_io_data_3_read, select Register and enter clock name as io_systemClk. In the Output tab enter pin name as system_spi_0_io_data_3_write, select Register and enter clock name as io_systemClk. In the Output Enable tab enter pin name as system_spi_0_io_data_3_writeEnable and select register. 

3.	Right click to PLL and select create block. Click Automated Clock Calculation. In the open window set input and output frequency as 33 MHz. 

4.	Click to enable reset pin and enter the name as systemClk_rstn. Click to enable locked pin and enter the name as systemClk_locked. Click finish.

5.	Right click to GPIO and select create block. Enter the Instance name as jtag_inst1. Select JTAG Resource JTAG_USER1.  
![This is a alt text.](/image/lab1/7.png "This is a sample image.")

6.	Click show/hide GPIO Resource Assigner. Enter the resource part according to the datasheet [(Xyloni User Guide)](https://www.efinixinc.com/docs/xyloni-devkit-ug-v1.2.pdf).
![This is a alt text.](/image/lab1/8.png "This is a sample image.")

7.	Save and check the design then click Generate Efinity constraint file.  

![This is a alt text.](/image/lab1/save.png "This is a sample image.")

8.	Click right constraint and select copy to project and open. In outflow folder, SDC file will be generated. Select {projectname}.pt.sdc and click open.

## Run Software Flow the Design

1.	Click Synthesis under the dashboard.
2.	When the process is completed. Click Result tab and expand Synthesis. Open labs.map.rpt file as we want to look at the synthesis output before progressing to the placement and routing the stage.  
![This is a alt text.](/image/lab1/9.png "This is a sample image.")

3.	After the generated bitstream files, open programmer from tools toolbar. Connect Xyloni with USB to your computer and click refresh. Device will be connect automatically.Then on image menu, click ‘select image file’ and select {projectname}.bit file. Programming mode will be JTAG and JTAG options will be default. Click start program. You can check programming process from console.

## Creating the SDK Project with Efinity RISC-V IDE 

1.	Open Efinity RISC-V IDE program. Click browse and select project folder as C:/Efinity/Embedded/Lab1/embedded_sw. Click Launch.
2.	From project explorer click import project. Efinix Projects > Efinix Makefile Project> BSP location  and click browse ,embedded_sw > lab1 and select bsp folder then click next. Select ‘uartEchoDemo’ and finish.  
![This is a alt text.](/image/lab1/10.png "This is a sample image.")
3.	Expand  src folder and open main.c file. This is our main code. You can build your code with CTRL+B.    
4.	Open terminal and select Serial Terminal on choose terminal menu.  
![This is a alt text.](/image/lab1/11.png "This is a sample image.")  

    Terminal settings :

        Serial Port = Serial port is the defined communication port on your computer.  
        Baud Rate = 115200  
        Data Size = 8  
        Parity = None  
        Stop bits = 1  
        Encoding = Default  

5.	Click run button and select run configuration.  
![This is a alt text.](/image/lab1/12.png "This is a sample image.")
6.	In the open window expand  GBD OpenOCD Debugging and select uartEchoDemo_trion and click Run. Program will be running. 
7.	Send a char value on the terminal window and verify the functionality.  
![This is a alt text.](/image/lab1/13.png "This is a sample image.")


# 
# 
