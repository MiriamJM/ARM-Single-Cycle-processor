`timescale 1ns/1ps

module alu (input logic [31:0] a,b,
				input logic [1:0] ALUControl,
				output logic [31:0] y,
				output logic [3:0] ALUFlags);
				
				
	logic N,Z,C,V; // negative, zero, carry, overflow
	
	logic [31:0] condition;
	logic [32:0] sum;
	
	assign condition = ALUControl[0] ? ~b : b;
	assign sum = a + condition + ALUControl[0];
	
	always_comb //checks ALU control
		casex (ALUControl [1:0])
			2'b0?: y = sum[31:0];
			2'b10: y = a&b;
			2'b11: y = a|b;
		endcase
		
	assign N = y[31];
	assign Z = (y == 32'b0);
	assign C = (ALUControl[1] == 1'b0) & sum[32];
	assign V = (ALUControl[1] == 1'b0) & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);
	assign ALUFlags = {N,Z,C,V};
	
endmodule

module testbench();
	logic clk,reset;
	logic [31:0] a,b,Resultexpected;
	logic [1:0] ALUControl;
	logic [31:0] y;
	logic [3:0] ALUFlags;
	logic [31:0] vectornum, errors;
	logic [103:0] testvectors[1000:0];

	alu dut(a,b,ALUControl,y,ALUFlags);
	always
	begin
	clk = 1; #2 
	clk = 0; #2; //wait 2units
	end
	
	initial 
	begin
	$readmemh("C:/Users/miriam/Downloads/EE 425/alu.tv",testvectors); // reading testbench vectors
	vectornum = 0; errors = 0;
	reset=1; ALUControl =0;
	end
	
	always @(posedge clk) //expecting to get valid output 
	begin
	#1; {reset,ALUControl,a,b,Resultexpected,ALUFlags} = testvectors[vectornum];
	end
	
	always @(negedge clk) //expecting to get the two inputs a&b by comparing expected output to new output
	
	if(~reset) begin
	
	if(y !== Resultexpected) begin // Checking error is the output y is different from the expected output
	$display("Error: Inputs = %b ", ALUControl);
	$display("Error: Inputs = %h ", a);
	$display("Error: Inputs = %h ", b);
 
	$display("Output(RESULT) = %h (%h expected)",y,Resultexpected); //error message display
	errors = errors + 1;
	end
	
vectornum = vectornum + 1;
if (vectornum === 32'h15) begin
$display("%d tests completed with %d errors",
vectornum, errors);
$finish;
end
end
endmodule
	