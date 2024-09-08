module GCD_controlpath(clk,rst,go,gt,lt,eq,asel,bsel,aload,bload,out_en);
input clk,rst,go,gt,lt,eq;
output reg asel,bsel,aload,bload,out_en;
reg [2:0]ps,ns;
parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011;
parameter s4 = 3'b100;
parameter s5 = 3'b101;
parameter s6 = 3'b110;
parameter s7 = 3'b111;


always @(posedge clk)   // Initial state block
begin
    if (rst)
        ps <= s0;
    else
        ps <= ns;
end


always @(go,gt,lt,eq,ps)   // Next state logic
begin
        case(ps)
        s0: begin
            if (go)
            ns <= s1;
            else 
            ns <= s0;
            end
        s1: ns <= s2;
        s2: begin
                if (gt)
                ns <= s3;
                else if (lt)
                ns <= s4;
                else 
                ns <= s5; 
            end  
        s3: ns <= s2;
        s4: ns <= s2;
        s5: ns <= s0;
        endcase
end


always @(ps)  // output logic
begin
    case(ps)
    s0: begin
            asel = 0;
            bsel = 0;
            aload = 0;
            bload = 0;
            out_en = 0;
        end
    s1: begin
            asel = 1;
            bsel = 1;
            aload = 1;
            bload = 1;
            out_en = 0;
        end
    s2: begin
            asel = 0;
            bsel = 0;
            aload = 0;
            bload = 0;
            out_en = 0;
        end 
    s3: begin
            asel = 0;
            bsel = 0;
            aload = 1;
            bload = 0;
            out_en = 0;
        end
    s4: begin
            asel = 0;
            bsel = 0;
            aload = 0;
            bload = 1;
            out_en = 0;
        end
    s5: begin
            asel = 0;
            bsel = 0;
            aload = 0;
            bload = 0;
            out_en = 1;
        end
    endcase
end
endmodule
