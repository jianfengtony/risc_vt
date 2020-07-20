/****************************************************************************
 * risc_vt_core_tb.v
 ****************************************************************************/
`include "risc_vt_core.v"

/**
 * Module: risc_vt_core_tb
 * 
 * risc_vt_core模块的测试文件
 */
 
`timescale 1ns / 10ps

module risc_vt_core_tb;

	parameter ADDR_WIDTH = 10;
	parameter DATA_WIDTH = 32;
	parameter DELAY_TIME = 3;
	parameter PERI = 10;
	
    reg                           rst;            // 核心复位信号，同步复位
    reg                           clk;            // 核心工作时钟信号
    // 程序存储器相关信号
    wire                          prog_wr;        // 写命令
    wire                          prog_rd;        // 读命令
    reg                           prog_wr_en;     // 写允许
    reg                           prog_rd_en;     // 读允许
    reg                           prog_dout_rdy;  // 数据输出ready
    wire  [ADDR_WIDTH-1 : 0]      prog_addr;      // 地址
    wire  [DATA_WIDTH-1 : 0]      prog_dout;      // 写数据
    reg   [DATA_WIDTH-1 : 0]      prog_din;       // 读数据
    // 数据存储器相关信号
    wire                          data_wr;        // 写命令
    wire                          data_rd;        // 读命令
    reg                           data_wr_en;     // 写允许
    reg                           data_rd_en;     // 读允许
    reg                           data_dout_rdy;  // 数据输出ready
    wire  [ADDR_WIDTH-1 : 0]      data_addr;      // 地址
    wire  [DATA_WIDTH-1 : 0]      data_dout;      // 写数据
    reg   [DATA_WIDTH-1 : 0]      data_din;       // 读数据

	integer	i;
	
	risc_vt_core 
	#(
		.ADDR_WIDTH(ADDR_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.DELAY_TIME(DELAY_TIME)
	)
	risc_vt_core_inst
	(
		.rst(rst),
		.clk(clk),

		.prog_wr(prog_wr),      
		.prog_rd(prog_rd),      
		.prog_wr_en(prog_wr_en),   
		.prog_rd_en(prog_rd_en),   
		.prog_dout_rdy(prog_dout_rdy),
		.prog_addr(prog_addr),    
		.prog_dout(prog_dout),    
		.prog_din(prog_din),     
		
		.data_wr(data_wr),      
		.data_rd(data_rd),      
		.data_wr_en(data_wr_en),   
		.data_rd_en(data_rd_en),   
		.data_dout_rdy(data_dout_rdy),
		.data_addr(data_addr),    
		.data_dout(data_dout),    
		.data_din(data_din)
	);

	always #(PERI/2) clk = ~clk;
	
	initial
	begin
		$dumpfile("risc_vt_core_tb.vcd");
        $dumpvars(0, risc_vt_core_tb);

		rst 		= 'b0;
		clk			= 'b0;


		// 系统复位
		#PERI rst 	= 'b1;

		#PERI $finish;

	end
	
endmodule


