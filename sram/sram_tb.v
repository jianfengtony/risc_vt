/****************************************************************************
 * sram_tb.v
 ****************************************************************************/
`include "sram.v"

/**
 * Module: sram_tb
 * 
 * sram模块的测试文件
 */
 
`timescale 1ns / 10ps

module sram_tb;

	parameter ADDR_WIDTH = 10;
	parameter DATA_WIDTH = 32;
	parameter INIT_FILE = "mem_init.hex";
	parameter DELAY_TIME = 3;
	parameter PERI = 10;
	
	reg						cs;
	reg						wr;
	reg	[ADDR_WIDTH-1 : 0]	addr;
	reg	[DATA_WIDTH-1 : 0]	din;
	wire[DATA_WIDTH-1 : 0]	dout;

	integer	i;
	
	sram 
	#(
		.ADDR_WIDTH(ADDR_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.INIT_FILE(INIT_FILE),
		.DELAY_TIME(DELAY_TIME)
	)
	sram_inst
	(
		.cs(cs),
		.wr(wr),
		.addr(addr),
		.din(din),
		.dout(dout)
	);
		
	initial
	begin
		$dumpfile("sram_tb.vcd");
        $dumpvars(0, sram_tb);

		cs		= 'b0;
		wr 		= 'b0;
		addr	= 'd0;
		din		= 'd0;

		// 写数据
		#PERI;
		cs		= 'b1;
		wr 		= 'b1;
		addr	= 'd1;
		din		= 'd11;
		
		#PERI;
		addr	= 'd2;
		din		= 'd22;	

		// 读数据
		#PERI;
		cs		= 'b1;
		wr 		= 'b0;
		addr	= 'd1;

		#PERI;
		addr	= 'd2;

		// 读更多数据
		#PERI;
		wr		= 'b0;
		addr	= 'd100;

		#PERI addr	= 'd1023;

		repeat(1023) #PERI addr = addr - 'd1;
		
		#PERI $finish;

	end
	
endmodule


