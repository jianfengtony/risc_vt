/****************************************************************************
 * risc_vt_core.v
 ****************************************************************************/

/**
 * Module: risc_vt_core
 * 
 * 支持risc-v指令集的CPU核心实现
 * 所有信号遵从正逻辑，即信号电平为1的含义与信号变量名称的含义一致，如rst信号为1代表复位，0代表复位信号无效，系统正常工作
 */
`timescale 1ns / 10ps

module risc_vt_core
    #(	
    parameter   DATA_WIDTH  =   32,
    parameter   ADDR_WIDTH  =   32,
    parameter   DELAY_TIME  =   3
    )
    (	
    input                           rst,            // 核心复位信号，同步复位
    input                           clk,            // 核心工作时钟信号
    // 程序存储器相关信号
    output reg                      prog_wr,        // 写命令
    output reg                      prog_rd,        // 读命令
    input                           prog_wr_en,     // 写允许
    input                           prog_rd_en,     // 读允许
    input                           prog_dout_rdy,  // 数据输出ready
    output reg [ADDR_WIDTH-1 : 0]   prog_addr,      // 地址
    output reg [DATA_WIDTH-1 : 0]   prog_dout,      // 写数据
    input      [DATA_WIDTH-1 : 0]   prog_din,       // 读数据
    // 数据存储器相关信号
    output reg                      data_wr,        // 写命令
    output reg                      data_rd,        // 读命令
    input                           data_wr_en,     // 写允许
    input                           data_rd_en,     // 读允许
    input                           data_dout_rdy,  // 数据输出ready
    output reg [ADDR_WIDTH-1 : 0]   data_addr,      // 地址
    output reg [DATA_WIDTH-1 : 0]   data_dout,      // 写数据
    input      [DATA_WIDTH-1 : 0]   data_din        // 读数据
    );
	
    
    localparam  reg_num =   32;                     // 内部寄存器数量

	integer     i;                                  // 临时变量

    reg [DATA_WIDTH-1 : 0]  reg_x[0 : reg_num-1];   // 内部寄存器组
	reg [DATA_WIDTH-1 : 0]  reg_pc;                 // 程序计数器PC

	always @(posedge clk)
		if(rst == 'b1)
		begin
            for(i=0; i<reg_num; i=i+1)  reg_x[i] <= 'b0; // 寄存器初始化
            reg_pc                               <= 'b0; // 程序计数器初始化
            // 对所有输出信号初始化为0
            prog_wr                              <= 'b0;
            prog_rd                              <= 'b0;
            prog_addr                            <= 'b0;
            prog_dout                            <= 'b0;
            data_wr                              <= 'b0;
            data_rd                              <= 'b0;
            data_addr                            <= 'b0;
            data_dout                            <= 'b0;
		end
        else
        begin
             
        end
	
endmodule
