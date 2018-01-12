module fpga(led[4:0],input1[4:0],input2[4:0],select[1:0]);
	input [4:0] input1,input2;
	input [1:0] select;
	output [4:0] led;
	wire [4:0] tempOut;
likeALU res(tempOut,input1,input2,select);
assign led = tempOut;




endmodule