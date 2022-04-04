module full_adder(sum,cout,a,b,cin);
input a,b,cin;
output sum,cout;
assign sum=a^b^cin;
assign cout=(a & b)|(b & cin)|(cin & a);
endmodule

module full_adder_tb;
reg a,b,cin;
wire sum,cout;
full_adder DUT (.sum(sum),.cout(cout),.a(a),.b(b),.cin(cin));
initial
begin
$monitor($time,"a=%b b=%b cin=%b sum=%b carry=%b",a,b,cin,sum,cout);
a=0;b=0;cin=0;
#10 a=0;b=1;cin=0;
#10 a=1;b=0;cin=0;
#10 a=1;b=1;cin=0;

end 
endmodule
