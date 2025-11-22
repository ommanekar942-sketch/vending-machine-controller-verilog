module vending_machine_testbench;
  reg clk;
  reg reset;
  reg coin_inserted;
  reg cancel;
  reg [2:0]select_the_product;
  wire refund;
  wire [5:0]change; 
  wire dispense;
  
  vending_machine VM(.clk(clk), .reset(reset), .cancel(cancel), .select_the_product(select_the_product), .refund(refund), .change(change), .dispense(dispense));
  
  initial 
    begin 
       clk=1'b0;
    end 
  
  always #5 clk = ~clk;
  
  initial 
    begin 
      reset=1'b1;
      #5 reset=1'b0;
      coin_inserted=1'b0;
      cancel=1'b0;
      select_the_product=3'b000;
      
      // when costumer select the wafers
      #10 select_the_product=3'b000;
      #10 coin_inserted=6'd10;
      #10 coin_inserted=0;
      #10;
      if(dispense) begin 
        $display("dispense the wafers");
      end 
      else begin 
        $display("Not dispense!");
      end 
      
      // when costumer select the toffes 
      #10 select_the_product=3'b001;
      #10 coin_inserted=6'd10;
      #10 coin_inserted=0;
      #10;
      if(dispense && change==6'd3) begin 
        $display("dispense the toffes and give the diffrence of 3RS");
      end 
      else begin 
        $display("Incorrect!");
      end 
      
      // when costumer select the water bottel
      #10 select_the_product=3'b010;
      #10 coin_inserted=6'd10;
      #10 coin_inserted=0;
      #10;
      if(dispense!=1) begin 
        $display("Waiting for inserting more coin");
      end 
      else begin 
        $display("Not enough money!!");
      end 
      
       // when costumer select the cold drink
      #10 select_the_product=3'b010;
      #10 coin_inserted=6'd30;
      #10 cancel=1;
      #10 cancel=0;
      #10;
      if(refund) begin 
        $display("Refund the inserted coins");
      end 
      else begin 
        $display("ERROR");
      end 
      
      #10 $finish;
    end 
  
  initial 
    begin 
      $dumpfile("VENDING_MACHINE.vcd");
      $dumpvars(0, vending_machine_testbench);
    end 
    
endmodule 
