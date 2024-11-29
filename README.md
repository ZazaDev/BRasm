# BRasm
A simple program in MIPS assembly that generates a (very ugly) 512x512 Brazil flag bitmap.
![image](https://github.com/user-attachments/assets/e8146e88-94ce-4755-aa4f-95b5a68b12b5)
# Running the code
Using the MARS 4.5 software, open the file and connect the Bitmap Display to MIPS (Tools -> Bitmap Display). Make sure extended instructions are allowed and that you're using the correct display settings:
- Unit Width in Pixels: 32
- Unit Height in Pixels: 32
- Display Width in Pixels: 512
- Display Height in Pixels: 512
- Base address for display: 0x10010000 (static data)
