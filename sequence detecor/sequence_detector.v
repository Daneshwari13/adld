
module S_D_M_V(sequence_in, clock, reset,detector_out);
input clock;
input sequence_in;
input reset;
output reg detector_out;

parameter Zero=3'b000 ,   One=3'b001, OneZero=3'b011, OneZeroOne=3'b010, OneZeroOneOne=3'b0110;
reg[2:0] current_state ,next_state;

always@(posedge clock, posedge reset)
begin
if(reset==1)
 current_state <=Zero;
else
current_state <=next_state;
end

always@(current_state,sequence_in) 
begin
case(current_state)
Zero: begin
if(sequence_in==1)
next_state = One;
else
next_state = Zero;
end

One : begin
if(sequence_in==1)
next_state = One;
else
next_state = OneZero;
end

OneZero : begin
if(sequence_in==1)
next_state = OneZeroOne;
else
next_state = Zero;
end

OneZeroOne : begin
if(sequence_in==1)
next_state = OneZeroOneOne;
else
next_state = OneZero;
end


OneZeroOneOne : begin
if(sequence_in==1)
next_state = One;
else
next_state = OneZero;
end

default : next_state =Zero;
endcase
end

always@(current_state)
begin
case(current_state)
Zero : detector_out=0;
OneZero :detector_out=0;
OneZeroOne :detector_out=0;
OneZeroOneOne :detector_out=1;
default: detector_out=0;
endcase
end

endmodule


module S_D_M_V_tb;
reg sequence_in;
reg clock;
reg reset;

wire detector_out;

S_D_M_V uut(.sequence_in(sequence_in), .clock(clock) , .reset(reset), .detector_out(detector_out));


initial begin
clock =0;
forever #5 clock =~clock;
end
initial begin
sequence_in =0;
reset =1;
#10;
reset =0;
#10;

sequence_in =1;
#10;
sequence_in =0;
#10;

sequence_in =1;
#10;
sequence_in =0;
#10;

sequence_in =1;
#10;
sequence_in =0;
$finish;

end
endmodule





