`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 01:14:20 PM
// Design Name: 
// Module Name: main
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


module main(input clk, b1, b2, b3, b4, b5, b6, b7, b8, b9, rst, output [0:7] seg, [3:0] ano);

    wire isNeg;
    wire display_clk;
    wire [1:0] countOut;
    reg [13:0] result;
    wire [3:0] disNum1Ones, disNum1Tens, disNum2Ones, disNum2Tens;
    reg [3:0] num1Ones = 0, num1Tens = 0, num2Ones = 0, num2Tens = 0;
    wire [3:0] currentDigit;
    reg [2:0]  sel;
    
    clockDivider # (250000) displayClock (clk, rst , display_clk);

    counter #(2,4) count(display_clk, rst, 1, countOut); 
    
    // to know whether the number is negative or positive in order to display the negative sign
    assign isNeg = ( ((num1Tens*10 + num1Ones) < (num2Tens*10 + num2Ones)) && (sel == 2));
    
    // disNums will be either the result after an operation or the original numbers
    assign disNum1Ones = (sel != 0 ) ? ((result/100)%10) : num1Ones;
    assign disNum1Tens = (sel != 0 ) ? ((result/1000)%10) : num1Tens;
    assign disNum2Ones = (sel != 0 ) ? ((result)%10) : num2Ones;
    assign disNum2Tens = (sel != 0 ) ? ((result/10)%10) : num2Tens; 
    
    mux_4x1 m4(countOut, disNum1Ones, disNum1Tens, disNum2Ones, disNum2Tens, currentDigit);
        
    sevSegDisplay display(countOut, currentDigit, isNeg, sel, seg, ano);
    
    // incrementation
    always@(posedge b1) begin
        num1Tens = num1Tens + 1;
        if (num1Tens == 10) num1Tens = 0;
    end
    always@(posedge b2) begin
        num1Ones = num1Ones + 1;
        if (num1Ones == 10) num1Ones = 0;
    end
    always@(posedge b3) begin
        num2Tens = num2Tens + 1;
        if (num2Tens == 10) num2Tens = 0;
    end
    always@(posedge b4) begin
        num2Ones = num2Ones + 1;
        if (num2Ones == 10) num2Ones = 0;
    end
    
    // the operations (+, -, *, /)
    always@(*) begin 
    
        if (b5) begin
            result = (num1Tens*10 + num1Ones) + (num2Tens*10 + num2Ones);
        end
        
        else if (b7) begin
             result = (num1Tens*10 + num1Ones) * (num2Tens*10 + num2Ones);
        end
        
        else if (b6) begin
            result = (num1Tens*10 + num1Ones) - (num2Tens*10 + num2Ones);
            if ( ((num1Tens*10 + num1Ones) - (num2Tens*10 + num2Ones) ) > 9999 ) begin 
                result = result*(-1);
            end
        end
        
        
        else if (b8) begin
            if( ((num1Tens*10 + num1Ones)%(num2Tens*10 + num2Ones)) >= ((num2Tens*10 + num2Ones)/2))
                result = ((num1Tens*10 + num1Ones) / (num2Tens*10 + num2Ones) + 1);
            else 
                result = (num1Tens*10 + num1Ones) / (num2Tens*10 + num2Ones);
        end
            
    end

    // choosing the value for sel
    always@(*) begin
        if (b1 || b2 || b3 || b4 || b9) begin 
            sel = 0; 
        end
        else if (b5 || b6 || b7 || b8) begin 
            if (b5)
                sel = 1; 
            else if (b6)
                sel = 2; 
            else if (b7)
                sel = 3;
            else if (b8)
                sel = 4; 
                 
        end  
    end
  
endmodule
