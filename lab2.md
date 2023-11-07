# Use Efinity to build an Embedded System

After completing this lab, you will be able to:  
    
- Add additional IP to a hardware design
- Setup some of the compiler settings

# Steps
## Copy Lab1 Project as Lab2
 
1. Open your previous lab folder.
2. Copy your ‘lab1’ project and paste as lab2. 
3. Open Efinity by selecting Start > Efinity 2022.2 > Efinity 2022.2
4. Click Open Project from File > Open Project and search lab2 project location.
5. Select lab1.xml file in lab2 folder. Click open. 

![Project Name and Location entry](/image/lab2/1.png "Project Name and Location entry.")


## Add APB3 IP to the Project

1.	In the Project pane, delete the top.v design file and right-click the Design and select Add. Browse to the C:\Efinity\Embedded\sources\Lab2 directory, select apb3_gpio.v and new top.v design file and copy to project. Click open button.  
![This is a alt text.](/image/lab2/2.png "This is a sample image.")

## Create the lab2.pt.sdc source

1.	Open Efinity Interface Designer.  
![This is a alt text.](/image/lab1/interface.png "This is a sample image.")

2.	 Right click to GPIO and select create bus. Enter the bus name as butons. Enter MSB as 1 and LSB as 0. Select mode as input and Pull Option as weak pullup. 

3.	 Right click to GPIO and select create bus. Enter the bus name as leds. Enter MSB as 3 and LSB as 0. Select mode as output.

4.	 leave the rest of the pins as default settings.

5.	 Click show/hide GPIO Resource Assigner. Enter the resource part according to the datasheet [(Xyloni User Guide)](https://www.efinixinc.com/docs/xyloni-devkit-ug-v1.2.pdf).  
![This is a alt text.](/image/lab2/3.png "This is a sample image.")

6.	 Save and check the design then click Generate Efinity constraint file.  
![This is a alt text.](/image/lab1/save.png "This is a sample image.")

7.	Click right constraint and select copy to project and open. In outflow folder, SDC file will be generated. Select {projectname}.pt.sdc and click open.

## Run Software Flow the Design

1.	Click Synthesis under the dashboard for start software flow.

2.	After the generated bitstream files, open programmer from tools toolbar. Connect Xyloni with USB to your computer and click refresh. Device will be connect automatically.Then on image menu, click ‘select image file’ and select {projectname}.bit file. Programming mode will be JTAG and JTAG options will be default. Click start program. You can check programming process from console.  
![This is a alt text.](/image/lab2/4.png "This is a sample image.")

## Opening the SDK Project with Efinity RISC-V IDE

1.	Open Efinity RISC-V IDE program. Click browse and select project folder as C:/Efinity/Embedded/Lab2/embedded_sw. Click Launch.
2.	From project explorer click import project. Efinix Projects > Efinix Makefile Project> BSP location  and click browse ,embedded_sw > lab2 and select bsp folder then click next. Select ‘apb3Demo’ and finish.  
![This is a alt text.](/image/lab2/5.png "This is a sample image.")
3.	Open main.c file in src folder and  add these codes to line 63 and 64.  

        cfg0.lfsr_stop = 0;  
        apb3_ctrl_write(APB0, &cfg0);
4.	Add while loop to line 61-75 and codes always be in loop. Main is shown be like this : 
![This is a alt text.](/image/lab2/6.png "This is a sample image.")  

5.	Expand  src folder and open main.c file. This is our main code. You can build your code with CTRL+B. If there is not exist error , our code is correct.
6.	Open terminal and select Serial Terminal on choose terminal menu.  
Terminal settings :

        Serial Port = Serial port is the defined communication port on your computer.  
        Baud Rate = 115200  
        Data Size = 8  
        Parity = None  
        Stop bits = 1  
        Encoding = Default  

5.	Click run button and select run configuration.  
![This is a alt text.](/image/lab2/12.png "This is a sample image.")
6.	In the open window expand  GBD OpenOCD Debugging and select apb3Demo_trion and click Run. Program will be running. 
7.	Terminal output must be like :  
![This is a alt text.](/image/lab2/7.png "This is a sample image.")


# 
# 
