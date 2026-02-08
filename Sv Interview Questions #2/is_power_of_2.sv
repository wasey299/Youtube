// Function that will return 1(true) if the number is a power of two else it will return 0(false.)
function automatic bit is_power_of_2(int a);
   // return ($countones(a) == 1)  && (a != 0);
   return (a != 0) && ((a & (a - 1)) == 0);
endfunction
/* 
1 = 2^0: 1
2 = 10
4 = 100
8 = 1000
16 = 10000
*/

/*
1 - 1 = 0 
1 & 0 = 0

10 - 1 = 01
10 & 01 = 0

100 - 1 = 011
100 & 011 = 0

1000 - 1 = 0111
1000 & 0111 = 0

10000 - 1 = 01111
10000 & 01111 =0
*/
module test;
    int a;

    initial begin
        a = 171;

        if(is_power_of_2(a)) $display("The number:%0d is a power of 2", a);
        else $display("The number:%0d is not a power of 2", a);
    end
endmodule
