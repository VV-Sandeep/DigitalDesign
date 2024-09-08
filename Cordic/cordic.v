module cordic(clock, cosine, sine, xin, yin, angle);
parameter width = 16;
input clock;
input signed [width-1:0] xin,yin; 
input signed [31:0] angle;
output signed [width-1:0] sine, cosine;
  
wire signed [31:0] atan_table [0:30];
                          
assign atan_table[0] = 32'b00100000000000000000000000000000; //atan(2^-i)  i is from 0 to 30
assign atan_table[1] = 32'b00010010111001000000010100011101; 
assign atan_table[2] = 32'b00001001111110110011100001011011; 
assign atan_table[3] = 32'b00000101000100010001000111010100;
assign atan_table[4] = 32'b00000010100010110000110101000011;
assign atan_table[5] = 32'b00000001010001011101011111100001;
assign atan_table[6] = 32'b00000000101000101111011000011110;
assign atan_table[7] = 32'b00000000010100010111110001010101;
assign atan_table[8] = 32'b00000000001010001011111001010011;
assign atan_table[9] = 32'b00000000000101000101111100101110;
assign atan_table[10] = 32'b00000000000010100010111110011000;
assign atan_table[11] = 32'b00000000000001010001011111001100;
assign atan_table[12] = 32'b00000000000000101000101111100110;
assign atan_table[13] = 32'b00000000000000010100010111110011;
assign atan_table[14] = 32'b00000000000000001010001011111001;
assign atan_table[15] = 32'b00000000000000000101000101111100;
assign atan_table[16] = 32'b00000000000000000010100010111110;
assign atan_table[17] = 32'b00000000000000000001010001011111;
assign atan_table[18] = 32'b00000000000000000000101000101111;
assign atan_table[19] = 32'b00000000000000000000010100010111;
assign atan_table[20] = 32'b00000000000000000000001010001011;
assign atan_table[21] = 32'b00000000000000000000000101000101;
assign atan_table[22] = 32'b00000000000000000000000010100010;
assign atan_table[23] = 32'b00000000000000000000000001010001;
assign atan_table[24] = 32'b00000000000000000000000000101000;
assign atan_table[25] = 32'b00000000000000000000000000010100;
assign atan_table[26] = 32'b00000000000000000000000000001010;
assign atan_table[27] = 32'b00000000000000000000000000000101;
assign atan_table[28] = 32'b00000000000000000000000000000010;
assign atan_table[29] = 32'b00000000000000000000000000000001;
assign atan_table[30] = 32'b00000000000000000000000000000000;

reg signed [width-1:0] x [0:width-1];
reg signed [width-1:0] y [0:width-1];
reg signed    [31:0] z [0:width-1];
  
wire [1:0] quadrant;
assign quadrant = angle[31:30];

always @(posedge clock)
begin // make sure the rotation angle is in the -pi/2 to pi/2 range
    case(quadrant)
      2'b00,
      2'b11: // no changes needed for these quadrants
      begin
        x[0] <= xin;
        y[0] <= yin;
        z[0] <= angle;
      end

      2'b01:
      begin
        x[0] <= -yin;
        y[0] <= xin;
        z[0] <= {2'b00,angle[29:0]}; // subtract pi/2 for angle in this quadrant
      end

      2'b10:
      begin
        x[0] <= yin;
        y[0] <= -xin;
        z[0] <= {2'b11,angle[29:0]}; // add pi/2 to angles in this quadrant
      end
    endcase
end

genvar i;
generate
  for (i=0; i < width-1; i=i+1)
  begin
    wire z_sign;
    wire signed [width-1:0] x_shr, y_shr;
    
    assign x_shr = x[i] >>> i; 
    assign y_shr = y[i] >>> i;

    assign z_sign = z[i][31];

    always @(posedge clock)
    begin
      x[i+1] <= z_sign ? x[i] + y_shr : x[i] - y_shr;
      y[i+1] <= z_sign ? y[i] - x_shr : y[i] + x_shr;
      z[i+1] <= z_sign ? z[i] + atan_table[i] : z[i] - atan_table[i];
    end
  end
endgenerate
assign cosine = x[width-1];
assign sine = y[width-1];
endmodule
