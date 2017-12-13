import random

f = open("spiral_test.coe", "w+")
for x in range (1, 983):
    f.write(str("00000000000000000,\n"))


for x in range(1, 38400):
    f.write(str("{0:0^16b}".format(random.randrange(0,65535)).format()) + ",\n")
