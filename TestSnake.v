`timescale 1ns / 1ps

module screenAndMapping_TEST(clk,Py1,Py2,Py3,Py4,Px1,Px2,Px3,Px4);
    input clk;
    output [5:0] Py1,Py2,Py3,Py4,Px1,Px2,Px3,Px4;
    reg [5:0] PPx1, PPx2, PPx3, PPx4;
    wire FPS;
    clkFPS s10 (clk, FPS);
    initial begin
        PPx1 = 6'd0;
        PPx2 = 6'd1;
        PPx3 = 6'd2;
        PPx4 = 6'd3;
    end
    assign Py1 = 6'd20;
    assign Py2 = 6'd20;
    assign Py3 = 6'd20;
    assign Py4 = 6'd20;
    assign Px1 = PPx1;
    assign Px2 = PPx2;
    assign Px3 = PPx3;
    assign Px4 = PPx4;
    always@( posedge FPS) begin
        PPx1 <= PPx1+1;
        PPx2 <= PPx2+1;
        PPx3 <= PPx3+1;
        PPx4 <= PPx4+1;
    end
    
endmodule
