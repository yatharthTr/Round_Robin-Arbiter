module next_grant_pre_calculator(
    request,
    grant,
    next_grant,
    reset,
    clk,
    priorities
);
    parameter channels=8;

    input reset;
    input clk;

    input [channels-1:0]request;
    input [channels-1:0]grant;
    output reg [channels-1:0]next_grant;
    output reg [channels-1:0]priorities;

    parameter Reset=2'b01;
    parameter Next_grant=2'b10;

    reg [1:0]state;

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
                    state<=Next_grant;
                end

                Next_grant:
                begin
                    state<=state;
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
            next_grant=0;
            priorities=0;
        end

        else
        begin
            case(state)
                Reset:
                begin
                    
                    priorities=~0;
                    next_grant=0;
                end

                Next_grant:
                begin
                    priorities=(~{grant[channels-2:0],grant[channels-1]})+1'b1;

                    

                    if(priorities==0)
                    begin
                        priorities=~0;
                    end

                    else
                    begin
                        priorities=priorities;
                    end
                    next_grant=request&priorities;
                    if((next_grant==0)&& (request!=0))
                    begin
                        next_grant=request;
                    end
                end

                default:
                begin
                    priorities=priorities;
                    next_grant=next_grant;
                end

            endcase;
        end
    end
endmodule







