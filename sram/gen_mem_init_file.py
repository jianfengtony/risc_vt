# -*- coding: UTF-8 -*-


try:
    mem_init_file = open('mem_init.hex', 'w')


    for i in range(0, 1024):

        line = str(hex(i)).split('x', 1)[1] + '\n'
        mem_init_file.write(line)


    mem_init_file.close()
except:
    print('Open file <mem_init.hex> failed!')