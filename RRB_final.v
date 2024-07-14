`include "RRB_MUX.v"
`include "NGPRC.v"
`include "grant_req_calc.v"
module final_RRB(
    reset,
    clk,
    request,
    weight,
    grant,

);
    parameter width=32;
    parameter channels=8;
    

    input reset;
    input clk;

    input [channels-1:0] request;
    input[channels*width-1:0]weight;
    output wire [channels-1:0] grant;

    wire [width-1:0]get_weight;
    wire [channels-1:0] next_grant;
    wire [channels-1:0] priorities;
    
    MUX m0(
        .reset(reset),
        .clk(clk),
        .sel_one_hot(grant),
        .data_in_bus(weight),
        .data_out(get_weight)
    );

    next_grant_pre_calculator N0(
        .reset(reset),
        .clk(clk),
        .request(request),
        .grant(grant),
        .next_grant(next_grant),
        .priorities(priorities)
    );

    grant_request g0(
        .reset(reset),
        .clk(clk),
        .request(request),
        .grant(grant),
        .next_grant(next_grant),
        .priorities(priorities),
        .weight(get_weight)
    );

endmodule
