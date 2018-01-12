module fivebitsadder(sum,carryOut,input1,input2,carryIn);
input [4:0]input1,input2;
input carryIn;
output carryOut;
output [4:0]sum;
	
wire Tcarry1,Tcarry2,Tcarry3,Tcarry4;
fulladder result1(sum[0],Tcarry1,input1[0],input2[0],carryIn),
			 result2(sum[1],Tcarry2,input1[1],input2[1],Tcarry1),
			 result3(sum[2],Tcarry3,input1[2],input2[2],Tcarry2),
			 result4(sum[3],Tcarry4,input1[3],input2[3],Tcarry3),
			result5(sum[4],carryOut,input1[4],input2[4],Tcarry4);




endmodule