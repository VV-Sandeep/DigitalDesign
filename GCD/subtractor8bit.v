module subtractor8bit(a,b,out,borrow);
input [7:0]a,b;
output [7:0]out;
output borrow;
assign {borrow,out} = a - b;
endmodule
