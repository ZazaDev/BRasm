# Simple MIPS code for generating a 512x512 Brazil flag bitmap made with the MARS 4.5 software
# HOWTO:
# Turn on pseudo-instructions, connect the bitmap display (Tools -> Bitmap Display) and run the code!
# Bitmap display settings:
# unit width/height: 32
# display width: 512
# display height: 512
# base address for display: 0x1001000 (static data)

.data
display: .space 1024

.text
li $t0, 0x009739
li $t1, 0

# Green background
loop:
  sw $t0, display($t1)
  addi $t1, $t1, 4
  beq $t1, 1024, resetCounter
  j loop

resetCounter:
  li $t0, 0xFEDD00
  addi $t2, $zero, 2
  addi $t3, $zero, 12
  addi $t7, $zero, 2
  addi $t1, $zero, 92
  j loop2

# Yellow rhombus
loop2:
  sw $t0, display($t1)
  addi $t1, $t1, 4
  addi $t2, $t2, -1
  beqz $t2, vemComPix
  beq $t1, 1024, exit #should never occur, fail safe tho :ok_hand:
  j loop2

vemComPix:
# when $t3 is equal to 60 it hits the border, so check that and
# call reverse function
  beq $t3, 60, fazOPix
  add $t1, $t1, 64
  sub $t1, $t1, $t3
  addi $t3, $t3, 8
  addi $t7, $t7, 2
  or $t2, $t2, $t7
  j loop2


fazOPix:
  beq $t1, 868, circle
  add $t1, $t1, 64
  addi $t3, $t3, -8
  sub $t1, $t1, $t3
  addi $t7, $t7, -2
  or $t2, $t2, $t7
  j loop3


loop3:
  sw $t0, display($t1)
  addi $t1, $t1, 4
  addi $t2, $t2, -1
  beqz $t2, fazOPix
  beq $t1, 1024, exit #again, safe-guard
  j loop3


# Drawing the inner circle
circle:
  li $t0, 0x012169
  addi $t1, $zero, 284
  addi $t2, $zero, 2
  addi $t3, $zero, 12
  addi $t7, $zero, 2
  j loop4

circlePix:
  beq $t3, 36, circlePix2
  add $t1, $t1, 64
  sub $t1, $t1, $t3
  addi $t3, $t3, 8
  addi $t7, $t7, 2
  or $t2, $t2, $t7
  j loop4


circlePix2:
  nop
  beq $t1, 676, faixa
  add $t1, $t1, 64
  addi $t3, $t3, -8
  sub $t1, $t1, $t3
  addi $t7, $t7, -2
  or $t2, $t2, $t7
  j loop5
  

loop4:
  sw $t0, display($t1)
  addi $t1, $t1, 4
  addi $t2, $t2, -1
  beqz $t2, circlePix
  beq $t1, 1024, exit
  j loop4

loop5:
  sw $t0, display($t1)
  addi $t1, $t1, 4
  addi $t2, $t2, -1
  beqz $t2, circlePix2
  beq $t1, 1024, exit
  j loop5

# Drawing the white strip
faixa:
  li $t0, 0xFFFFFF
  addi $t1, $zero, 404
  sw $t0, display($t1)
  addi $t1, $t1, 4
  sw $t0, display($t1)
  addi $t1, $t1, 4
  sw $t0, display($t1)
  addi $t1, $t1, 68
  sw $t0, display($t1)
  addi $t1, $t1, 4
  sw $t0, display($t1)
  addi $t1, $t1, 68
  sw $t0, display($t1)
  j exit

exit:
  li $v0, 10
  syscall
