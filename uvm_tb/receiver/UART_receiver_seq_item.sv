

class UART_receiver_seq_item extends uvm_sequence_item;
    `uvm_object_utils (UART_receiver_seq_item)
    function  new(string name = "UART_receiver_seq_item");
       super.new(name);
    endfunction
	rand bit [9:0] rx;
	bit ready;
	bit [7:0] data;
    bit reset_n;
	
	
    virtual function void do_copy(uvm_object rhs);
      UART_receiver_seq_item item_rhs;
      if(!$cast(item_rhs, rhs) )begin `uvm_fatal("NOTCAST","the source type is not comptable with dest. type"); end
        //super.do_copy(rhs);
    
     	rx = item_rhs.rx;
		 data = item_rhs.data;
		 ready = item_rhs.ready;
	
     endfunction //do_copy
	 
	 
	 
	 
	 
     virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
      UART_receiver_seq_item item_rhs;
      if(!$cast(item_rhs, rhs)) `uvm_fatal("NOTCAST","the source type is not comptable with dest. type");

       if ( 
                (data  ==  item_rhs.data) &&
                (ready    ==  item_rhs.ready)   &&
                (rx   ==  item_rhs.rx) )begin return 1'b1; end
				else begin  return 1'b0; end
   
     endfunction //do_compare
  
  
  
  
  virtual function void do_convert2string();
   
     $display( " data             : %0d  \n",  data);
     $display( " ready            : %0d  \n",  ready);
     $display( " rx               : %0d  \n",  rx);
    
  endfunction: do_convert2string

endclass

