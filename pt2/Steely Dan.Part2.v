
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
input [127:0][31:0] channels;
input      [15:0] select;
output      [31:0] b;
wire  [127:0][31:0] channels;
wire        [31:0] b;


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
			   ({16{select[ 3]}} & channels[ 3]) |
			   ({16{select[ 2]}} & channels[ 2]) | 
               ({16{select[ 1]}} & channels[ 1]) |
               ({16{select[ 0]}} & channels[ 0]) ;

endmodule


module BreadBoard(inputA,inputB,command,result,error);
input [15:0]inputA;
input [15:0]inputB;
input [3:0]command;
output [31:0]result;
output error;
wire [15:0]inputA;
wire [15:0]inputB;
wire [3:0]command;
reg [31:0]result;
reg error;


//Local Variables
//Full Adder
reg mode;
wire [31:0] sum;
wire carry;
wire overflow;

//Multiplexer
wire [127:0][31:0] channels;
wire [15:0] onehotMux;
wire [31:0] b;

DEC DecAlpha(command,onehotMux);
ADD_SUB nept(inputA,inputB,mode,sum,carry,overflow);
MUX satu(channels,onehotMux,b);



assign channels[ 0]=0;//GROUND=0
assign channels[ 1]=sum;//Addition
assign channels[ 2]=sum;//Subtraction
assign channels[ 3]=0;//mult;//Multiplication
assign channels[ 4]=0;//div;//Division
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
	mode=command[1];
	result=b;
	error=overflow;
end

endmodule


module TestBench();
 
  reg [15:0] inputA;
  reg [15:0] inputB;
  reg [3:0] command;
  wire [31:0] result;
  wire error;
  BreadBoard BB8(inputA,inputB,command,result,error);
   
  reg k1,k2,k3,k4,k5;
  reg segA,segB,segC,segD,segE,segF,segG;
  reg [7:0] charA;
  
  initial begin
    assign inputA  = 32000;
	assign inputB  = 16000;
	assign command = 1;
	

	#10;
	$display("[Input A:%6d, Input B:%6d][Add:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);
  
	assign command = 2;
	#10;

	$display("[Input A:%6d, Input B:%6d][Sub:%b][Output:%10d, Error: %b]",inputA,inputB,command,result,error);

	#60; 
	$finish;
  end  
 

 
endmodule  
