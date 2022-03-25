
module pipelining(F,A,B,C,D,clk);
parameter N=10;
input[N-1:0] A,B,C,D;
input clk;
output[N-1:0] F;
reg[N-1:0] L12_x1,L12_x2,L12_D,L23_x3,L23_D,L34_F;
assign F=L34_F;
always@(posedge clk)
begin
L12_x1 <= #4 A+B;
L12_x2 <= #4 C-D;
L12_D <=  D;
end

always@(posedge clk)
begin
L23_x3 <= #4 L12_x1+L12_x2;
L23_D <= L12_D;
end
always@(posedge clk)
begin
L34_F <= #6 (L23_x3 * L23_D);
end




endmodule




module pipelining_tb;

	// Inputs
	reg [9:0] A;
	reg [9:0] B;
	reg [9:0] C;
	reg [9:0] D;
	reg clk;

	// Outputs
	wire [9:0] F;

	// Instantiate the Unit Under Test (UUT)
	pipelining uut (
		.F(F), 
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.clk(clk)
	);
	
 
	always 
    begin 
	 #10; clk = ~clk;
	 end
	initial begin
	    clk=0;
		// Initialize Inputs
		#5 A = 10; B=12; C=6; D=3;  //F=75
		#20 A = 10; B=10; C=5; D=3;  //F=66
		#20 A = 20; B=1; C=1; D=4;  //F=112
		// #5 A = 10, B=12, C=0, D=3;  //F=75
		end
		initial
	
		begin
		$dumpfile("pipelining.vcd");
		$dumpvars(0,pipelining_tb);
		$monitor ("time: %d,F=%d",$time,F);
		#300 $finish;
		
	end
      
endmodule

