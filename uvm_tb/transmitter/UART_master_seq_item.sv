

class UART_master_seq_item extends uvm_sequence_item;
    `uvm_object_utils (UART_master_seq_item)
    function  new(string name = "UART_master_seq_item");
       super.new(name);
    endfunction
    rand bit [7:0] data;
	rand bit send;
	bit ready;
	bit TX;
    bit reset_n;
	
	
    virtual function void do_copy(uvm_object rhs);
      UART_master_seq_item item_rhs;
      if(!$cast(item_rhs, rhs) )begin `uvm_fatal("NOTCAST","the source type is not comptable with dest. type"); end
        //super.do_copy(rhs);
         data = item_rhs.data;
		 send = item_rhs.send;
		 ready = item_rhs.ready;
		 TX = item_rhs.TX;
     endfunction //do_copy
	 
	 
	 
	 
	 
     virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
      UART_master_seq_item item_rhs;
      if(!$cast(item_rhs, rhs)) `uvm_fatal("NOTCAST","the source type is not comptable with dest. type");

       if ( 
                (data  ==  item_rhs.data) &&
                (send   ==  item_rhs.send)   &&
                (ready    ==  item_rhs.ready)   &&
                (TX   ==  item_rhs.TX) )begin return 1'b1; end
				else begin  return 1'b0; end
   
     endfunction //do_compare
  
  
  
  
  virtual function void do_convert2string();
   
     $display( " data             : %0d  \n",  data);
     $display( " send     : %0d  \n",  send);
     $display( " ready          : %0d  \n",  ready);
     $display( " TX          : %0d  \n",  TX);
    
  endfunction: do_convert2string

endclass

