`define DELAY 20
module halfadder_testbench();

reg a,b;
wire sum,carryOut;

halfadder half(sum,carryOut,a,b);

initial begin
 a=1'b1; b=1'b1;
#`DELAY;
 a=1'b1; b=1'b0;
 #`DELAY;
 a=1'b0; b=1'b1;
  #`DELAY;
 a=1'b0; b=1'b0;
end
initial
	begin
$monitor(" a =%1b, b=%1b, sum=%1b, carry_out=%1b",  a, b, sum, carryOut);


end


endmodule