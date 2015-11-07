class Factory

  def self.new(*params, &block)
    Class.new do

      params.each do |param|
        define_method "#{param}" do
          instance_variable_get("@#{param}")
        end

        define_method "#{param}=" do |argument|
          instance_variable_set("@#{param}", argument)
        end
      end

      define_method :initialize do |*arguments|
          @@arguments = arguments
          params.each_with_index do |param, i|
          instance_variable_set("@#{param}", arguments[i])
        end
      end

      define_method("[]") do |index|
        if index.is_a?(Integer)
          index = params[index]
          instance_variable_get("@#{index}")
        elsif index.is_a?(String) || index.is_a?(Symbol)
          index = index.to_sym
          instance_variable_get("@#{index}")
        else
          raise NameError
        end
      end

      define_method("[]=") do |index, val|
        if index.is_a?(Integer)
          index = params[index]
          instance_variable_set("@#{index}", val)
        elsif index.is_a?(String) || index.is_a?(Symbol)
          index = index.to_sym
          instance_variable_set("@#{index}", val)
        else
          raise NameError
        end
      end

      # define_method "==" do |other|

      # end

    class_eval(&block) unless block.nil?
    end
  end

end

Qw = Factory.new(:a, :b) do
  def greeting
    "Hello #{a}!"
  end
end
Qw.new("Dave", 123).greeting
jo = Qw.new(1,2)

jo.a
jo["a"]
jo[:a]
jo[0]
jo[:a] = 3
jo[0] = 1

# jor = Qw.new(1,2)
# jo == jor