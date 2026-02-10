module test;
    mailbox mail;

    string str;
    int i;

    string a = "abc";
    string x = "xyz";

    initial begin
        mail = new();

        fork 
            //Producer
            begin
                mail.put(a); //{"abc"}
                /*
                a: 61
                b: 62
                c: 63
                "abc" = h'616263
                */
                #2 mail.put(x); //{"xyz"}
            end

            //Consumer
            /*
                try_get() returns 3 values:
                1. Positive (>0). Success. Message Retrieved. TRUE
                2. Zero (0). Failure. Mailbox is Empty. FALSE
                3. Negative(<0). Failure. Type Missmatch. TRUE 1111
            */
            begin
            //    if (mail.try_get(str) > 0) $display("try_get PASSED!");
            //    else $display("try_get FAILED!");
               // $display("The value of try_get() = %d",mail.try_get(str));
               void'(mail.try_get(str));
                #2 mail.get(str); //{abc, xyz}
            end
        join
    end

    initial $monitor("str: %s at Time:%0t", str, $time);
endmodule
