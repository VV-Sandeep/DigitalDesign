module GCD_datapath(a,b,clk,rst,asel,bsel,aload,bload,out_en,gt,lt,eq,out);
input [7:0]a,b;
input clk,rst,asel,bsel,aload,bload,out_en;
output gt,lt,eq;
output [7:0]out;
wire [7:0]x1,x2,y1,y2,z1,z2;
subtractor8bit A1(z1,z2,x1);
subtractor8bit A2(z2,z1,x2);
mux8bit2to1 A3(x1,a,asel,y1);
mux8bit2to1 A4(x2,b,bsel,y2);
register8bit A5(clk,rst,aload,y1,z1);
register8bit A6(clk,rst,bload,y2,z2);
register8bit A7(clk,rst,out_en,z1,out);
comparator8bit A8(z1,z2,gt,lt,eq);
endmodule
