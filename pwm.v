
module pwm ( clk,pwm_out); 

input wire clk; // Clock pin 17
output wire pwm_out; // Desired pwm output pin
reg[15:0] counter; //Counter
reg[15:0] compare; //Compare variable used to determine duty cycle
reg[15:0] pwm; //Auxiliary variable
reg[15:0] timReset = 16'd20000 ; // Timer reset value

always@( posedge clk )
begin
//--------------------------------------------------------//
// T = 1/fclk * timReset
// T - pwm period
// fclk - clock frequency 50Mhz -> 20ns
// timReset - timer resets when it reaches this value
//--------------------------------------------------------//
compare<=16'd10000; // duty cycle  (0% - 100%) -> (0 - 20000)  
if( counter<compare ) 
begin
pwm<=16'b1;
counter<=counter+16'd1;
end

else if( counter >= compare && counter < timReset ) //Frequency 2.5kHz

begin
counter<=counter+16'd1;
pwm<=16'b0;
end

else //Counter reset
counter<=16'd0;

end
assign pwm_out =pwm;
endmodule
