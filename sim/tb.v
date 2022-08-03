`timescale 1ns/1ps

module tb ();

reg clk;
reg rst_n;

wire								sda			;
reg								sda_i			;
aht10_top u_aht10_top(
    .clk        ( clk        ),
    .rst_n      ( rst_n      ),
    .sda        ( sda        ),
    .scl        ( scl        ),
    .uart_txd   ( uart_txd   )
);
assign sda = u_aht10_top.i2c_sda_oe?1'bz:sda_i;
defparam u_aht10_top.u_i2c_master.DELAY_40MS = 400;
defparam u_aht10_top.u_i2c_master.DELAY_80MS = 800;
defparam u_aht10_top.u_i2c_master.DELAY_500MS = 5000;
localparam CLK_PERIOD = 20;
always #(CLK_PERIOD/2) clk=~clk;

reg			[ 10:0 ]			i			;
reg			[ 10:0 ]			j			;
initial begin
    rst_n<=1'b0;
    clk<=1'b0;
    # CLK_PERIOD;
    rst_n<=1;


    @(posedge u_aht10_top.u_i2c_master.init_2_check); //初始化
    for (i = 0; i<3 ; i = i+1 ) begin
        @(posedge u_aht10_top.u_i2c_master.add_cnt_byte);
    end

    for (i = 0; i<9 ; i = i+1 ) begin //模拟初始化完成
        @(posedge u_aht10_top.u_i2c_intf.add_cnt_bit)
        if(i == 3)
            sda_i = 1;
        else if(i == 8)
            sda_i = 0;
    end

    repeat(5) begin
        @(posedge u_aht10_top.u_i2c_master.wait_2_read);//等待控制模块到达读取状态
        @(posedge u_aht10_top.u_i2c_master.add_cnt_byte);
        for (i = 0; i<6 ; i = i+1 ) begin//发送6个数据
            @(posedge u_aht10_top.u_i2c_master.add_cnt_byte);
            for (j = 0; j<9 ; j = j+1 ) begin//模拟从机回数据
                @(posedge u_aht10_top.u_i2c_intf.end_cnt_scl)
                if(j == 8)
                    sda_i = 0;
                else
                    sda_i = {$random};
            end
        end
    end



    $stop;
end

endmodule