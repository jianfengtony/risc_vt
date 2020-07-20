/****************************************************************************
 * sram.v
 ****************************************************************************/

/**
 * Module: sram
 * 
 * 参数化sram
 */
`timescale 1ns / 10ps

module sram 
	#(	
		parameter ADDR_WIDTH	= 10,
		parameter DATA_WIDTH	= 32,
		parameter INIT_FILE 	= "sram_init.hex",
		parameter DELAY_TIME	= 3
	)
	(	
		input							wr, 
		input							cs, 
		input		[ADDR_WIDTH-1 : 0]	addr, 
		input		[DATA_WIDTH-1 : 0]	din, 
		output	reg	[DATA_WIDTH-1 : 0]	dout
	);
	
	reg		[DATA_WIDTH-1 : 0]	mem[0 : 2**ADDR_WIDTH-1];
	
	initial	$readmemh(INIT_FILE, mem);
	
	always @(cs or wr or addr or din)
		if(cs == 1'b1)
		begin
			if(wr == 1'b1)
				#DELAY_TIME mem[addr] <= din;
			else
				#DELAY_TIME dout <= mem[addr];
		end
	
endmodule
