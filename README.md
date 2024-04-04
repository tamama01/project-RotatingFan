# learn-RotatingFan
<p align="center">
<img width="682" alt="image" src="https://github.com/tamama01/learn-RotatingFan/assets/100755191/4342872a-2e11-424b-b94b-830bf6a04c03">
</p>

- During my third year of studying Electrical and Electronic Engineering, the students were tasked to design a complex project by using Intel 80386 Assembly Language.
- As one of the students, I programmed a Command Line Interface of a Rotating Fan.
- The user will have to insert their current surrounding temperature, the duration of the fans (20, 40, and 60 seconds), and either to pivot the fan or not.

# Instruction
To run the program, simply download `fanptp3.asm` and saved it to your desired folder. Next, download [DOSBox-X](https://dosbox-x.com/). DOSBox-X is the emulator that I used to run the program. Then, open DOSBox-X, change the directory to where you saved `fanptp3.asm`. Lastly, enter these command line in order.
1. `tasm fanptp3.asm`
2. `tlink fanptp3.obj`
3. `fanptp3.exe`
