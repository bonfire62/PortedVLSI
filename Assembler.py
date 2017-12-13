import os
import re


##########################################################################
#     ASSEMBLER FOR FPGA CORE
#     Created by Ken Bonar
#
#     To test functions, run with input as "test".
#     See test.txt for the tested commands.


#TODO finish debugging instruction set

# helper function for COE formatting
def end_line(a):
    return a + ",\n"


# helper error printer
def error_print(x, y):
    print("input error, value at line: {} word: {}".format(x, y))


assembly_input_file = input("Input name of text file (without extension): ")
mem_radix = input("Input initialization memory radix:")
init_vector = input("Input initilization vector:")
s = ""

s += "memory_initialization_radix= {};\n".format(mem_radix)
s += "memory_initialization_vector={}\n".format(init_vector)

#TODO add a last line check to remove comma and use semicolon
instructions = {"add", "addi", "sub", "load", "store", "seq", "slt", "beq", "j", "jal", "shr", "shl", "nan", "loadi"}
coe_count = 0
coe_dict = {}
try:
    with open(assembly_input_file + ".txt") as file:
        for count, line in enumerate(file):
            content = line.split()
            if content.__len__() > 0:
                m = re.match('[a-z]+(:)', content[0])
                if m:
                    #print(m.string)
                    coe_dict[m.string] = coe_count

                elif content[0] == 'load':
                    coe_count += 2

                elif content[0] == 'store':
                    coe_count += 2

                # checks for any instruction
                elif content[0] in instructions:
                    coe_count += 1

    file.close()

    with open(assembly_input_file + ".txt") as file:
        for count, line in enumerate(file):
            content = line.split()
            if content.__len__() > 0:

                ########### add is 0000 - 4 bits dest - 4 bits source 1 - 4 bits source 2

                if content[0].lower() == "add":
                    s += '0000'
                    # argument 1 check
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[1], 16))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    # argument 2 check
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[2], 16))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break
                    if (int(content[3], 16) <= int('0xf', 16)):
                        s += end_line("{:0>4b}".format(int(content[3], 16)))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break

                ########### addi is 0001 - 4 bits dest - 4 bits source 1 - 4 bits source 2 (immediate)

                elif content[0].lower() == "addi":
                    s += "0001"
                    # argument 1 check
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[1], 16))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    # argument 2 check
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[2], 16))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break
                    if (int(content[3], 16) <= int('0xf', 16)):
                        s += end_line("{:0>4b}".format(int(content[3], 16)))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break

                ########### sub is 0010 - 4 bits dest - 4 bits source 1 - 4 bits source 2

                elif content[0].lower() == "sub":
                    s += '0010'
                    # argument 1 check
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[1], 16))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    # argument 2 check
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[2], 16))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break

                    if (int(content[3], 16) <= int('0xf', 16)):
                        s += end_line("{:0>4b}".format(int(content[3], 16)))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break


                ########### load is 0011 - 4 bits dest - 4 bits source 1 - 4 bits source 2 (immediate)

                elif content[0].lower() == "load":
                    s += '0011'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[1], 16))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break

                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += end_line("{:0<8b}".format(int(content[2], 16)))
                        s += end_line(str("0000000000000000"))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break


                ########### store is 0100 - 4 bits reg - 8 bits junk - 16 bits mem location

                elif content[0].lower() == "store":
                    s += '0100'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break

                    if (int(content[2], 16) <= int('0xff', 16)):
                        s += end_line("{:0>8b}".format(int(content[2], 16)))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break

                    if (int(content[3], 16) <= int('0xffff', 16)):
                        s += end_line(str("{:0>16b}".format(int(content[3], 16))))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break

                ########### Set Equal is 0101 - 4 bits dest - 4 bits source - 4 bits source

                elif content[0].lower() == "seq":
                    s += '0101'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break

                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[2], 16))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break

                    if (int(content[3], 16) <= int('0xf', 16)):
                        s += end_line(str("{:0>4b}".format(int(content[3], 16))))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break


                ########### Set Less Than is 0110 - 4 bits dest - 4 bits source - 4 bits source

                elif content[0].lower() == "slt":
                    s += '0110'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[2], 16))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break
                    if (int(content[3], 16) <= int('0xf', 16)):
                        s += end_line(str("{:0>4b}".format(int(content[3], 16))))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break

                ########### Branch on equal is 0111 - 4 bits dest - 4 bits source - label
                elif content[0].lower() == "beq":
                    s += '0111'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[2], 16))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break
                    s+= end_line('0000')
                    if type(content[3]) == str:
                        a = coe_dict.get(content[3])
                        try:
                            s += end_line(str("{:0>16b}".format(int(str(coe_dict[content[3] + ':'])))))
                        except KeyError:
                            print("Label not found in program: line {}".format(count))
                            break
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break

                ########### Jump is 1000 - label

                elif content[0].lower() == "j":
                    s += '1000'
                    if type(content[1]) == str:
                        try:
                            s += end_line(str("{:0>12b}".format(int(str(coe_dict[content[1] + ':'])))))
                        except KeyError:
                            print("Label not found in program: line {}".format(count))
                            break
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break

                ########### Jump and link is 1001 - label

                elif content[0].lower() == "jal":
                    s += '1001'
                    if type(content[1]) == str:
                        s += end_line(str("{:0>12b}".format(int(str(coe_dict[content[1] + ':'])))))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break

                ########### Shift Right is 1010 - 4 bits dest - 4 bits source - amount

                elif content[0].lower() == "shr":
                    s += '1010'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[2], 16))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break
                    if (int(content[3], 16) <= int('0xf', 16)):
                        s += end_line(str("{:0>4b}".format(int(content[3], 16))))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break

                ########### Shift Left is 1011 - 4 bits dest - 4 bits source - amount

                elif content[0].lower() == "shl":
                    s += '1011'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += "{:0>4b}".format(int(content[2], 16))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break
                    if (int(content[3], 16) <= int('0xf', 16)):
                        s += end_line(str("{:0>4b}".format(int(content[3], 16))))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break

                ########### Nand is 1100 - 4 bits dest - 4 bits source - 4 bits source2

                elif content[0].lower() == "nan":
                    s += '1100'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[2], 16)))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break
                    if (int(content[3], 16) <= int('0xf', 16)):
                        s += end_line(str("{:0>4b}".format(int(content[3], 16))))
                    else:
                        error_print(count, content[3])
                        os.system('pause')
                        break

                ########### Load Immediate is 1101 - 4 bits dest, immediate

                elif content[0].lower() == "loadi":
                    s += '1011'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    if (int(content[2], 16) <= int('0xff', 16)):
                        s += end_line("{:0>8b}".format(int(content[2], 16)))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break


                ########## Write is 1110  - 4 bits source register - 4 bits register containing address

                elif content[0].lower() == "wr":
                    s += '1110'
                    if (int(content[1], 16) <= int('0xf', 16)):
                        s += str("{:0>4b}".format(int(content[1], 16)))
                    else:
                        error_print(count, content[1])
                        os.system('pause')
                        break
                    if (int(content[2], 16) <= int('0xf', 16)):
                        s += end_line("{:0>4b}".format(int(content[2], 16)))
                    else:
                        error_print(count, content[2])
                        os.system('pause')
                        break
                    s += '0000'

                # else if label, skip adding to coe
                elif (content[0] is not '\n' and not None):
                    m = re.match('[a-z]+(:)', content[0])
                    if m:
                        continue
                else:
                    print("nonvalid operation recieved")

            else:
                continue
        s = s[:-2]
        s +=';'
except FileNotFoundError:
    print("Incorrect file name entered!")
    input("")


output = open('output.coe', 'w+')
with output as file:
    file.write(s)
