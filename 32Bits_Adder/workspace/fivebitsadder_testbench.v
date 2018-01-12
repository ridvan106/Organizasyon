`define DELAY 20
module fivebitsadder_testbench();
reg [4:0]a,b;
reg carryIn;
wire [4:0]sum;
wire carryOut;
fivebitsadder res(sum,carryOut,a,b,carryIn);

initial begin
#`DELAY;
carryIn =1'b0;																		//carryin 0
a[0] = 1'b0; a[1] = 1'b1; a[2] = 1'b0; a[3] = 1'b1; a[4] = 1'b0; //01010
b[0] = 1'b1; b[1] = 1'b1; b[2] = 1'b0; b[3] = 1'b1; b[4] = 1'b0; //01011
#`DELAY;
carryIn =1'b1;																		//carryin 1
a[0] = 1'b0; a[1] = 1'b1; a[2] = 1'b1; a[3] = 1'b0; a[4] = 1'b1; //10110
b[0] = 1'b0; b[1] = 1'b1; b[2] = 1'b1; b[3] = 1'b1; b[4] = 1'b0; //01110
#`DELAY;
carryIn =1'b1;																		//carryin 1
a[0] = 1'b1; a[1] = 1'b1; a[2] = 1'b1; a[3] = 1'b1; a[4] = 1'b0; //01111
b[0] = 1'b0; b[1] = 1'b1; b[2] = 1'b0; b[3] = 1'b1; b[4] = 1'b0; //01010
end
initial
begin

$monitor ("a= %d%d%d%d%d  b= %d%d%d%d%d carryin = %d sum = %d%d%d%d%d  carryout = %d",a[4],a[3],a[2],a[1],a[0],
																								 b[4],b[3],b[2],b[1],b[0],
																								 carryIn, 
																								 sum[4],sum[3],sum[2],sum[1],sum[0],
																								 carryOut);

end

endmodule