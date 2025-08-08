module DSP48A1_tb ();

	parameter A0REG = 1'b0 ; // unregistered
	parameter A1REG = 1'b1 ; // registered
	parameter B0REG = 1'b0 ;
	parameter B1REG = 1'b1 ;
	parameter CREG  = 1'b1 ;
	parameter DREG  = 1'b1 ;
	parameter MREG  = 1'b1 ;
	parameter PREG  = 1'b1 ;
	parameter CARRYINREG  = 1'b1;
	parameter CARRYOUTREG = 1'b1;
	parameter OPMODEREG   = 1'b1;
	parameter CARRYINSEL  =  "OPMODE5";
	parameter B_INPUT     =   "DIRECT";
	parameter RSTTYPE     =  "SYNC";   
	parameter WIDTH       = 18;
	parameter WIDTH_2     = 48;

reg [WIDTH-1:0] A_tb;
reg [WIDTH-1:0] B_tb;
reg [WIDTH_2-1:0] C_tb;
reg [WIDTH-1:0] D_tb;
reg CLK_tb;
reg [7:0] OPMODE_tb;
reg CEA_tb;
reg CEB_tb;
reg CEC_tb;
reg CECARRYIN_tb;
reg CED_tb;
reg CEM_tb;
reg CEOPMODE_tb;
reg CEP_tb;
reg RSTA_tb;
reg RSTB_tb;
reg RSTC_tb;
reg RSTCARRYIN_tb;
reg RSTD_tb;
reg RSTM_tb;
reg RSTOPMODE_tb;
reg RSTP_tb;

reg [WIDTH-1:0] BCIN_tb;
reg [WIDTH_2-1:0] PCIN_tb;
reg CARRYIN_tb;
wire [WIDTH*2-1:0] M_tb;
wire [WIDTH_2-1:0] P_tb;
wire  CARRYOUT_tb;
wire  CARRYOUTF_tb;
wire [WIDTH_2-1:0] PCOUT_tb;
wire [WIDTH-1:0] BCOUT_tb;

DSP48A1 #(

    .A0REG(A0REG),
    .B0REG(B0REG),
    .CREG(CREG),
    .A1REG(A1REG),
    .B1REG(B1REG),
    .DREG(DREG),
    .MREG(MREG),
    .PREG(PREG),
    .CARRYINREG(CARRYINREG),
    .CARRYOUTREG(CARRYOUTREG),
    .OPMODEREG(OPMODEREG),
    .CARRYINSEL(CARRYINSEL),
    .B_INPUT(B_INPUT),
    .RSTTYPE(RSTTYPE),
    .WIDTH(WIDTH),
    .WIDTH_2(WIDTH_2)

)
DUT (

    .A(A_tb),
    .B(B_tb),
    .C(C_tb),
    .D(D_tb),
    .CARRYIN(CARRYIN_tb),
    .M(M_tb),
    .P(P_tb),
    .CARRYOUT(CARRYOUT_tb),
    .CARRYOUTF(CARRYOUTF_tb),
    .CLK(CLK_tb),
    .OPMODE(OPMODE_tb),
    .CEA(CEA_tb),
    .CEB(CEB_tb),
    .CEC(CEC_tb),
    .CECARRYIN(CECARRYIN_tb),
    .CED(CED_tb),
    .CEOPMODE(CEOPMODE_tb),
    .CEM(CEM_tb),
    .CEP(CEP_tb),
    .RSTA(RSTA_tb),
    .RSTB(RSTB_tb),
    .RSTC(RSTC_tb),
    .RSTCARRYIN(RSTCARRYIN_tb),
    .RSTD(RSTD_tb),
    .RSTM(RSTM_tb),
    .RSTOPMODE(RSTOPMODE_tb),
    .RSTP(RSTP_tb),
    .BCOUT(BCOUT_tb),
    .BCIN(BCIN_tb),
    .PCIN(PCIN_tb),
    .PCOUT(PCOUT_tb)

);
initial begin
       CLK_tb = 0;
    forever begin
     
    #5 CLK_tb = ~CLK_tb;
end
end

initial begin
    
    
    RSTA_tb = 1;
    RSTB_tb = 1;
    RSTC_tb = 1;
    RSTD_tb = 1;
    RSTCARRYIN_tb = 1;
    RSTM_tb = 1;
    RSTOPMODE_tb = 1;
    RSTP_tb = 1;
    A_tb = $random;
    B_tb = $random;
    C_tb = $random;
    D_tb = $random;
    OPMODE_tb = $random;
    CEA_tb = $random;
    CEB_tb = $random;
    CEC_tb = $random;
    CECARRYIN_tb = $random;
    CEM_tb = $random;
    CED_tb = $random;
    CEOPMODE_tb = $random;
    CEP_tb = $random;
    BCIN_tb = $random;
    PCIN_tb = $random;
    CARRYIN_tb = $random;

    @(negedge CLK_tb);
    if((M_tb!= 'b0)||(P_tb != 'b0)||(PCOUT_tb != 'b0)||(BCOUT_tb != 'b0)||(CARRYOUT_tb != 'b0)||(CARRYOUTF_tb != 'b0)) begin
        $display("Error In RST OPERATION RSTM = %d,RSTP = %d, RSTCARRYIN =%d,RSTA= %d,RSTB = %d,RSTC = %d, RSTD = %d,RSTOPMODE =%d",
        RSTM_tb,RSTP_tb,RSTCARRYIN_tb,RSTA_tb,RSTB_tb,RSTC_tb,RSTD_tb,RSTOPMODE_tb);
        $stop;
    end
    else begin
        $display("Test Case 1 is PASSED");
    end
   
    //Desassert All RSTS
    RSTA_tb = 1'b0;
    RSTB_tb = 1'b0;
    RSTC_tb = 1'b0;
    RSTD_tb = 1'b0;
    RSTCARRYIN_tb = 1'b0;
    RSTM_tb = 1'b0;
    RSTOPMODE_tb = 1'b0;
    RSTP_tb = 1'b0;
    //Enable Clock Signals
    CEA_tb = 1'b1;
    CEB_tb = 1'b1;
    CEC_tb = 1'b1;
    CECARRYIN_tb = 1'b1;
    CEM_tb = 1'b1;
    CED_tb = 1'b1;
    CEOPMODE_tb = 1'b1;
    CEP_tb = 1'b1;
    
////////////////////////////////////////////Test Case 2//////////////////////////////////////
    OPMODE_tb = 8'b11011101;
    A_tb = 20;
    B_tb = 10;
    C_tb = 350;
    D_tb = 25;
   
        BCIN_tb = $random ; 
        CARRYIN_tb = $random ; 
        PCIN_tb = $random;
    repeat(4) @(negedge CLK_tb);
    if((BCOUT_tb != 'hf )|| (M_tb != 'h12c)||(P_tb != 'h32 )||( PCOUT_tb != 'h32)|| (CARRYOUT_tb != 'b0)||( CARRYOUTF_tb != 'b0)) begin
        $display("Error in Verifying DSP Path 1");
        $stop;
    end
$display("Test CASE 2 PASSED");
////////////////////////////////////////////Test Case 3//////////////////////////////////////
    OPMODE_tb = 8'b00010000;
    A_tb = 20;
    B_tb = 10;
    C_tb = 350;
    D_tb = 25;
   
        BCIN_tb = $random ; 
        CARRYIN_tb = $random ; 
        PCIN_tb = $random;
    repeat(3) @(negedge CLK_tb);
    if((BCOUT_tb != 'h23 )|| (M_tb != 'h2bc)||(P_tb != 'h0 )||( PCOUT_tb != 'h0)|| (CARRYOUT_tb != 'b0)||( CARRYOUTF_tb != 'b0)) begin
        $display("Error in Verifying DSP Path 2");
        $stop;
    end
   $display("Test CASE 3 PASSED");
////////////////////////////////////////////Test Case 4//////////////////////////////////////
    OPMODE_tb = 8'b00001010;
    A_tb = 20;
    B_tb = 10;
    C_tb = 350;
    D_tb = 25;
   
        BCIN_tb = $random ; 
        CARRYIN_tb = $random ; 
        PCIN_tb = $random;
    repeat(3) @(negedge CLK_tb);
    if((BCOUT_tb != 'ha )|| (M_tb != 'hc8)||(P_tb != 'h0 )||( PCOUT_tb != 'h0)|| (CARRYOUT_tb != 'b0)||( CARRYOUTF_tb != 'b0)) begin
        $display("Error in Verifying DSP Path 3");
        $stop;
    end
   $display("Test CASE 4 PASSED");

////////////////////////////////////////////Test Case 5//////////////////////////////////////
    OPMODE_tb = 8'b10100111;
    A_tb = 5;
    B_tb = 6;
    C_tb = 350;
    D_tb = 25;
    PCIN_tb = 3000;
        BCIN_tb = $random ; 
        CARRYIN_tb = $random ; 
       
    repeat(3) @(negedge CLK_tb);
    if((BCOUT_tb != 'h6 )|| (M_tb != 'h1e)||(P_tb != 'hfe6fffec0bb1 )||( PCOUT_tb != 'hfe6fffec0bb1)|| (CARRYOUT_tb != 'h1)||( CARRYOUTF_tb != 'h1)) begin
        $display("Error in Verifying DSP Path 4");
        $stop;
    end
   $display("Test CASE 5 PASSED");
#100
$stop;
end

initial begin
    $monitor("A=%d,B=%d,C=%d,D=%d,BCOUT =%h ,M = %h ,P = %h,PCOUT = %h,CARRYOUT = %h,CARRYOUTF = %h",A_tb,B_tb,C_tb,D_tb,BCOUT_tb,M_tb,P_tb,PCOUT_tb,CARRYOUT_tb,CARRYOUTF_tb);
end


    endmodule
