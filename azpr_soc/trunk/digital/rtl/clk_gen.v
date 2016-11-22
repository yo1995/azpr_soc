`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

module clk_gen (
	/********** クロック & リセット **********/
	input wire	clk_ref,   // 基底クロック
	input wire	reset_sw,  // リセットスイッチ
	/********** 生成クロック **********/
	output wire clk,	   // クロック
	output wire clk_,	   // 反転クロック
	/********** チップリセット **********/
	output wire chip_reset // チップリセット
);

	/********** 内部信号 **********/
	wire		locked;	   // ロック
	wire		dcm_reset; // リセット

	/********** リセットの生成 **********/
	assign dcm_reset  = (reset_sw == `RESET_ENABLE) ? `ENABLE : `DISABLE;
	assign chip_reset = ((reset_sw == `RESET_ENABLE) || (locked == `DISABLE)) ?
							`RESET_ENABLE : `RESET_DISABLE;

	/********** Xilinx DCM (Digitl Clock Manager) **********/
	x_s3e_dcm x_s3e_dcm (
		.CLKIN_IN		 (clk_ref),	  // 基底クロック
		.RST_IN			 (dcm_reset), // DCMリセット
		.CLK0_OUT		 (clk),		  // クロック
		.CLK180_OUT		 (clk_),	  // 反転クロック
		.LOCKED_OUT		 (locked)	  // ロック
   );

endmodule
