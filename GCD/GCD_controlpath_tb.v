module GCD_controlpath_tb();
reg clk,rst,go,gt,lt,eq;
wire asel,bsel,aload,bload,out_en;
GCD_controlpath dut(clk,rst,go,gt,lt,eq,asel,bsel,aload,bload,out_en);
initial clk = 0;
always #5 clk = ~clk;
initial
begin
    rst = 1'b1; gt = 1;
    #15 rst = 0;
    #12 go = 1'b1;
    #20 lt = 0; gt = 1;
    #13 gt = 0;lt = 1;
    #24 eq = 1;lt = 0; go = 0;
    #50 $finish;
end
endmodule
