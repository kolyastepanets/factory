class Factory
  def initialize(*methods)
    @@all_methods = *methods.to_a

    methods.each do |method_name|
      self.class.send(:define_method, method_name) do
        self.instance_variable_get("@#{method_name}")
      end

      self.class.send(:define_method, "#{method_name}=") do |argument|
        self.instance_variable_set("@#{method_name}", argument)
      end
    end
  end

  def new(*params)
    new_params = *params.to_a
    @@all_methods.each_with_index do |er, i|
      self.instance_variable_set("@#{er}", new_params[i])
    end
  end
end

Cust = Factory.new(:a, :gfg)
Cust.new('www','ttt')






cust.a = 6
cust.gfg = 10



cust.new(5,10)




def arg[]
  //...
end


def arg[]=
  //...
end



A.arg
A.arg=(6)

C = Struct.new(:name, :address) do
      def greeting
        "Hello #{name}!"
      end
  end