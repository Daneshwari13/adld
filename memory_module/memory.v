


module memorymodel( data_out,data_in,addr,wr,cs );
parameter addr_size = 10, word_size = 8, memory_size = 1024;
input [addr_size-1:0] addr;
input [word_size-1:0] data_in;
input wr,cs;
output [word_size-1:0] data_out;
reg [word_size-1:0] mem[memory_size-1:0];
assign data_out = mem[addr];

always @(wr or cs)
if (wr) mem[addr] = data_in;

endmodule

module memorymodule_tb;


	// Inputs
	reg [7:0] data_in;
	reg [9:0] addr;
	reg wr;
	reg cs;
	integer k,myseed;

	// Outputs
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	memorymodel uut (
		.data_out(data_out), 
		.data_in(data_in), 
		.addr(addr), 
		.wr(wr), 
		.cs(cs)
	);

	initial begin
		// Initialize Inputs
		for(k=0;k<=1023;k=k+1)
		begin
		data_in = (k+k)%256;
		wr = 1;
		cs = 1;
		#2 addr = k;
		wr=0; cs=0;
		$display("addr:%5d,data:%4d",addr,data_in);
		end
		

    end
endmodule

