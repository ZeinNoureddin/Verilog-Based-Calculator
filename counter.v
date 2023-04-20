`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 01:15:36 PM
// Design Name: 
// Module Name: counter
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


module counter#(parameter x=4,n=9) (input clk, reset, en, output reg [x-1:0] count);

    always@ (posedge clk, posedge reset) begin
        if(reset==1)
            count <= 0;
        else
            if(en==1)
                if(count==n-1)
                    count<=0;
                else
                    count <= count+1;
            else
                count <= count;
    end
    
endmodule
