//****************************************************************************************************  
//*---------------Copyright (c) 2016 C-L-G.FPGA1988.lichangbeiju. All rights reserved-----------------
//
//                   --              It to be define                --
//                   --                    ...                      --
//                   --                    ...                      --
//                   --                    ...                      --
//**************************************************************************************************** 
//File Information
//**************************************************************************************************** 
//File Name      : chip_top.v 
//Project Name   : azpr_soc
//Description    : the digital top of the chip.
//Github Address : github.com/C-L-G/azpr_soc/trunk/ic/digital/rtl/chip.v
//License        : Apache-2.0
//**************************************************************************************************** 
//Version Information
//**************************************************************************************************** 
//Create Date    : 2016-11-22 17:00
//First Author   : lichangbeiju
//Last Modify    : 2016-11-23 14:20
//Last Author    : lichangbeiju
//Version Number : 12 commits 
//**************************************************************************************************** 
//Change History(latest change first)
//yyyy.mm.dd - Author - Your log of change
//**************************************************************************************************** 
//2016.11.23 - lichangbeiju - Change the coding style.
//2016.11.22 - lichangbeiju - Add io port.
//****************************************************************************************************

`timescale 1ns/1ps
`include "cpu.h"
`include "global_config.h"
`include "stddef.h"
module gpr(
    input   wire                    clk             ,
    input   wire                    rst_n           ,
    //read port 0
    input   wire    [`RegAddrBus]   rd_addr_0       ,//5    write data   
    output  wire    [`WordDataBus]  rd_data_0       ,//32
    //read port 1
    input   wire    [`RegAddrBus]   rd_addr_1       ,//5    write data   
    output  wire    [`WordDataBus]  rd_data_1       ,//32
    //write port
    input   wire                    we_n            ,//1
    input   wire    [`WordAddrBus]  wr_addr         ,//32
    input   wire    [`WordDataBus]  wr_data          //32
);

    //************************************************************************************************
    // 1.Parameter and constant define
    //************************************************************************************************
    
    
    //************************************************************************************************
    // 2.Register and wire declaration
    //************************************************************************************************
    //------------------------------------------------------------------------------------------------
    // 2.1 the output reg
    //------------------------------------------------------------------------------------------------   

    //------------------------------------------------------------------------------------------------
    // 2.2 the internal variable 
    //------------------------------------------------------------------------------------------------  
    reg     [`WordDataBus]      gpr [`REG_NUM-1:0];
    integer                     i;
    
    
    
    //------------------------------------------------------------------------------------------------
    // 2.x the test logic
    //------------------------------------------------------------------------------------------------

    //************************************************************************************************
    // 3.Main code
    //************************************************************************************************

    //------------------------------------------------------------------------------------------------
    // 3.1 the read logic
    //------------------------------------------------------------------------------------------------
    assign rd_data_0 = ((we_n == `ENABLE_N) && (wr_addr == rd_addr_0)) ? wr_data : gpr[rd_addr_0]; 
    assign rd_data_1 = ((we_n == `ENABLE_N) && (wr_addr == rd_addr_1)) ? wr_data : gpr[rd_addr_1]; 
    
     
    //------------------------------------------------------------------------------------------------
    // 3.2 the write logic
    //------------------------------------------------------------------------------------------------
    
    always @(posedge clk or `RESET_EDGE reset) begin : OWNER_CTRL 
        if(reset == `RESET_ENABLE)
            begin
                for(i=0;i<`REG_NUM;i=i+1) begin : GPR_INIT
                    gpr[i]  <= `WORD_DATA_W'h0;
                end
            end
        else begin
            if(we_n == `ENABLE_N)
                begin
                    gpr[wr_addr] <= wr_data;
                end
        end
    end

    
    //************************************************************************************************
    // 4.Sub module instantiation
    //************************************************************************************************
    //------------------------------------------------------------------------------------------------
    // 4.1 xxxx
    //------------------------------------------------------------------------------------------------    
    
endmodule    
//****************************************************************************************************
//End of Mopdule
//****************************************************************************************************
