class cons1;
    rand bit [7:0] a;
    rand bit [7:0] b;

   // rand bit [1:0] sel;

    // constraint sel_c {
    //     $onehot(sel) == 1; //01 or 10
    // }

    // constraint main_c {
    //     {$onehot(a),$onehot(b)} == sel; //01? $onehot(a) = 0, $onehot(b) = 1  
    //                                    //10? $onehot(a) = 1, $onehot(b) = 0   
    //     }

    constraint main_c {
        $onehot({$onehot(a), $onehot(b)});//2'b10  $onehot(a) = 1, $onehot(b) = 0
                                        //  2'b01   $onehot(a) = 0, $onehot(b) = 1
    }
    function void post_randomize();
        $display("a = %b\tb = %b", a, b,/* sel*/);
    endfunction
endclass

module test;
    cons1 c1;

    initial begin
        c1 = new();
       repeat(10) assert(c1.randomize) else $error("RAND FAILED");
    end
endmodule
