`timescale 1ns / 1ps
`define  sCol  12'h0F0;
`define  bCol  12'hFFF;
module Snake_1(clk, Py1, Py2, Py3, Py4, Px1, Px2, Px3, Px4, hIndex,vIndex,color);
    input clk;
    input [5:0] hIndex, vIndex;
    input [5:0] Py1, Py2, Py3, Py4, Px1, Px2, Px3, Px4;
    output [11:0] color;
    wire clkFPS, clk25MHz;
    integer i,j;
    reg [63:0] screen [48:0];
    reg [11:0] colorReg;
    clkFPS s6 (clk, clkFPS);
    clk4th s7 (clk, clk25MHz);

    //Refreshes the screen and places the snake 
    always@(posedge clkFPS) begin
        for (i=0; i<48; i=i+1) begin
            screen[i] <= 63'd0;
        end
        screen[Py1][Px1] <= 1'b1;
        screen[Py2][Px2] <= 1'b1;
        screen[Py3][Px3] <= 1'b1;
        screen[Py4][Px4] <= 1'b1;
//        for (i=0; i<48; i=i+1) begin
//            for (j=0; j<64; j=j+1) begin
//                screen[i][j] <= (i == Py1 && j == Px1) || 
//                                (i == Py2 && j == Px2) ||
//                                (i == Py3 && j == Px3) ||
//                                (i == Py4 && j == Px4);
//            end
//        end
    end
    //maps the screen to the output
    assign color = colorReg;
    always@(posedge clk25MHz) begin
        if((vIndex == Py1 && hIndex == Px1) || (vIndex == Py2 && hIndex == Px2) || (vIndex == Py3 && hIndex == Px3) || (vIndex == Py4 && hIndex == Px4)) begin
            colorReg <= `sCol;
        end else
            colorReg <= `bCol;
    end
endmodule

module clkFPS (clk, clkFPS);
    input clk; 
    output reg clkFPS;
    reg [24:0] count=0;
    initial
        clkFPS=0;
    
    always@(posedge clk) begin
        if (count == 25'd10000000) begin
            clkFPS = ~clkFPS;
            count <= 0;
        end else
            count <= count + 1;
    end
endmodule