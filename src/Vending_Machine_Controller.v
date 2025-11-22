module vending_machine(input reset, clk, [2:0]select_the_product, [5:0]coin_inserted, cancel, 
                       output reg refund, output reg [5:0]change, output reg dispense);
  
  reg [3:0]state;
  reg [5:0]total_inserted;
  reg [5:0]product_price;
  
  parameter wafers_price= 6'd10,
             toffes_price= 6'd7,
             water_bottel_price= 6'd18,
             cold_drinks_price= 6'd30,
             biscuits_price= 6'd22;
  
  parameter start=3'b000, 
  			 select_product=3'b001,
  			 insert_the_coin=3'b010,
  			 Cancel=3'b011,
  			 check_the_statements=3'b100,
  			 done=3'b101;
  
  always@(posedge clk or posedge reset) 
    begin 
      
    if(reset) 
      begin 
      state<=start;
      refund<=0;
      change<=0;
      total_inserted<=0;
      dispense<=0;
    end 
      
    else
      begin 
        
      case(state)
        start : begin 
          refund<=0;
          change<=0;
      	  total_inserted<=0;
          dispense<=0;
          state<=select_product;
        end 
        
        select_product : begin 
          case(select_the_product)
            3'b000 : product_price<=wafers_price;
            3'b001 : product_price<=toffes_price;
            3'b010 : product_price<=water_bottel_price;
            3'b011 : product_price<=cold_drinks_price;
            3'b100 : product_price<=biscuits_price;
            default : product_price=6'd0;
          endcase 
          
          state<=insert_the_coin;
        end 
        
        insert_the_coin : begin 
          if(coin_inserted) 
            begin 
            state<=check_the_statements;
            total_inserted<=total_inserted+coin_inserted;
          end 
          
          if(cancel)
            begin 
            state<=Cancel;
          end 
        end
        
        Cancel : begin 
          state<=start;
          total_inserted<=0;
          change<=0;
          refund<=1;
        end 
        
        check_the_statements : begin 
          if(product_price==total_inserted) 
            begin 
            state<=done;
          end 
          
          else if(product_price<=total_inserted) 
            begin 
            change<=total_inserted - product_price;
            state<=done;
          end 
          
          else if(product_price>=total_inserted) 
            begin 
            state<=insert_the_coin;
          end 
        end 
        
        done : begin 
          change<=0;
          dispense<=1;
          total_inserted<=0;
          refund<=0;
          state<=start;
        end 
        
      endcase 
        
    end 
      
  end 
  
endmodule 
