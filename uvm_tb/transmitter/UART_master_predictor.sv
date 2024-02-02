
class UART_master_predictor extends uvm_subscriber #(UART_master_seq_item);
   `uvm_component_utils(UART_master_predictor)
   function  new(string name = "UART_master_predictor",uvm_component parent);
     super.new(name,parent);
   endfunction
   // han a built in analysis export
 string s; 
   uvm_analysis_port #(UART_master_seq_item) expected_port;
   

   virtual function void build_phase(uvm_phase phase);
         expected_port = new("expected_port",this);
   endfunction
 virtual  function  void write (UART_master_seq_item t);
             UART_master_seq_item expected_item;
             if(!$cast(expected_item,t)) `uvm_fatal("WRONG_OBJECT","the object type is not compatible ");
                    expected_item.do_copy(t);
       if (~expected_item.reset_n) begin
                      expected_item.ready = 1'b1;     
                      expected_item.TX = 1'b1;
                    end //reset_n
		else begin
		        if(expected_item.send) begin
				     expected_item.ready=1'b0;
				     expected_item.TX = 1'b0;					 
				     for (int i = 0; i<8;i=i+1) begin
					    
						  expected_item.TX= expected_item.data[i];
                      end 				
					 expected_item.TX = 1'b1;
				end  else begin
				       expected_item.ready=1'b1;
					   expected_item.TX=1'b1;
				      end
		
		
		end ///else

//          $display("  *********************************************************** \n");
//        $display(" at predictor expected item as string: ");        
//        expected_item.do_convert2string();
//$display("  *********************************************************** \n");
        expected_port.write(expected_item);
        
   endfunction   




endclass










