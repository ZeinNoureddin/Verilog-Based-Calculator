`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 01:15:17 PM
// Design Name: 
// Module Name: mux_4x1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_4x1(input [1:0] a, [3:0] num1ones, [3:0] num1tens, [3:0] num2ones, [3:0] num2tens, output reg [3:0] x);

    always@(*)begin
        case(a)
             0: x = num1ones;
             1: x = num1tens;
             2: x = num2ones;
             3: x = num2tens;
        endcase
    end
    
endmodule
