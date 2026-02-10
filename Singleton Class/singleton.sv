typedef class singleton;

class singleton;
  int a;

  local static singleton obj;

  local function new(int a);
    this.a = a;
  endfunction

  static function singleton create(int a);
    if (obj == null) begin
        obj = new(a);
    end

    return obj;
  endfunction

  function void display();
    $display("a: %0d", a);
  endfunction
endclass

module test;
  singleton s1, s2;

  initial begin
   // s1 = new(10);
   s1 = singleton::create(10);
   s1.display();

   s2 = singleton::create(50);
   s2.display();

  end
endmodule
