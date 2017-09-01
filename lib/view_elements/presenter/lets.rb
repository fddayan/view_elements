module ViewElements
  class Presenter
    module Lets
      def let(name, &block)
        @lets ||= {}
        @lets[name] = block

        define_method name do
          v = instance_variable_get("@#{name}") || instance_eval(&self.class.lets[name])
          instance_variable_set("@#{name}", v)
        end
      end

      def lets
        @lets
      end
    end
  end
end
