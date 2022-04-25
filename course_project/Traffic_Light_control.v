module traffic_light_controller(hwy,cntry,x,clock,clear

    );
input x,clear,clock;
output [1:0]hwy,cntry;
reg[1:0]hwy,cntry;
reg[2:0]state;
parameter true=1'd1,false=1'd0,red=2'd0,yellow=2'd1,green=2'd2;
parameter s0=3'd0,s1=3'd1,s2=3'd2,s3=3'd3,s4=3'd4;
parameter y2rdelay=3,r2ydelay=2,r2gdelay=1;
reg[2:0]next_state; 
always @(posedge clock)
if(clear)
state <= s0;
else
state <= next_state ;



always @ (state)
begin
hwy = green;
cntry =red;
case (state)
s0 : begin 
hwy = green;
cntry = red;
end
s1 : begin
hwy = yellow ;
cntry =red;
end
s2 :begin
hwy =red;
cntry=red;
end
s3:begin
hwy =red;
cntry=green;
end
s4 : begin
hwy =red;
cntry = yellow;
end
endcase
end
always @(state or x)
begin 

case(state)
s0:if(x)
next_state = s1;
else
next_state =s0;
s1:begin
repeat(y2rdelay) next_state = s1;
next_state = s2;
end
s2:begin
repeat(r2gdelay) next_state = s2;
next_state = s3;
end
s3 : if (x)
next_state = s3;
else
next_state = s4;
s4 : begin 
repeat(y2rdelay) next_state =s4;
next_state = s0;
end
default :next_state = s0;
endcase
end

endmodule
