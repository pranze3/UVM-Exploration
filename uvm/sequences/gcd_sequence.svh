/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_sequence.svh
* Author        :   Andrew Chen
* Date          :   9/7/2025
-------------------------------------------------------------------------------------------------*/

class base_gcd_seq extends uvm_sequence #(gcd_seq_item);

    gcd_seq_item seq;
    
    // UVM Component Macro
    `uvm_object_utils(base_gcd_seq)

    // UVM Constructor
    function new(string name = "base_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW);
        `uvm_do(seq)
    endtask : body

endclass : base_gcd_seq