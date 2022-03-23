module mul_datapath(eqz,LdA,LdB,LdP,clrP,decB,data_in,clk);
input LdA,LdB,LdP,clrP,decB,clk;
input [15:0] data_in;
output eqz;
wire [15:0] X,Y,Z,Bout,Bus;

PIPO1 A(X,Bus,LdA,clk);
PIPO2 P(Y,Z,LdP,clrP,clk);
CNTR B(Bout,Bus,LdB,decB,clk);
ADD AD(Z,X,Y);
EQZ COMP(eqz,Bout);
endmodule

module PIPO1(dout,din,ld,clk);
input [15:0] din;
input ld,clk;
output reg[15:0] dout;
always @(posedge clk)
	if(ld) dout <= din;
endmodule

module PIPO2(dout,din,ld,clr,clk);
input [15:0] din;
input ld,clr,clk;
output reg [15:0] dout;
always @(posedge clk)
	if(clr) dout <= 16'b0;
	else if (ld) dout <= din;
endmodule


module EQZ(eqz,data);
input [15:0] data;
output eqz;
assign eqz = (data == 0);
endmodule

module ADD (out,in1,in2);
input [15:0] in1,in2;
output reg [15:0] out;
always@(*)
	out=in1 + in2;
endmodule

module CNTR(dout,din,ld,dec,clk);
input [15:0] din;
input ld,dec,clk;
output reg [15:0] dout;
always@(posedge clk)
	if(ld) dout <=din;
	else if (dec) dout <= dout-1;
endmodule





module controller (LdA,LdB,LdP,clrP,decB,done,clk,start,eqz);
input clk,eqz,start;
output reg LdA,LdB,LdP,clrP,decB,done;

reg[2:0]state;
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;

always @(posedge clk)
begin
  case(state)
   s0:if(start) state <=s1;
   s1: state <=s2;
   s2: state <=s3;
   s3: #2 if(eqz) state <=s4;
   s4: state <=s4;
  default: state <=s0;
endcase
end


always @(state)
begin
 case(state)
   s0:begin LdA=0;LdB=0;LdP=0;clrP=0;decB=0;done=0;end
   s1:begin LdA =1;LdB=0;LdP=0;clrP=0;decB=0;done=0;end
   s2:begin LdA =0;LdB=1;LdP=0;clrP=1;decB=0;done=0;end
   s3:begin LdA =0;LdB=0;LdP=1;clrP=0;decB=1;done=0;end
   s4:begin LdA =0;LdB=0;LdP=0;clrP=0;decB=0;done=1;end
  default: begin LdA=0;LdB=0;LdP=0;clrP=0;decB=0;done=0;end
 endcase
end
endmodule

module mul_tb;
reg [15:0] data_in;
reg clk,start;
wire done;
mul_datapath DP (eqz,LdA,LdB,Ldp,clrP,decB,data_in,clk);
controller CON (LdA,LdB,LdP,clrP,decB,done,clk,eqz,start);
initial begin
clk =1'b0;
#3 start =1'b1;
#500 $finish;
end 

always #5 clk = ~clk;

initial begin
#17 data_in =5;
#10 data_in =6;
end
initial begin
$monitor ($time, " %d %b",DP.Y,done);
$dumpfile("mul.vcd"); $dumpvars(0,mul_tb);
end
endmodule



