/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_seq_lib.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Write more sequences extended from the provided base sequence (gcd_sequence.svh)
*      to create different test cases (ex. edge cases, randomized tests, etc) with the goal
*      to reach at least 96% coverage.
*
* A simple sequence that runs one randomized transaction is provided
-------------------------------------------------------------------------------------------------*/

// Example sequence extending the base sequence
class simple_gcd_seq extends base_gcd_seq;

    gcd_seq_item seq;
    `uvm_object_utils(simple_gcd_seq)

    function new(string name = "simple_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Executing simple sequence", UVM_LOW)
        
        if (starting_phase != null)
            starting_phase.raise_objection(this);
            
        `uvm_do(seq)
        
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask : body

endclass : simple_gcd_seq

// Random sequence - lots of random inputs
class random_gcd_seq extends base_gcd_seq;
    gcd_seq_item seq;
    `uvm_object_utils(random_gcd_seq)
    
    function new(string name = "random_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Running 50 random transactions", UVM_LOW)
        
        if (starting_phase != null)
            starting_phase.raise_objection(this);
            
        repeat(50) begin
            `uvm_do(seq)
        end
        
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask : body
endclass : random_gcd_seq

// Same numbers - testing when both inputs are equal
class same_nums_gcd_seq extends base_gcd_seq;
    gcd_seq_item seq;
    `uvm_object_utils(same_nums_gcd_seq)
    
    function new(string name = "same_nums_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Testing same numbers", UVM_LOW)
        
        if (starting_phase != null)
            starting_phase.raise_objection(this);
            
        repeat(10) begin
            `uvm_do_with(seq, {data_a == data_b;})
        end
        
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask : body
endclass : same_nums_gcd_seq

// Small numbers - checking edge cases with small values
class small_nums_gcd_seq extends base_gcd_seq;
    gcd_seq_item seq;
    `uvm_object_utils(small_nums_gcd_seq)
    
    function new(string name = "small_nums_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Testing small numbers (1-20)", UVM_LOW)
        
        if (starting_phase != null)
            starting_phase.raise_objection(this);
            
        repeat(20) begin
            `uvm_do_with(seq, {data_a inside {[1:20]}; data_b inside {[1:20]};})
        end
        
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask : body
endclass : small_nums_gcd_seq

// Large numbers - testing near the upper limit
class large_nums_gcd_seq extends base_gcd_seq;
    gcd_seq_item seq;
    `uvm_object_utils(large_nums_gcd_seq)
    
    function new(string name = "large_nums_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Testing large numbers (200-255)", UVM_LOW)
        
        if (starting_phase != null)
            starting_phase.raise_objection(this);
            
        repeat(20) begin
            `uvm_do_with(seq, {data_a inside {[200:255]}; data_b inside {[200:255]};})
        end
        
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask : body
endclass : large_nums_gcd_seq

// Powers of 2 - interesting case for binary operations
class power_of_2_gcd_seq extends base_gcd_seq;
    gcd_seq_item seq;
    `uvm_object_utils(power_of_2_gcd_seq)
    
    function new(string name = "power_of_2_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Testing powers of 2", UVM_LOW)
        
        if (starting_phase != null)
            starting_phase.raise_objection(this);
            
        repeat(10) begin
            // Constraint: x & (x-1) == 0 means x is a power of 2
            `uvm_do_with(seq, {(data_a & (data_a - 1)) == 0; 
                               (data_b & (data_b - 1)) == 0; 
                               data_a > 0; data_b > 0;})
        end
        
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask : body
endclass : power_of_2_gcd_seq

// Comprehensive - throw everything at it for max coverage
class comprehensive_gcd_seq extends base_gcd_seq;
    gcd_seq_item seq;
    `uvm_object_utils(comprehensive_gcd_seq)
    
    function new(string name = "comprehensive_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Running comprehensive test", UVM_LOW)
        
        // Raise objection at start
        if (starting_phase != null)
            starting_phase.raise_objection(this);
        
        // Lots of random cases
        repeat(100) `uvm_do(seq)
        
        // Edge case: same numbers
        repeat(10) `uvm_do_with(seq, {data_a == data_b;})
        
        // Small values
        repeat(20) `uvm_do_with(seq, {data_a inside {[1:20]}; data_b inside {[1:20]};})
        
        // Large values
        repeat(20) `uvm_do_with(seq, {data_a inside {[200:255]}; data_b inside {[200:255]};})
        
        // Powers of 2
        repeat(10) `uvm_do_with(seq, {(data_a & (data_a - 1)) == 0; 
                                      (data_b & (data_b - 1)) == 0; 
                                      data_a > 0; data_b > 0;})
        
        // Drop objection when done
        if (starting_phase != null)
            starting_phase.drop_objection(this);
            
    endtask : body
endclass : comprehensive_gcd_seq