module srff(s,r,clk,q,qbar);
input s,r,clk;
output reg q,qbar;
always@(posedge clk)
begin
if(s == 1)
begin
q=1;
qbar = 0;
end
else if(r == 1)
begin
q=0;
qbar=1;
end
else if(s == 0 & r == 0)
begin
q <= q;
qbar <= qbar;
end
end
endmodule


module srff_tb();
reg s,r,clk;
wire q,qbar;
srff uut(.s(s),.r(r),.clk(clk),.q(q),.qbar(qbar));
initial
begin
s=0;
r=0;
clk=0;

#2 s=0;
#2 r=1;
#2 s=0;
#2 r=0;
#2 s=0;
#2 r=1;
#2 s=1;
#2 r=0;
#2 s=1;
#2 r=1;
end 
always #1 clk=!clk;
endmodule
