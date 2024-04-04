# learn-RotatingFan

![image](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExcTVtcnFub3NqcjN4aDgza3hrdHgyeW5laWhtdzc0cm5kaGNibGkxcyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZTx0n5QpYzMsNqZb1y/giphy.gif)


- During my third semester of studying Electrical and Electronic Engineering, the students were tasked to design a complex project by using Intel 80386 Assembly Language.
- As one of the students, I programmed a Command Line Interface of a Rotating Fan.
- The user will have to insert their current surrounding temperature, the duration of the fans (20, 40, and 60 seconds), and either to pivot the fan or not.

# Instruction
To run the program, simply download `fanptp3.asm` and saved it to your desired folder. Next, download [DOSBox-X](https://dosbox-x.com/). DOSBox-X is the emulator that I used to run the program. Then, open DOSBox-X, change the directory to where you saved `fanptp3.asm`. Lastly, enter these command line in order.
1. `tasm fanptp3.asm`
2. `tlink fanptp3.obj`
3. `fanptp3.exe`
