module FF_MUX #(
    parameter WIDTH = 18,
    parameter RSTTYPE = "SYNC",
    parameter SEL = 1 // 1 = registered (FF), 0 = bypass (pure wire)
)(
    input  wire                CLK,
    input  wire                RST,
    input  wire [WIDTH-1:0]    D,
    input  wire                EN,
    output wire [WIDTH-1:0]    MUX_OUT
);

generate
    if (SEL == 1) begin : GEN_FF  // Registering enabled
        reg [WIDTH-1:0] Q;

        if (RSTTYPE == "ASYNC") begin : ASYNC_RST
            always @(posedge CLK or posedge RST) begin
                if (RST)
                    Q <= {WIDTH{1'b0}};
                else if (EN)
                    Q <= D;
            end
        end else begin : SYNC_RST
            always @(posedge CLK) begin
                if (RST)
                    Q <= {WIDTH{1'b0}};
                else if (EN)
                    Q <= D;
            end
        end

        assign MUX_OUT = Q;

    end else begin : GEN_BYPASS  // Bypassed FF
        assign MUX_OUT = D;
    end
endgenerate

endmodule
