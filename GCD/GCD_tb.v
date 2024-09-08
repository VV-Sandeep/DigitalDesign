module GCD_TB();
reg clk,rst,go;
reg [7:0]a,b;
wire [7:0]out;
GCD dut(clk,rst,go,a,b,out);
initial clk = 0;
always #5 clk = ~clk;
initial
begin
rst = 1; a = 8'd96; b = 8'd72;go = 1;
#18 rst = 0;
#200 $finish;
end
endmodule
