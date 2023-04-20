`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 01:15:55 PM
// Design Name: 
// Module Name: sevSegDisplay
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

module sevSegDisplay(input [1:0] a, input [3:0] x, input isNeg, input [2:0] sel, output reg [0:7] seg, output reg [3:0] ano);


    always@(*) begin
   
        if (isNeg && (a==1 || a==0) )begin
       
            if(a == 1 && sel != 0) begin
                seg = 8'b11111101;
                ano = 4'b1011;
               
            end
           
            if(a == 1 && sel == 0) begin
                seg = 8'b11111100;
                ano = 4'b1011;
               
            end
           
            if (a == 0) begin
           
                seg = 8'b11111111;
                ano = 4'b0111;
            end
           
        end
       
        else begin
           
             if(sel == 0 && a == 0) begin
                case(x)
                    0:seg=8'b00000010;
                    1:seg=8'b10011110;
                    2:seg=8'b00100100;
                    3:seg=8'b00001100;
                    4:seg=8'b10011000;
                    5:seg=8'b01001000;
                    6:seg=8'b01000000;
                    7:seg=8'b00011110;
                    8:seg=8'b00000000;
                    9:seg=8'b00001000;
                endcase
             end
             
             else begin
                case(x)
                    0:seg=8'b00000011;
                    1:seg=8'b10011111;
                    2:seg=8'b00100101;
                    3:seg=8'b00001101;
                    4:seg=8'b10011001;
                    5:seg=8'b01001001;
                    6:seg=8'b01000001;
                    7:seg=8'b00011111;
                    8:seg=8'b00000001;
                    9:seg=8'b00001001;
                endcase
             end
             
                case(a)
                    1:ano=4'b0111;
                    0:ano=4'b1011;
                    3:ano=4'b1101;
                    2:ano=4'b1110;
                endcase
        end
    end
   
   
endmodule
