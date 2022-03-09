# Max10 Remote Update
 Max 10 Remote Update through System Console

This design is created in Quartus 21.1 Standard Edition. You will need to recompile the design using RemoteUpdate.qar and convert the programming file using InternalConfig.cof.

Below is the guide on how to run the demo using System Console.
1. Run System Console
2. Execute "source Max10_RSU_v2.tcl"

![alt text](https://github.com/intel-fpga-ceg/Max10-RemoteUpdate/blob/main/image/console.jpg)

| Button                  | Description                                                                                                                                                           |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Check RSU Busy          | To check if the RSU IP is busy or ready for next step                                                                                                                 |
| Read Watchdog           | Read the watchdog timer and display how much time left                                                                                                                |
| Select Image 1          | Select Image 1 for reconfiguration. Soft BOOT_SEL Setting                                                                                                             |
| Select Image 2          | Select Image 2 for reconfiguration. Soft BOOT_SEL Setting                                                                                                             |
| Trigger Reconfiguration | Performed reconfiguration on the image selected                                                                                                                       |
| Read System ID          | Read design ID information in order to confirm which design is loaded                                                                                                 |
| Read Flash Status       | Read the on chip flash status to understand what is the current status of the flash function. Please refer to “On Chip Flash” IP on how to interpret the read value   |
| UFM1 Erase              | Erase UFM1 Sector                                                                                                                                                     |
| UFM0 Erase              | Erase UFM0 Sector                                                                                                                                                     |
| CFM2 Erase              | Erase CFM2 Sector                                                                                                                                                     |
| CFM1 Erase              | Erase CFM1 Sector                                                                                                                                                     |
| CFM0 Erase              | Erase CFM0 Sector                                                                                                                                                     |
| Read Data               | Read the data based on the “Flash Address” location and display in “Flash Data”                                                                                       |
| Write Data              | Write “Flash Data” into the “Flash Address” location of the “On Chip Flash” IP                                                                                        |
| Select File             | Select which rpd file to be use to configure into the On Chip Flash                                                                                                   |
| Start Image1 Configure  | Performed erase of the data in Image1 and write the new image into the location based on the selected rpd file                                                        |
| Start Image2 Configure  | Performed erase of the data in Image2 and write the new image into the location based on the selected rpd file                                                        |
