#!/bin/bash

testbentch_module=$2
testbentch_file="$testbentch_module.v"


case $1 in

"clean") 
    rm -rf *.vvp *.vcd
    ;;

"compile") 
    iverilog -o "$testbentch_module.vvp" $testbentch_file
    ;;

"run")
    vvp $testbentch_module.vvp
    ;;

"show")
    gtkwave $testbentch_module.vcd
    ;;

"all")
    rm -rf *.vvp *.vcd
    iverilog -o $testbentch_module.vvp $testbentch_file && vvp $testbentch_module.vvp && gtkwave $testbentch_module.vcd
    ;;
*)
    echo "Wrong parameter!"

esac
