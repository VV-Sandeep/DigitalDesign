module GCD(clk,rst,go,a,b,out);
input clk,rst,go;
input [7:0]a,b;
output [7:0]out;
wire asel,bsel,aload,bload,out_en,gt,lt,eq;
GCD_datapaths A1(a,b,clk,rst,asel,bsel,aload,bload,out_en,gt,lt,eq,out);
GCD_controlpath A2(clk,rst,go,gt,lt,eq,asel,bsel,aload,bload,out_en);
endmodule
