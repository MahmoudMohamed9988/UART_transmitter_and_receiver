class UART_master_seq extends uvm_sequence #(UART_master_seq_item);
   `uvm_object_utils(UART_master_seq)
     function  new(string name = "UART_master_seq");
       super.new(name);
       if(!this.randomize()) `uvm_fatal("NO_SEQ_RAND","the randomization of no. ofo item in sequence is failed");
    endfunction
    rand bit [15:0] block_size;
    UART_master_seq_item my_item;
    virtual task body();
       `uvm_info("UART_master_seq","hello from UART_master_seq", UVM_LOW );
          
      repeat(2000) begin
            
            my_item = UART_master_seq_item::type_id::create("my_item");
            start_item(my_item);
            if(!my_item.randomize()) `uvm_fatal("NO_ITEM","the randomization of item is failed");
           finish_item(my_item);
           
         end
    endtask


endclass
