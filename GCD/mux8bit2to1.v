module mux8bit2to1(a,b,s,out);
input [7:0]a,b;
input s;
output [7:0]out;
assign out = s?b:a;
endmodule
