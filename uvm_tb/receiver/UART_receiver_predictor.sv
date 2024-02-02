
class UART_receiver_predictor extends uvm_subscriber #(UART_receiver_seq_item);
   `uvm_component_utils(UART_receiver_predictor)
   function  new(string name = "UART_receiver_predictor",uvm_component parent);
     super.new(name,parent);
   endfunction
   // han a built in analysis export
 string s; 
   uvm_analysis_port #(UART_receiver_seq_item) expected_port;
   

   virtual function void build_phase(uvm_phase phase);
         expected_port = new("expected_port",this);
   endfunction
 virtual  function  void write (UART_receiver_seq_item t);
             UART_receiver_seq_item expected_item;
             if(!$cast(expected_item,t)) `uvm_fatal("WRONG_OBJECT","the object type is not compatible ");
                    expected_item.do_copy(t);
                     if (expected_item.rx[0] == 0) begin
					       expected_item.data = expected_item.rx[8:1];
					      
					    end
                                           
                     expected_item.ready = 1'b1;
				      end
		
		
		end ///else

//          $display("  *********************************************************** \n");
//        $display(" at predictor expected item as string: ");        
//        expected_item.do_convert2string();
//$display("  *********************************************************** \n");
        expected_port.write(expected_item);
        
   endfunction   




endclass










