module comparator8bit(a,b,gt,lt,eq);
input [7:0]a,b;
output gt,lt,eq;
assign gt = (a>b)?1:0;
assign lt = (a<b)?1:0;
assign eq = (a==b)?1:0;
endmodule
