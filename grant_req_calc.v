module grant_request(
    request,
    next_grant,
    clk,
    reset,
    grant,
    priorities,
    weight
);
    parameter channels=8;
    parameter width=32;
    parameter max_weight=16;

    input reset;
    input clk;

    input [channels-1:0] request;
    input [channels-1:0] next_grant;
    input [channels-1:0] priorities;
    input [width-1:0] weight;

    output reg [channels-1:0]grant;
    
    reg [1:0]state;
    reg [channels-1:0] blk_request;
    reg [width-1:0] blk_weight;
    reg [width-1:0] blk_counting;

    parameter Reset=2'b00;
    parameter Granting_process=2'b01;
    parameter get_weight=2'b10;
    parameter counting=2'b11;

    always @(posedge clk)
    begin
        if(reset)
        begin
            blk_request=0;
        end
        else
        begin
            blk_request=request;
        end
    end

    always @(posedge clk)
    begin
        if(reset)
        begin
            state<=Reset;
        end
        else
        begin
            case(state)
                Reset:
                begin
                    state<=Granting_process;
                end
                Granting_process:
                begin
                    if(grant!=0)
                    begin
                        state<=get_weight;
                    end
                    else
                    begin
                        state<=state;
                    end
                end
                get_weight:
                begin
                    state<=counting;
                end
                counting:
                begin
                    if(blk_counting>=blk_weight)
                    begin
                        state<=Granting_process;
                    end
                    else if(blk_counting>=max_weight)
                    begin
                        state<=Granting_process;
                    end
                    else
                    begin
                        state<=state;
                    end
                end
                default:
                begin
                    state<=Reset;
                end
            endcase;
        end
    end
    always @(posedge clk)
    begin
        if(reset)
        begin
            grant=0;
        end
        else
        begin
            case(state)
                Reset:
                begin
                    grant=0;
                    //grant=request*next_grant*((~next_grant)+1'b1);
                    blk_counting=0;
                    blk_weight=0;
                end
                Granting_process:
                begin
                    grant=request&next_grant&(~next_grant+1);

                    blk_counting=32'd2;
                end 
                get_weight:
                begin
                    blk_weight=weight;
                end
                counting:
                begin
                    blk_counting=blk_counting+1;
                    grant=grant;
                end
                default:
                begin
                    blk_counting=blk_counting;
                    grant=grant;
                end
            endcase;
        end
    end
endmodule


                


