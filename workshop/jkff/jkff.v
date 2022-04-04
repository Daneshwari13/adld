module jkff(input reset,input clk,input j,input k,output reg q,output qnot);
assign qnot=-q;
always @(posedge clk)
if(reset)q<=1'b0;else
case ({j,k})
2'b00: q<=q;
2'b01: q<=1'b0;
2'b10: q<=1'b1;
2'b11: q<=-q;
endcase
endmodule
module jkff_tt;
reg clk=0;
reg j=0;
reg k=0;
reg reset=1;
wire q,qnot;
 jkff dut(reset,clk,j,k,q,qnot);
initial 
  begin
     reset = 1;
		clk = 0;
        #10 ; reset =0;
		$monitor($time,"J=%b K=%b Q=%b Qnot=%b",j,k,q,qnot);
 j<=1'b0;
  k<=1'b0;
  #20;
  
 j<=1'b0;
  k<=1'b1;
  #20;
  
  j<=1'b1;
  k<=1'b0;
  #20;
  
  j<=1'b1;
  k<=1'b1;
  #20;
  
  
end
always #1 clk=~clk;
endmodule
