    /*-----------------------------------------------------------------------------------------------
    * File Name     :   gcd_test_lib.sv
    * Author        :   Andrew Chen
    * Date          :   9/7/2025
    * Tasks to complete here:
    *   1. Write more tests extended from the provided base test (gcd_base_test.svh)
    *      to create different tests that run your different sequences.
    -------------------------------------------------------------------------------------------------*/

    // Example test that runs the simple example sequence
    class simple_gcd_test extends base_gcd_test;

        // UVM Component Macro
        `uvm_component_utils(simple_gcd_test)

        // UVM Constructor
        function new(string name = "simple_gcd_test", uvm_component parent=null);
            super.new(name,parent);
        endfunction : new

        // Build phase
        virtual function void build_phase(uvm_phase phase);
            // Set the default sequence for the agent's sequencer
            uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                    "default_sequence",
                                    simple_gcd_seq::get_type());
            // Call the base class build_phase to create the testbench
            super.build_phase(phase);
        endfunction : build_phase

    endclass : simple_gcd_test


    // Test 2: Random test
    class random_gcd_test extends base_gcd_test;
        `uvm_component_utils(random_gcd_test)

        function new(string name = "random_gcd_test", uvm_component parent=null);
            super.new(name,parent);
        endfunction : new

        virtual function void build_phase(uvm_phase phase);
            uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                    "default_sequence",
                                    random_gcd_seq::get_type());
            super.build_phase(phase);
        endfunction : build_phase
    endclass : random_gcd_test

    // Test 3: Same numbers test
    class same_nums_gcd_test extends base_gcd_test;
        `uvm_component_utils(same_nums_gcd_test)

        function new(string name = "same_nums_gcd_test", uvm_component parent=null);
            super.new(name,parent);
        endfunction : new

        virtual function void build_phase(uvm_phase phase);
            uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                    "default_sequence",
                                    same_nums_gcd_seq::get_type());
            super.build_phase(phase);
        endfunction : build_phase
    endclass : same_nums_gcd_test

    // Test 4: Small numbers test
    class small_nums_gcd_test extends base_gcd_test;
        `uvm_component_utils(small_nums_gcd_test)

        function new(string name = "small_nums_gcd_test", uvm_component parent=null);
            super.new(name,parent);
        endfunction : new

        virtual function void build_phase(uvm_phase phase);
            uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                    "default_sequence",
                                    small_nums_gcd_seq::get_type());
            super.build_phase(phase);
        endfunction : build_phase
    endclass : small_nums_gcd_test

    // Test 5: Large numbers test
    class large_nums_gcd_test extends base_gcd_test;
        `uvm_component_utils(large_nums_gcd_test)

        function new(string name = "large_nums_gcd_test", uvm_component parent=null);
            super.new(name,parent);
        endfunction : new

        virtual function void build_phase(uvm_phase phase);
            uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                    "default_sequence",
                                    large_nums_gcd_seq::get_type());
            super.build_phase(phase);
        endfunction : build_phase
    endclass : large_nums_gcd_test

    // Test 6: Powers of 2 test
    class power_of_2_gcd_test extends base_gcd_test;
        `uvm_component_utils(power_of_2_gcd_test)

        function new(string name = "power_of_2_gcd_test", uvm_component parent=null);
            super.new(name,parent);
        endfunction : new

        virtual function void build_phase(uvm_phase phase);
            uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                    "default_sequence",
                                    power_of_2_gcd_seq::get_type());
            super.build_phase(phase);
        endfunction : build_phase
    endclass : power_of_2_gcd_test

    // Test 7: Comprehensive test - run this for max coverage!
    class all_gcd_test extends base_gcd_test;
        `uvm_component_utils(all_gcd_test)

        function new(string name = "all_gcd_test", uvm_component parent=null);
            super.new(name,parent);
        endfunction : new

        virtual function void build_phase(uvm_phase phase);
            uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                                    "default_sequence",
                                    comprehensive_gcd_seq::get_type());
            super.build_phase(phase);
        endfunction : build_phase
    endclass : all_gcd_test