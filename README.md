# Embedded System Design Flow 


# Course Description
 
###### 
The purpose of the lab exercises of Embedded System Design Flow on Sapphire is to walk you through a complete hardware and software processor system design. Each lab will build upon the previous lab.

The labs have been developed on a PC running Microsoft Windows 10 and using Efinity 2022.2 version tools. 


#	Setup Source Files
## In the instructions for the labs;
{sources} refers to C/Efinity/Embedded/sources. You can download the source files for the labs from the cloned sources directory

{labs} refers to C/Efinity/Embedded/labs. It assumes that you will create the mentioned directory structure to carry out the labs of this workshop


# Setup hardware
Connect Xyloni 

 The Xyloni Development Board, development board has a FTDI FT4232H chip to communicate with the USB port. This chip has separate channels that the board uses for the SPI, JTAG, and UART interfaces. You need to install a driver for each interface, and then each interface appears as a unique FTDI device.

 On Windows, you use software from Zadig to install drivers (zadig.akeo.ie). 

 The Zadig software includes a variety of drivers. When programming Efinix FPGAs, use one of these drivers

    1. libusb-win32 (version)—This driver is more stable for unplugplug events. This         driver does not work when debugging with OpenOCD.
    2.libusbK (version)—Use this driver if you plan to use OpenOCD to debug any Efinix         RISC-V SoC.


# Lab Descriptions

## Lab 1 

In this lab, you will use IP Integrator to create a processing system based design consisting of the following :
- RISC-V core
- UART for serial communication   
![](https://imgur.com/WjveQYw.png)

## Lab 2  

This lab guides you through the process of creating and adding a custom peripheral to a processor system. You will create an apb3_slave interface peripheral.    

![](https://imgur.com/cSTrFAK.png)

## Lab 3

This lab guides you through the process of creating and adding a custom peripheral to a processor system. You will create an apb3_slave interface peripheral. You will extend the Lab 2 hardware design by creating and adding an apb3 peripheral to the system, and connecting it to the LEDs on the Xyloni board you are using. Next, you will connect the peripheral to the system and add pin location constraints to connect the LED display controller peripheral to the on-board LED display.      
![](https://imgur.com/Dx9W0Xx.png)

## Lab 4

This lab guides you through the process of writing a basic software application. The software you will develop will write to the LEDs on the Xyloni board. You will verify that the design operates as expected, by testing in hardware.          
![](https://imgur.com/iR9QS6R.png)

## Lab 5

This lab guides you through the process of creating and adding a custom peripheral to a processor system. You will create an axi4_lite interface peripheral. You will writing a basic software application. You will verify that the design operates as expected, by testing in hardware.    
![](https://imgur.com/dFYaUDD.png)

## Lab 6

This lab guides you through the process of using Efinity and IP Integrator to create a complete Sapphire RISC-V based processor system targeting either the Xyloni board. You will use the Block Design feature of IP Integrator to configure the PS and add IP to create the hardware system, and SDK to create an application to verify the design functionality.   
![](https://imgur.com/sIcwjVp.png)

## Lab 7

Software and hardware interact with each other in an embedded system. The Hardware Debugger tool has different types of cores that allow hardware debugging by providing access to internal signals without requiring the signals to be connected to package pins. These hardware debug cores may reside in the programmable logic (PL) portion of the device and can be configured with several modes that can monitor signals within the design.   
![](https://imgur.com/JsyOxKS.png)

## 
## 
