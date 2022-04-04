module mux(y,s,a,b);
input a,b,s;
output y;

assign y=(s)? b:a;
endmodule
module mux_tt();
reg a,b,s;
wire y;
mux DUT(.y(y) , .s(s), .a(a), .b(b));
initial begin
$monitor("y=%b s=%b a=%b b=%b" ,y,s,a,b);
 s=1'b1 ; a=1'b1 ;b=1'b1;
#10 s=1'b0 ; a=1'b0 ;b=1'b0;
end
endmodule
