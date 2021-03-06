module Register(input clk,
                input reset,
                input rd,
                input wn,
                input stack_en,
                input push_en,
                input pop_en,
                input [3:0] flag_en,
                input [2:0] flags_in,
                input wire [3:0] reg_id,
                input wire [15:0] write_data,
                output wire [2:0] flags_out,
                output reg [15:0] read_data);
    
    reg [15:0] register_memory[15:0];
    reg [2:0] flag_registers;


    assign flags_out = flag_registers;
    
    always @ (posedge clk) begin
        
        if (rd == 1'b1 && wn == 1'b0) begin
            read_data = register_memory[reg_id];
        end
        else if (rd == 1'b0 && wn == 1'b1)  begin
            register_memory[reg_id] = write_data;
        end
            
        if (stack_en == 1'b1 && push_en == 1'b1 && pop_en == 1'b0) begin
                register_memory[2] = register_memory[2] + 1;
        end
        else if (stack_en == 1'b1 && pop_en == 1'b1 && push_en == 1'b0) begin
                register_memory[2] = register_memory[2] - 1;
        end
    end   

    always @(posedge clk ) begin
        if(flag_en[3]) begin
            case (flag_en[2:0])
                3'b000: begin
                    flag_registers = flag_registers;
                end
                3'b001:begin
                    flag_registers[0] = flags_in[0];
                end
                3'b010:begin
                    flag_registers[1] = flags_in[1];
                end
                3'b011:begin
                    flag_registers[0] = flags_in[0];
                    flag_registers[1] = flags_in[1];
                end
                3'b100:begin
                    flag_registers[2] = flags_in[2];
                end
                3'b101:begin
                    flag_registers[0] = flags_in[0];
                    flag_registers[2] = flags_in[2];
                end
                3'b110:begin
                    flag_registers[1] = flags_in[1];
                    flag_registers[2] = flags_in[2];
                end
                3'b111:begin
                    flag_registers[0] = flags_in[0];
                    flag_registers[1] = flags_in[1];
                    flag_registers[2] = flags_in[2];
                end 
            endcase
        end
    end

endmodule
