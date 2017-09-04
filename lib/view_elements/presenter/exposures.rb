module ViewElements
  class Presenter
    module Exposures
      def self.included base
        base.send :include, InstanceMethods
        base.extend ClassMethods
      end

      module InstanceMethods
        def expose_locals
          {}.tap do |e|
            exposes = self.class.exposes
            if exposes
              exposes.each do |name, block|
                e[name] = instance_eval(&block) unless e[name].present?
              end
            end
          end
        end
      end

      module ClassMethods
        def expose(name, &block)
          @exposes ||= {}
          @exposes[name] = block
        end

        def exposes
          @exposes
        end
      end
    end
  end
end
