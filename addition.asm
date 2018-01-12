.text
			
j main								# main label dan baslar				
printZero_Screen:					# gelen sayi kadar ekrana 0 yazar
	slt $s7,$a0,$0					# a0 < 0 ise s71
	bne $s7,$0,fin					# if(a0 <0 ) finish

	move $s7,$a0					# s7 = a0
	
	equal:
	bne $s7,$0,proccess 			# if (s7 != 0) ekrana 0 yazar
	j $ra							# if(s7 == 0) return function
	proccess:						# ekrana 0 yazar
	move $a0,$0						# ekrana yazılcak
	addi $v0,$0,1					# 1 ekrana integer yazma
	syscall					
	addi $s7,$s7,-1					# s7 -= 1
	j equal
	fin:
	j $ra							# return kısmı



abso:								# gelen sayinin mutlak degerini alır
	slt $t8,$a0,$0					# ?(a0 < 0)
	bne $t8,$0,mut					#
	move $v0,$a0					# if(a0 > 0)
	j $ra
	mut:							# if(a0 < 0)
	addi $t8,$0,-1					# a0 pozitif yapilir
	mult $a0,$t8
	mflo $v0	
	j $ra
	
		
get_basamak:						# gelen integerın kac basamaklı oldugunu dondurur
	addi $t6,$0,10					# t6 = 10
	move $t7,$a0					# arguman alınır
	addi $v0,$0,1					# v0 = 1
	loop:							# sayının kac basamaklı oldugu buluncak
		div $t7,$t6 				# t1 / t6
		mflo $t7					# bolum alınır
		beq $t7,$0,returnProcedur	# bolum sıfır ise
		addi $v0,$v0,1
		j loop
returnProcedur:						# return function
	j $ra
pow: 								# gelen argumanın 10 üzer carpını return eder	pow(10,a)
	addi $t7,$0,1					# t7 = 1
	addi $s2,$0,10					# s2 = 10
	move $v0,$s2					# v0 = s2
	exp:
		beq $t7,$a0,return_pow		# eger basmak sayisi kadar carpma islemi oldu ise
		mult $v0,$s2				# v0 10 ile carpilir
		mflo $v0		
		addi $t7,$t7,1				# t7 += 1
	
	j exp;
	return_pow:
	j $ra							# return functions

main:								# parser kısmı olmadıgı icin sayilar integer integer char integer integer olarak alınır
#------------------ilk sayi okunur-------------------
addi $v0,$0,5						# v0 5 console dan integer okuma
syscall						
move $t0, $v0						#registera atılır t0

#------------------fractionı  okunur-------------------
addi $v0,$0,5						# v0 5 console dan integer okuma
syscall
move $t1, $v0 						# registera atılır t0

#------------------karakter sayi okunur (+ veya * veya -)-------------------
addi $v0,$0,12						# v0 = 12 consoledan karakter okuma
syscall
move $t2, $v0						#registera atılır t2
#------------------ikinci sayi okunur-------------------
addi $v0,$0,5						# v0 5 console dan integer okuma
syscall
move $t3, $v0						# registera atılır t3

#------------------fractionı  okunur-------------------
addi $v0,$0,5						# v0 5 console dan integer okuma
syscall
move $t4, $v0						# registera atılır t4
#----------------------------------------------------
#-------------Operand kontrolu-----------------------
addi $t5,$0,43  					# + operasyonu
beq $t2,$t5,topla
addi $t5,$0,42  					# * operasyonu
beq $t2,$t5,carp
addi $t5,$0,45   					# * operasyonu
beq $t2,$t5,cikar
j return							# yanlis operand ise
cikar:								# cikarma iselemleri icin ayrılan label
move $a0,$t1     					# a0 = t1
	jal get_basamak					# get_basamak(t1)
	move $t5,$v0					# t5 = get_basamak(t1)
	move $s4,$v0					# s4 = get_basamak(t1)
	move $a0,$t5					
	jal pow							# pow(t5)
	move $s0,$v0		  			# s0 = pow()
	move $t5 ,$v0					# t5 = pow()
	mult $t5,$t0					# t5 * t0		
	mflo $t5						# t5 = t5 * t0	
	add $t0,$t1,$t5					#------ilk sayıyı rasyonele cevirdik t1 /1000 tarzı
	move $a0,$t4					# a0 = t4
	jal get_basamak					# get_basamak(t4)
	move $s5,$v0					# s5 = get_basamak(t4)
	move $a0,$v0					# a0 = v0
	jal pow							# pow (a0)
	move $s1,$v0					# s1 = pow(a0)
	move $s3,$v0					# s3 = pow (a0)
	mult $s3,$t3					# s3 * t3
	mflo $s3						# s3 =  s3 * t3
	add $t3,$t4,$s3					#-----ikinci sayida rasyonele cevrildi	
	beq $s4,$s5,cikar1				# s4 == s5 sayi basamakları esit ise cikar
	slt $s6,$s4,$s5					# s4 < s5
	bne $s6,$0,cikar2				# s5 > s4	ikincinin basamak degeri daha buyuk ise
									# s4 > s5 t3 carpilacak
	sub $s6,$s4,$s5					# s6 = s5 - s4
	move $a0,$s6					# a0 = s6
	jal pow							# pow(s6)
	mult $t3,$v0					# t0 * pow(s6) payda ile genisletilme
	mflo $t3						# t3 = t0 * pow(s6)
	sub  $t0,$t0,$t3				# paylari cikartma
	div $t0,$s0						# paydaya bolme kalan= fraction bolum = integer kısım
	move $s6,$s0					# s6 = s0
	mfhi $t1						# t1 = fraction
	mflo $t0						# t0 bolum	
	j return 						# ekrana yazdırmak uzere return edilir t1 ve t0 ekrana yazılır
	
	
cikar1:								# basamak degerleri aynı oldugu icin direk cikarilip paydaya bolunur
	sub $t0,$t0,$t3					# to = t0 - t3
	div $t0,$s0						# t0 / s0 pay/ payda
	move $s6,$s0					
	mfhi $t1						# t1 = fraction
	mflo $t0						# t0 = bolum
	j return
cikar2:								# s5 > s4 t3 fark kadar 10 ile carpilmali
	sub $s6,$s5,$s4					#  s6 = s5 - s4
	move $a0,$s6					# a0 = s6
	jal pow							# pow(s6)
	mult $t0,$v0					# t0 * pow(s6)
	mflo $t0						# t0 = t0 * pow(s6)
	sub  $t0,$t0,$t3				# t0 = t0 - t3
	div $t0,$s1						# t0 / s1
	move $s6,$s1					# 
	mfhi $t1						# t1 = t0 % s1	
	mflo $t0						# t0 = t0 /s1

j return							# ekrana yazdırılmak icin return 'e gider


carp:								# operand olarak carpma secilir ise
	move $a0,$t1     				# a0 = t1
	jal get_basamak					# get_basamak(t1)
	move $t5,$v0					# t5 = get_basamak(t1)
	move $a0,$t5					# a0 = t5)
	jal pow							# pow(t5)
	move $s0,$v0		    		# s0 = pow(t5 )
	move $t5 ,$v0					# t5 = pow(t5)
	mult $t5,$t0					# t5 * t0		
	mflo $t5						# t5 = t5 * t0	
	add $t0,$t1,$t5					#------ilk sayıyı rasyonele cevirdik t1 /1000 tarzı
	move $a0,$t4					# a0 = t4
	jal get_basamak					# t4 un kac basamaklı oldugu get_basamak(t4)
	move $a0,$v0					# a0 = v0
	jal pow							# pow(t4)
	move $s1,$v0					# s1 = v0
	move $s3,$v0					# s3 = v0
	mult $s3,$t3					# s3 *t3
	mflo $s3						# s3 = s3 *t3
	add $t3,$t4,$s3					#-----ikinci sayida rasyonele cevrildi
	mult $t0,$t3					# to * t3 yani pay kısımları carpilir
	mflo $t5						# t5 = t0 * t3	
	mult $s0,$s1					# s0 * s1 yani paydalar carpilir
	mflo $s3						# s3 = s0 * s1
	div $t5,$s3						# t5 / s3    pay / payda
	move $s6,$s3					
	mfhi $t1						# t1 = t5 % s0
	mflo $t0						# t0 = t5 / s0

j return							# ekrana yazdırmak icin return labelına gidilir


topla:								# operand olarak + secilir ise 
#----------------------------------------------------
move $a0,$t1     					# a0 = t1
	jal get_basamak					# get_basamak(t1)	
	move $t5,$v0					# t5 = v0
	move $s4,$v0					# s4 = v0
	move $a0,$t5					# a0 = t5
	jal pow							# pow(t5)
	move $s0,$v0		    		# s0 = pow(t5)
	move $t5 ,$v0					# t5 = pow(t5)
	mult $t5,$t0					# t5 * t0		
	mflo $t5						# t5 = t5 * t0	
	add $t0,$t1,$t5					#------ilk sayıyı rasyonele cevirdik t1 /1000 tarzı
	move $a0,$t4					# a0 = t4
	jal get_basamak					# t4 un kac basamaklı oldugu
	move $s5,$v0					# s5 = v0
	move $a0,$v0					# a0 = v0
	jal pow							# pow(s5)
	move $s1,$v0					# s1 = vo
	move $s3,$v0					# s3 = v0
	mult $s3,$t3					# s3 *t3
	mflo $s3						# s3 = s3 * t3
	add $t3,$t4,$s3					#-----ikinci sayida rasyonele cevrildi	s4 ve s5 de ondalık degerler var
	beq $s4,$s5,topla1				# paydalari esit ise topla1 e git
	slt $s6,$s4,$s5					# s4 < s5
	bne $s6,$0,topla2				# s5 > s4
	
									# s4 > s5 t3 carpilacak
	sub $s6,$s4,$s5					# s6 = s5 - s4
	move $a0,$s6					# a0 = s6
	jal pow							# pow (s6)
	mult $t3,$v0					# t0 * pow(s6)
	mflo $t3						# t3 = 	t0 * pow(s6)
	add  $t0,$t0,$t3				# t0 = t0 + t3 payların toplamı
	div $t0,$s0						# t0 / s0 paydaya bolumu
	move $s6,$s0					# s6 = s0
	mfhi $t1						# t1 = t0 % s0 
	mflo $t0						# t0 = t0 / s0
	j return						# ekrana yazdırmak icin return'e gider
	
	
	topla1:							# paydalar esit ise gelen label direk toplanır ve paydaya bolunur
	add $t0,$t0,$t3					# t0 = t0 + t3 payda toplamı
	div $t0,$s0						# t0 / s0
	move $s6,$s0					
	mfhi $t1						# t1 = t0 % s0
	mflo $t0						# t0 = t0 / s0
	j return						# ekrana yazdırmak icin returne atlar
	
	topla2:	
	
	sub $s6,$s5,$s4					#  s6 = s5 - s4     payda arasındaki fark
	move $a0,$s6					# a0 = s6
	jal pow							# pow (s6)
	mult $t0,$v0					# t0 * pow(s6)
	mflo $t0						# t0 = t0 * pow(s6)
	add  $t0,$t0,$t3				# t0 = t0 + t3   pay toplamı
	div $t0,$s1						# t0 / s1 				pay / payda
	move $s6,$s1				
	mfhi $t1						# t1 = t0 % s0
	mflo $t0						# t1 = t0 / s0



#-----------------------------------------------------

	
return:								#sonucları ekrana basma kısmı ??
addi $a0,$0,61 						# ekrana '=' basar
addi $v0,$0,11						# ekrana karakter basma
syscall
									# -0.123 tarzı sayılar için ekrana - yazdırma
	bne $t0,$0,atla					# pay sifir degil ise devam
	slt $t9,$t1,$0
	beq $t9,$0,atla
	addi $a0,$0,45 					# ekrana '-' basar eger pay sifir ve payda kucuk sifir ise
	addi $v0,$0,11					# ekrana char basma klodu
	syscall

	
atla:
move $a0,$t0						# ekrana integer basan kısın ekrana pay t0 Basar
addi $v0,$0,1
syscall
addi $a0,$0,44						# virgul basar
addi $v0,$0,11
syscall
move $a0,$t1						# fraction kısım
jal abso							# t1 absolute alınır eger payda '-' ise bolme sonucu olabiliyo
move $t1,$v0						# return degeri t1 de  t1 = abs(t1)  # t2,t3,t4 kullanılabilir
move $a0,$t1						# a0 = t0
jal get_basamak						# get_basamak(t1)
move $t2,$v0						# t2 = get_basamak(t1)	ilk payda
move $a0,$s6						# a0 = s6 payda sayisi
jal get_basamak						# get_basamak(s6)		ikinci payda sayisi
move $t3,$v0						# t3 = get_basamak(s6) 
addi $t3,$t3,-1						# bastaki 1 atilmasi icin 1 cikarilir
sub $a0,$t3,$t2						# paydalar esit olduktan sonra ilk ve ikinci paydalar esit olmalı esit degil ise fractionun basina 0 konur
jal printZero_Screen				# ekrana fark kadar sifir basar	
			 		


move $a0,$t1						# ekrana t1 deki fraction olan kısmı basars
addi $v0,$0,1						# ekrana integer basma
syscall
addi $a0,$0,4						


addi $v0,$0,10 						# return 0# main return value si olarak dusunulebilir
syscall