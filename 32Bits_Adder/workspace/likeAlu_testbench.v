`define DELAY 20
module likeAlu_testbench();

reg [4:0]inp_A,inp_B;
reg [1:0]select;
wire [4:0]out;

likeALU test(out,inp_A,inp_B,select);

initial begin
#`DELAY
select[1] = 1'b0; select[0] = 1'b0;  
inp_A[4] = 1'b1;  inp_A[3] = 1'b0;  inp_A[2] = 1'b1;  inp_A[1] = 1'b1;  inp_A[0] = 1'b0;	//10110
inp_B[4] = 1'b1;  inp_B[3] = 1'b1;  inp_B[2] = 1'b0;  inp_B[1] = 1'b1;  inp_B[0] = 1'b0;	//11010
#`DELAY
select[1] = 1'b0; select[0] = 1'b1;  
#`DELAY
select[1] = 1'b1; select[0] = 1'b0;  
#`DELAY
select[1] = 1'b1; select[0] = 1'b1;  
end
initial
begin

$monitor ("inp_A = %d%d%d%d%d inp_B = %d%d%d%d%d  select = %d%d  out = %d%d%d%d%d",inp_A[4],inp_A[3],inp_A[2],inp_A[1],inp_A[0],
																					  inp_B[4],inp_B[3],inp_B[2],inp_B[1],inp_B[0],
																						select[1],select[0],
																						out[4],out[3],out[2],out[1],out[0]);


end




endmodule