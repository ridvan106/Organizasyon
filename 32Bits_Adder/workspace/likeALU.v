module likeALU(out,inp_A,inp_B,select);

input [4:0]inp_A,inp_B;
input [1:0]select;
output [4:0]out;
wire carry;
wire [4:0]ve,veya,sum,exOr;
//----------------------------------------------
fivebitsadder addition(sum,carry,inp_A,inp_B,0);
//----------------------------------------------
or secim2(veya[0],inp_A[0],inp_B[0]),
	secim2_1(veya[1],inp_A[1],inp_B[1]),
	secim2_2(veya[2],inp_A[2],inp_B[2]),
	secim2_3(veya[3],inp_A[3],inp_B[3]),
	secim2_4(veya[4],inp_A[4],inp_B[4]);
//----------------------------------------------
and secim0(ve[0],inp_A[0],inp_B[0]),
	secim0_1(ve[1],inp_A[1],inp_B[1]),
	secim0_2(ve[2],inp_A[2],inp_B[2]),
	secim0_3(ve[3],inp_A[3],inp_B[3]),
	secim0_4(ve[4],inp_A[4],inp_B[4]);
//----------------------------------------------	
xor secim3(exOr[0],inp_A[0],inp_B[0]),
	secim3_1(exOr[1],inp_A[1],inp_B[1]),
	secim3_2(exOr[2],inp_A[2],inp_B[2]),
	secim3_3(exOr[3],inp_A[3],inp_B[3]),
	secim3_4(exOr[4],inp_A[4],inp_B[4]);	
	
//----------------------------------------------
wire tempXor,tempAnd,tempAdd,tempOr,notSelect1,notSelect2;
wire [4:0]_4tempXor,_4tempAnd,_4tempAdd,_4tempOr;
not n(notSelect1,select[1]);	//select bitlerinin not alınır
not n2(notSelect2,select[0]);

and q(tempXor,select[0],select[1]);//selectler 11 gelir ise 
and q1(tempOr,select[1],notSelect2); // selectler 10 gelir ise
and q2(tempAdd,notSelect1,select[0]); // selectler 01 gelir ise
and q3(tempAnd,notSelect1,notSelect2); // selectler 00 gelir ise  ilgili templer 1 olur

// select bitleri ile ilgili bitler andlenir eger select 1 ise sonuc digerine bagli olcaktir

and on1(_4tempXor[0],exOr[0],tempXor),
	 on2(_4tempXor[1],exOr[1],tempXor),
	 on3(_4tempXor[2],exOr[2],tempXor),
	 on4(_4tempXor[3],exOr[3],tempXor),
	 on5(_4tempXor[4],exOr[4],tempXor);

and  or1(_4tempOr[0],veya[0],tempOr),
	 or2(_4tempOr[1],veya[1],tempOr),
	 or3(_4tempOr[2],veya[2],tempOr),
	 or4(_4tempOr[3],veya[3],tempOr),
	 or5(_4tempOr[4],veya[4],tempOr);	 
	 
and  xor1(_4tempAnd[0],ve[0],tempAnd),
	  xor2(_4tempAnd[1],ve[1],tempAnd),
	  xor3(_4tempAnd[2],ve[2],tempAnd),
	  xor4(_4tempAnd[3],ve[3],tempAnd),
	  xor5(_4tempAnd[4],ve[4],tempAnd);		
	  
and  sum1(_4tempAdd[0],sum[0],tempAdd),
	  sum2(_4tempAdd[1],sum[1],tempAdd),
	  sum3(_4tempAdd[2],sum[2],tempAdd),
	  sum4(_4tempAdd[3],sum[3],tempAdd),
	  sum5(_4tempAdd[4],sum[4],tempAdd);			  
	  
// sonucunda ise tum bitler orlanır ve outputa atılır

wire [4:0]orTemp1,orTemp2;

or result1(orTemp1[0],_4tempOr[0],_4tempXor[0]),
	result2(orTemp1[1],_4tempOr[1],_4tempXor[1]),
	result3(orTemp1[2],_4tempOr[2],_4tempXor[2]),
	result4(orTemp1[3],_4tempOr[3],_4tempXor[3]),
	result5(orTemp1[4],_4tempOr[4],_4tempXor[4]);

	
or result6(orTemp2[0],_4tempAdd[0],_4tempAnd[0]),	
	result7(orTemp2[1],_4tempAdd[1],_4tempAnd[1]),	
	result8(orTemp2[2],_4tempAdd[2],_4tempAnd[2]),	
	result9(orTemp2[3],_4tempAdd[3],_4tempAnd[3]),	
	result10(orTemp2[4],_4tempAdd[4],_4tempAnd[4]);
	
or realResult(out[0],orTemp1[0],orTemp2[0]),	
	realResult1(out[1],orTemp1[1],orTemp2[1]),	
	realResult2(out[2],orTemp1[2],orTemp2[2]),	
	realResult3(out[3],orTemp1[3],orTemp2[3]),	
	realResult4(out[4],orTemp1[4],orTemp2[4]);



endmodule