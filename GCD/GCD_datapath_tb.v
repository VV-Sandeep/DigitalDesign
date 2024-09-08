module GCD_datapath_tb();
reg [7:0]a,b;
reg clk,rst,asel,bsel,aload,bload,out_en;
wire gt,lt,eq;
wire [7:0]out;
GCD_datapath A1(a,b,clk,rst,asel,bsel,aload,bload,out_en,gt,lt,eq,out);
initial clk = 0;
always #5 clk = ~clk;
initial
begin
rst = 1; out_en = 1'b0; a = 8'b00001000; b = 8'b00001100;
#12 rst = 0;
#2 asel = 1'b1;
bsel = 1'b1;
aload = 1'b1;
bload = 1'b1;
#18 out_en = 1'b1; 
#6 out_en = 1'b0;
#5 asel = 1'b0;
bsel = 1'b0;
aload = 1'b0;
bload = 1'b1;
#2 out_en = 1'b1;
#25 $finish;
end
endmodule
