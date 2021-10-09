module HalfAdder(A,B,carry,sum);
	input A;
	input B;
	output carry;
	output sum;
	reg carry;
	reg sum;

	always @(*) 
	  begin
	    sum= A ^ B;
	    carry= A & B;
	  end
endmodule

module FullAdder(A,B,C,carry,sum);
	input A;
	input B;
	input C;
	output carry;
	output sum;
	reg carry;
	reg sum;	
	wire c0;
	wire s0;
	wire c1;
	wire s1;

	always @(*) 
	  begin
		sum=s1;
		sum=A^B^C;
		carry=c1|c0;
		carry=((A^B)&C)|(A&B);  
	  end
endmodule

module ADD_SUB(inputA,inputB,mode,sum,carry,overflow);
    input [15:0] inputA;
	input [15:0] inputB;
    input mode;
    output [31:0] sum;
	output carry;
    output overflow;
    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15; //XOR Interfaces
	wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16; //Carry Interfaces
	
    assign b0 = inputB[0] ^ mode;
    assign b1 = inputB[1] ^ mode;
    assign b2 = inputB[2] ^ mode;
    assign b3 = inputB[3] ^ mode;
	assign b4 = inputB[4] ^ mode;
    assign b5 = inputB[5] ^ mode;
    assign b6 = inputB[6] ^ mode;
    assign b7 = inputB[7] ^ mode;
	assign b8 = inputB[8] ^ mode;
    assign b9 = inputB[9] ^ mode;
    assign b10 = inputB[10] ^ mode;
    assign b11 = inputB[11] ^ mode;
	assign b12 = inputB[12] ^ mode;
    assign b13 = inputB[13] ^ mode;
    assign b14 = inputB[14] ^ mode;
    assign b15 = inputB[15] ^ mode;

	FullAdder FA0(inputA[0],b0,mode,c1,sum[0]);
	FullAdder FA1(inputA[1],b1,  c1,c2,sum[1]);
	FullAdder FA2(inputA[2],b2,  c2,c3,sum[2]);
	FullAdder FA3(inputA[3],b3,  c3,c4,sum[3]);
	FullAdder FA4(inputA[4],b4,	 c4,c5,sum[4]);
	FullAdder FA5(inputA[5],b5,  c5,c6,sum[5]);
	FullAdder FA6(inputA[6],b6,  c6,c7,sum[6]);
	FullAdder FA7(inputA[7],b7,  c7,c8,sum[7]);
	FullAdder FA8(inputA[8],b8,  c8,c9,sum[8]);
	FullAdder FA9(inputA[9],b9,  c9,c10,sum[9]);
	FullAdder FA10(inputA[10],b10,  c10,c11,sum[10]);
	FullAdder FA11(inputA[11],b11,  c11,c12,sum[11]);
	FullAdder FA12(inputA[12],b12,  c12,c13,sum[12]);
	FullAdder FA13(inputA[13],b13,  c13,c14,sum[13]);
	FullAdder FA14(inputA[14],b14,  c14,c15,sum[14]);
	FullAdder FA15(inputA[15],b15,  c15,c16,sum[15]);

	assign carry=c16;
	assign overflow=c16^c15;
 
endmodule

module MULT_ASSIST(inputA,bitB,carryinbit,carryinlist,carryoutbit,carryoutlist,productbit);
	input [15:0] inputA;
	input bitB;
	input carryinbit;
	input [14:0] carryinlist;
	output carryoutbit;
	output [14:0] carryoutlist;
	output productbit;
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15; //Carry Interfaces

	HalfAdder A0(inputA[0]&bitB,		carryinlist[0],					c1,				productbit);
	FullAdder A1(inputA[1]&bitB,	 	carryinlist[1],			c1,		c2,				carryoutlist[0]);
	FullAdder A2(inputA[2]&bitB,	 	carryinlist[2],			c2,		c3,				carryoutlist[1]);
	FullAdder A3(inputA[3]&bitB,		carryinlist[3],			c3,		c4,				carryoutlist[2]);
	FullAdder A4(inputA[4]&bitB,	 	carryinlist[4],			c4,		c5,				carryoutlist[3]);
	FullAdder A5(inputA[5]&bitB,	 	carryinlist[5],			c5,		c6,				carryoutlist[4]);
	FullAdder A6(inputA[6]&bitB,	 	carryinlist[6],			c6,		c7,				carryoutlist[5]);
	FullAdder A7(inputA[7]&bitB,	 	carryinlist[7],			c6,		c7,				carryoutlist[6]);
	FullAdder A8(inputA[8]&bitB,	 	carryinlist[8],			c7,		c8,				carryoutlist[7]);
	FullAdder A9(inputA[9]&bitB,	 	carryinlist[9],			c8,		c10,			carryoutlist[8]);
	FullAdder A10(inputA[10]&bitB,	 	carryinlist[10],		c10,	c11,			carryoutlist[9]);
	FullAdder A11(inputA[11]&bitB,	 	carryinlist[11],		c11,	c12,			carryoutlist[10]);
	FullAdder A12(inputA[12]&bitB,	 	carryinlist[12],		c12,	c13,			carryoutlist[11]);
	FullAdder A13(inputA[13]&bitB,		carryinlist[13],		c13,	c14,			carryoutlist[12]);
	FullAdder A14(inputA[14]&bitB,	 	carryinlist[14],		c14,	c15,			carryoutlist[13]);
	FullAdder A15(inputA[15]&bitB,	 	carryinbit,				c15,	carryoutbit,	carryoutlist[14]);

endmodule

module MULT(inputA,inputB,product);
	input [15:0] inputA;
	input [15:0] inputB;
    output [31:0] product;
	wire carryinbit;
	wire [14:0] carrylistA;
	wire carryoutbit;
	wire [14:0] carrylistB;
	wire [14:0] carrylistC;
	wire [14:0] carrylistD;
	wire [14:0] carrylistE;
	wire [14:0] carrylistF;
	wire [14:0] carrylistG;
	wire [14:0] carrylistH;
	wire [14:0] carrylistI;
	wire [14:0] carrylistJ;
	wire [14:0] carrylistK;
	wire [14:0] carrylistL;
	wire [14:0] carrylistM;
	wire [14:0] carrylistN;
	wire [14:0] carrylistO;
	wire [14:0] carrylistP;
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30; //Carry Interfaces

	HalfAdder A1(inputA[0]&inputB[0], 	 	1'b0,			c1, 			product[0]);
	HalfAdder A2(inputA[1]&inputB[0], 	 	c1,				c2,				carrylistA[0]);
	HalfAdder A3(inputA[2]&inputB[0], 	 	c2,				c3,				carrylistA[1]);
	HalfAdder A4(inputA[3]&inputB[0], 	 	c3,				c4,				carrylistA[2]);
	HalfAdder A5(inputA[4]&inputB[0],	  	c4,				c5, 			carrylistA[3]);
	HalfAdder A6(inputA[5]&inputB[0], 	 	c5,				c6,				carrylistA[4]);
	HalfAdder A7(inputA[6]&inputB[0], 	 	c6,				c7,				carrylistA[5]);
	HalfAdder A8(inputA[7]&inputB[0], 		c7,				c8,				carrylistA[6]);
	HalfAdder A9(inputA[8]&inputB[0], 		c8,				c9, 			carrylistA[7]);
	HalfAdder A10(inputA[9]&inputB[0],		c9,				c10,			carrylistA[8]);
	HalfAdder A11(inputA[10]&inputB[0],		c10,			c11,			carrylistA[9]);
	HalfAdder A12(inputA[11]&inputB[0], 	c11,			c12,			carrylistA[10]);
	HalfAdder A13(inputA[12]&inputB[0], 	c12,			c13, 			carrylistA[11]);
	HalfAdder A14(inputA[13]&inputB[0], 	c13,			c14,			carrylistA[12]);
	HalfAdder A15(inputA[14]&inputB[0], 	c14,			c15,			carrylistA[13]);
	HalfAdder A16(inputA[15]&inputB[0], 	c15,			c16,			carrylistA[14]);

	MULT_ASSIST M1(inputA,inputB[1],c16,carrylistA,c17,carrylistB,product[1]);
	MULT_ASSIST M2(inputA,inputB[2],c17,carrylistB,c18,carrylistC,product[2]);
	MULT_ASSIST M3(inputA,inputB[3],c18,carrylistC,c19,carrylistD,product[3]);
	MULT_ASSIST M4(inputA,inputB[4],c19,carrylistD,c20,carrylistE,product[4]);
	MULT_ASSIST M5(inputA,inputB[5],c20,carrylistE,c21,carrylistF,product[5]);
	MULT_ASSIST M6(inputA,inputB[6],c21,carrylistF,c22,carrylistG,product[6]);
	MULT_ASSIST M7(inputA,inputB[7],c22,carrylistG,c23,carrylistH,product[7]);
	MULT_ASSIST M8(inputA,inputB[8],c23,carrylistH,c24,carrylistI,product[8]);
	MULT_ASSIST M9(inputA,inputB[9],c24,carrylistI,c25,carrylistJ,product[9]);
	MULT_ASSIST M10(inputA,inputB[10],c25,carrylistJ,c26,carrylistK,product[10]);
	MULT_ASSIST M11(inputA,inputB[11],c26,carrylistK,c27,carrylistL,product[11]);
	MULT_ASSIST M12(inputA,inputB[12],c27,carrylistL,c28,carrylistM,product[12]);
	MULT_ASSIST M13(inputA,inputB[13],c28,carrylistM,c29,carrylistN,product[13]);
	MULT_ASSIST M14(inputA,inputB[14],c29,carrylistN,c30,carrylistO,product[14]);

	MULT_ASSIST M15(inputA,inputB[15],c30,carrylistO,product[31],carrylistP,product[15]);

	assign product[16] = carrylistP[0];
	assign product[17] = carrylistP[1];
	assign product[18] = carrylistP[2];
	assign product[19] = carrylistP[3];
	assign product[20] = carrylistP[4];
	assign product[21] = carrylistP[5];
	assign product[22] = carrylistP[6];
	assign product[23] = carrylistP[7];
	assign product[24] = carrylistP[8];
	assign product[25] = carrylistP[9];
	assign product[26] = carrylistP[10];
	assign product[27] = carrylistP[11];
	assign product[28] = carrylistP[12];
	assign product[29] = carrylistP[13];
	assign product[30] = carrylistP[14];

endmodule

module DIV(inputA,inputB,quotient,dbz);
	input [15:0] inputA,inputB;
	output [31:0] quotient;
	output dbz;
	reg dbz;
	reg [31:0] quotient;

	always @(*) begin
		quotient = inputA/inputB;
		if (inputB) 
			dbz = 0;
		else 
			dbz = 1;
	end

endmodule

module DEC(binary,onehot);
	input [3:0] binary;
	output [15:0]onehot;
	
	assign onehot[ 0]=~binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 1]=~binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[ 2]=~binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[ 3]=~binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[ 4]=~binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[ 5]=~binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[ 6]=~binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[ 7]=~binary[3]& binary[2]& binary[1]& binary[0];
	assign onehot[ 8]= binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 9]= binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[10]= binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[11]= binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[12]= binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[13]= binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[14]= binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[15]= binary[3]& binary[2]& binary[1]& binary[0];
	
endmodule;

module MUX(channels, select, b);
input [15:0][31:0] channels;
input      [15:0] select;
output      [31:0] b;

	assign b = ({16{select[15]}} & channels[15]) | 
               ({16{select[14]}} & channels[14]) |
			   ({16{select[13]}} & channels[13]) |
			   ({16{select[12]}} & channels[12]) |
			   ({16{select[11]}} & channels[11]) |
			   ({16{select[10]}} & channels[10]) |
			   ({16{select[ 9]}} & channels[ 9]) |
			   ({16{select[ 8]}} & channels[ 8]) |
			   ({16{select[ 7]}} & channels[ 7]) |
			   ({16{select[ 6]}} & channels[ 6]) |
			   ({16{select[ 5]}} & channels[ 5]) |
			   ({16{select[ 4]}} & channels[ 4]) |
			   ({32{select[ 3]}} & channels[ 3]) |
			   ({16{select[ 2]}} & channels[ 2]) | 
               ({16{select[ 1]}} & channels[ 1]) |
               ({16{select[ 0]}} & channels[ 0]) ;

endmodule


module BreadBoard(inputA,inputB,command,result,error);
input [15:0]inputA;
input [15:0]inputB;
input [3:0]command;
output [31:0]result;
output [1:0]error;
wire [15:0]inputA;
wire [15:0]inputB;
wire [3:0]command;
reg [31:0]result;
reg [1:0]error;

//Local Variables
//Full Adder
reg mode;
wire [31:0] sum;
wire carry;
wire overflow;

//Multiplier
wire [31:0] product;

//Divider
wire [31:0] quotient;
wire dbzD;

//Multiplexer
wire [15:0][31:0] channels;
wire [15:0] onehotMux;
wire [31:0] b;

DEC dec(command,onehotMux);
ADD_SUB add_sub(inputA,inputB,mode,sum,carry,overflow);
MUX mux(channels,onehotMux,b);
MULT mult(inputA,inputB,product);
DIV div(inputA, inputB, quotient, dbzD);



assign channels[ 0]=0;//GROUND=0
assign channels[ 1]=sum;//Addition
assign channels[ 2]=sum;//Subtraction
assign channels[ 3]=product;//Multiplication
assign channels[ 4]=quotient;//Division
assign channels[ 5]=0;//mod;//Modulo
assign channels[ 6]=0;//GROUND=0
assign channels[ 7]=0;//GROUND=0
assign channels[ 8]=0;//GROUND=0
assign channels[ 9]=0;//GROUND=0
assign channels[10]=0;//GROUND=0
assign channels[11]=0;//GROUND=0
assign channels[12]=0;//GROUND=0
assign channels[13]=0;//GROUND=0
assign channels[14]=0;//GROUND=0
assign channels[15]=0;//GROUND=0

always @(*)  
begin
	if (command == 4'b0001) begin
		mode = 0;
	end else begin
		mode = 1;
	end

	if (command != 4'b0100 && command != 4'b0101) begin
		error = {1'b0,overflow};
	end else begin
		error = {dbzD,overflow};
	end

	result=b;
end

endmodule


module TestBench();
 
  reg [15:0] inputA;
  reg [15:0] inputB;
  reg [3:0] command;
  wire [31:0] result;
  wire [1:0]error;
  BreadBoard ALU(inputA,inputB,command,result,error);
  
  initial begin
    assign inputA  = 16'b0000000011111001;
	assign inputB  = 16'b0000000000000000;//16'b0000000001000101;
	assign command =  1;

	#10;
	$display("[Input A:%6d, Input B:%6d][Add:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);
  
	assign command = 2;
	#10;

	$display("[Input A:%6d, Input B:%6d][Sub:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);
	
	assign command = 3;
	#10;

	$display("[Input A:%6d, Input B:%6d][Mul:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);

	assign command = 4;
	#10;

	$display("[Input A:%6d, Input B:%6d][Div:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);
	
	assign inputA  = 16'b0111110100000000;
	assign inputB  = 16'b0010000000000001;
	assign command =  1;
	#10;

	$display("[Input A:%6d, Input B:%6d][Add:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);
  
	assign command = 2;
	#10;

	$display("[Input A:%6d, Input B:%6d][Sub:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);
	
	assign command = 3;
	#10;

	$display("[Input A:%6d, Input B:%6d][Mul:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);

	assign command = 4;
	#10;

	$display("[Input A:%6d, Input B:%6d][Div:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);

	#60; 
	$finish;
  end  
 

 
endmodule
