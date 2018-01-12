module fulladder(sum,carryOut,input1,input2,carryIn);
input input1,input2,carryIn;
output sum,carryOut;
wire firstCarry,secondCarry,sum1;

halfadder result1(sum1,firstCarry,input1,input2);
halfadder resul2(sum,secondCarry,sum1,carryIn);

or adderOut(carryOut,firstCarry,secondCarry);
endmodule