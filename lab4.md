# Use Efinity to build an Embedded System

After completing this lab, you will be able to:  
    
- Add additional IP to a hardware design
- Setup some of the compiler settings

# Steps
## Copy Lab3 Project as Lab4
 
1. Open your previous lab folder.
2. Copy your ‘lab3’ project and paste as lab4. 
3. Open Efinity by selecting Start > Efinity 2022.2 > Efinity 2022.2
4. Click Open Project from File > Open Project and search lab4 project location.
5. Select lab1.xml file in lab4 folder. Click open.  
![](https://imgur.com/9NX2CY6.png)

## Run Software Flow the Design

1. Click Synthesis under the dashboard for start software flow.

2. After the generated bitstream files, open programmer from tools toolbar. Connect Xyloni with USB to your computer and click refresh. Device will be connect automatically.Then on image menu, click ‘select image file’ and select {projectname}.bit file. Programming mode will be JTAG and JTAG options will be default. Click start program. You can check programming process from console.    
![](https://imgur.com/qLU61Ey.png)

## Opening the SDK Project with Efinity RISC-V IDE

1.	Open Efinity RISC-V IDE program. Click browse and select project folder as C:/Efinity/Embedded/Lab4/embedded_sw. Click Launch.
2.	From project explorer click import project. Efinix Projects > Efinix Makefile Project> BSP location  and click browse ,embedded_sw > lab4 and select bsp folder then click next. Select ‘apb3Demo’ and finish.    
![](https://imgur.com/OktbMGE.png)
3.	Open main.c file in src folder and  add these codes to line 43 and 52.  

        // Led Address Offset (R/W)
        #define LED_1 		0x1
        #define LED_2		0x2
        #define LED_3		0x3
        #define LED_4		0x4
        // Button Address Offset (R/W)
        #define BTN_1 		0x1
        #define BTN_2 		0x2
        #define BTN_REG 		0x4
        #define LED_REG 		0x0

4. Turn comment lines void error_state function.
5. Turn comment lines all codes in main function.  
6. Add these codes to main function.

        bsp_init();
                        uint8_t dat;
                        bsp_printf("LEDS OFF\r\n");
                        while(1){
                                while(uart_readOccupancy(BSP_UART_TERMINAL)){
                                        dat=uart_read(BSP_UART_TERMINAL);
                                        if(dat==0x30){
                                                write_u32(0x0,IO_APB_SLAVE_0_INPUT + LED_REG);
                                                bsp_uDelay(5000);
                                                bsp_printf("LEDS OFF\r\n");}
                                        if(dat==0x31){
                                                write_u32(0x1,IO_APB_SLAVE_0_INPUT + LED_REG);
                                                bsp_uDelay(5000);
                                                bsp_printf("LED1 ON\r\n");}
                                        if(dat==0x32){
                                                write_u32(0x2,IO_APB_SLAVE_0_INPUT + LED_REG);
                                                bsp_uDelay(5000);
                                                bsp_printf("LED2 ON\r\n");}
                                        if(dat==0x33){
                                                write_u32(0x4,IO_APB_SLAVE_0_INPUT + LED_REG);
                                                bsp_uDelay(5000);
                                                bsp_printf("LED3 ON\r\n");}
                                        if(dat==0x34){
                                                write_u32(0x8,IO_APB_SLAVE_0_INPUT + LED_REG);
                                                bsp_uDelay(5000);
                                                bsp_printf("LED4 ON\r\n");}
                                        }
                                }

    
After this step main codes should be shown like this :    
![](https://imgur.com/dBqMBCU.png)   
7. Open terminal and select Serial Terminal on choose terminal menu.  
Terminal settings :

        Serial Port = Serial port is the defined communication port on your computer.  
        Baud Rate = 115200  
        Data Size = 8  
        Parity = None  
        Stop bits = 1  
        Encoding = Default  

5.	Click run button and select run configuration.  
![](https://imgur.com/MqpN59c.png)
6.	In the open window expand  GBD OpenOCD Debugging and select apb3Demo_trion and click Run. Program will be running. 
7. You can control the leds with 1-2-3-4 numbers in the keyboard. Terminal output must be like :  
![This is a alt text.](/image/lab4/1.png "This is a sample image.")


# 
# 
