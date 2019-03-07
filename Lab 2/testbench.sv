module testbench();
	logic clk,reset;
	logic [31:0] a,b,Resultexpected;
	logic [1:0] ALUControl;
	logic [31:0] y;
	logic [3:0] ALUFlags;
	logic [31:0] vectornum, errors;
	logic [103:0] testvectors[10000:0];

	alu dut(a,b,ALUControl,y,ALUFlags);
	always
	begin
	clk = 1; #2 clk = 0; #2; //wait 2units
	end
	
	initial 
	begin
	$readmemh("alu.tv",testvectors);
	vectornum = 0; errors = 0;
	reset=1; #2; reset=0;
	end
	
	always @(posedge clk)
	begin
	#1; {ALUControl,a,b,Resultexpected,ALUFlags} = testvectors[vectornum];
	end
	
	always @(negedge clk)
	
	if(~reset) begin
	
	if(Result !== Resultexpected) begin
	$display("Error: Inputs = %b ", ALUControl);
	$display("Error: Inputs = %h ", a);
	$display("Error: Inputs = %h ", b);
 
	$display("Output(RESULT) = %h (%h expected)",y,Resultexpected);
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
	