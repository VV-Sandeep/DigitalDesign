module cordic_tb;
parameter width = 16;
reg [width-1:0] xin, yin;
reg [31:0] angle;
reg clk;
wire [width-1:0] cosine, sine;
cordic dut(clk, cosine, sine, xin, yin, angle);
initial clk = 0;
always #4 clk = ~clk;
initial 
begin  
    angle = 32'h2000_0000; //45
    xin = 32000/1.647;     
    yin = 0;
    #200 angle = 32'h4000_0000; //90
    #200 angle = 32'h6aaa_aaaa; // 150
    #200 angle = 32'ha38e_38e3; //230
    #200 angle = 32'he000_0000; //315
    // example: 45 deg = 45/360 * 2^32 = 32'b00100000000000000000000000000000 = 45.000 degrees -> atan(2^0)
    // sine = 32000*sin(angle)
    // cosine = 32000*cos(angle)
   #500 $finish;
end
endmodule
