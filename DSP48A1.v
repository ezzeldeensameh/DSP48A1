module DSP48A1 #(
	parameter A0REG = 1'b0 , // unregistered
	parameter A1REG = 1'b1 , // registered
	parameter B0REG = 1'b0 ,
	parameter B1REG = 1'b1 ,
	parameter CREG  = 1'b1 ,
	parameter DREG  = 1'b1 ,
	parameter MREG  = 1'b1 ,
	parameter PREG  = 1'b1 ,
	parameter CARRYINREG  = 1'b1,
	parameter CARRYOUTREG = 1'b1,
	parameter OPMODEREG   = 1'b1,
	parameter CARRYINSEL  =  "OPMODE5",
	parameter B_INPUT     =   "DIRECT",
	parameter RSTTYPE     =  "ASYNC",   
	parameter WIDTH       = 18,
	parameter WIDTH_2     = 48
	)(
	input wire [WIDTH-1:0] A,
	input wire [WIDTH-1:0] B,
	input wire [WIDTH_2-1:0] C,
	input wire [WIDTH-1:0] D,
	input wire CARRYIN,
	input wire CLK,
	input wire [7:0] OPMODE,
	input wire CEA,
	input wire CEB,
	input wire CEC,
	input wire CECARRYIN,
	input wire CED,
	input wire CEM,
	input wire CEOPMODE,
	input wire CEP,
	input wire RSTA,
	input wire RSTB,
	input wire RSTC,
	input wire RSTCARRYIN,
	input wire RSTD,
	input wire RSTM,
	input wire RSTOPMODE,
	input wire RSTP,
	input wire   [WIDTH-1:0] BCIN,
	input wire   [WIDTH_2-1:0] PCIN,
	output wire  [WIDTH-1:0] BCOUT,
	output wire  [WIDTH_2-1:0] PCOUT,
	output wire  [WIDTH*2-1:0] M,
	output wire  [WIDTH_2-1:0] P,
	output wire  CARRYOUT,
	output wire  CARRYOUTF
	);
	wire [WIDTH-1:0] D_MUX;
	wire [WIDTH-1:0] B_MUX;
	wire [WIDTH-1:0] B0_MUX;
	wire [WIDTH-1:0] A0_MUX;
	wire [WIDTH_2-1:0] C_MUX;
	wire [WIDTH-1:0]  D1;
	wire [WIDTH-1:0] Pre_Addr_in_1;
	wire [WIDTH-1:0] Pre_Addr_in_2;
	wire [WIDTH-1:0] Pre_Addr_out;
	wire [WIDTH-1:0] Pre_Addr_MUX;
	wire [WIDTH-1:0] B1_MUX;
	wire [WIDTH-1:0] A1_MUX;
	wire [WIDTH-1:0] A1;
	wire [WIDTH-1:0] B1;
	wire [WIDTH_2-1:0] D_A_B;
	wire [WIDTH-1:0] MULT_in_1;
	wire [WIDTH-1:0] MULT_in_2;
	wire [WIDTH*2-1:0] MULT_out;
	wire [WIDTH*2-1:0] M_MUX;
	wire [WIDTH*2-1:0] M_BUF;
	wire [WIDTH_2-1:0]  X;
	wire [WIDTH_2-1:0] Z;
	wire CYI;
	wire CYO;
	wire CIN;
	wire [WIDTH_2-1:0] post_addr_out;
	wire COUT;
	wire [WIDTH_2-1:0] P_1;
	wire [7:0] OPMODE_M;

FF_MUX #(.WIDTH(8),.RSTTYPE(RSTTYPE),.SEL(OPMODEREG)) R1 (.CLK(CLK),.RST(RSTOPMODE),.D(OPMODE),.EN(CEOPMODE),.MUX_OUT(OPMODE_M));
FF_MUX #(.WIDTH(WIDTH),.RSTTYPE(RSTTYPE),.SEL(DREG)) R2 (.CLK(CLK),.RST(RSTD),.D(D),.EN(CED),.MUX_OUT(D_MUX));
assign Pre_Addr_in_1 = D_MUX;
assign D1 = D_MUX;
assign B_MUX = (B_INPUT == "DIRECT") ? B : (B_INPUT == "CASCADE") ? BCIN : 'b0;
FF_MUX #(.WIDTH(WIDTH),.RSTTYPE(RSTTYPE),.SEL(B0REG)) R3 (.CLK(CLK),.RST(RSTB),.D(B_MUX),.EN(CEB),.MUX_OUT(B0_MUX));
assign Pre_Addr_in_2 = B0_MUX;
assign Pre_Addr_out = (OPMODE_M[6] == 1'b1) ? (Pre_Addr_in_1 - Pre_Addr_in_2) : (Pre_Addr_in_1 + Pre_Addr_in_2);
assign Pre_Addr_MUX = (OPMODE_M[4] == 1'b1) ? (Pre_Addr_out) : (B0_MUX) ;
FF_MUX #(.WIDTH(WIDTH),.RSTTYPE(RSTTYPE),.SEL(A0REG)) R4 (.CLK(CLK),.RST(RSTA),.D(A),.EN(CEA),.MUX_OUT(A0_MUX));
FF_MUX #(.WIDTH(WIDTH),.RSTTYPE(RSTTYPE),.SEL(A1REG)) R5 (.CLK(CLK),.RST(RSTA),.D(A0_MUX),.EN(CEA),.MUX_OUT(A1_MUX));
FF_MUX #(.WIDTH(WIDTH),.RSTTYPE(RSTTYPE),.SEL(B1REG)) R6 (.CLK(CLK),.RST(RSTB),.D(Pre_Addr_MUX),.EN(CEB),.MUX_OUT(B1_MUX));
assign A1 = A1_MUX;
assign B1 = B1_MUX;
assign BCOUT = B1;
assign MULT_in_1 = B1_MUX ;
assign MULT_in_2 = A1_MUX ;
assign MULT_out = (MULT_in_1 * MULT_in_2);
assign D_A_B = {D1[11:0],A1[17:0],B1[17:0]};
FF_MUX #(.WIDTH(36),.RSTTYPE(RSTTYPE),.SEL(MREG)) R7 (.CLK(CLK),.RST(RSTM),.D(MULT_out),.EN(CEM),.MUX_OUT(M_MUX));
assign M_BUF = M_MUX;
assign M = ~ (~M_BUF);
FF_MUX #(.WIDTH(WIDTH_2),.RSTTYPE(RSTTYPE),.SEL(CREG)) R8 (.CLK(CLK),.RST(RSTC),.D(C),.EN(CEC),.MUX_OUT(C_MUX));
assign CYI = (CARRYINSEL == "CARRYIN") ? CARRYIN : (CARRYINSEL == "OPMODE5") ? OPMODE_M[5] : 'b0;
FF_MUX #(.WIDTH(1),.RSTTYPE(RSTTYPE),.SEL(CARRYINREG)) R9 (.CLK(CLK),.RST(RSTCARRYIN),.D(CYI),.EN(CECARRYIN),.MUX_OUT(CIN));
FF_MUX #(.WIDTH(WIDTH_2),.RSTTYPE(RSTTYPE),.SEL(PREG)) R10 (.CLK(CLK),.RST(RSTP),.D(post_addr_out),.EN(CEP),.MUX_OUT(P_1));
assign P = P_1;
assign PCOUT = P;
assign X = (OPMODE_M[1:0] == 2'b00) ? 'b0 :
           (OPMODE_M[1:0] == 2'b01) ? {12'd0, M_MUX} :
           (OPMODE_M[1:0]==2'b10)? PCOUT:
           (OPMODE_M[1:0] == 2'b11) ? D_A_B:
           'b0;
assign Z =(OPMODE_M[3:2]==2'b00)? 'b0:
          (OPMODE_M[3:2]==2'b01)? PCIN:
          (OPMODE_M[3:2]==2'b10)? P:
          (OPMODE_M[3:2]==2'b11)? C_MUX:
           'b0;
assign {CYO,post_addr_out} = (OPMODE_M[7] == 1'b1) ? (Z-(X+CIN)) : (Z + X + CIN) ;

FF_MUX #(.WIDTH(1),.RSTTYPE(RSTTYPE),.SEL(CARRYOUTREG)) R11 (.CLK(CLK),.RST(RSTCARRYIN),.D(CYO),.EN(CECARRYIN),.MUX_OUT(COUT));

assign CARRYOUT = COUT;
assign CARRYOUTF = CARRYOUT;


	
endmodule