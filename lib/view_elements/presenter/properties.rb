module ViewElements
  class Presenter
    module Properties
      def self.included base
        base.send :include, InstanceMethods
        base.extend ClassMethods
      end

      module ClassMethods
        def properties_list
          @properties
        end

        def properties(*args)
          @properties = args
        end
      end

      module InstanceMethods
        def validate_properties!
          return unless self.class.properties_list.present?

          missing_properties = _calc_missing_properties(locals)

          raise "Missing #{missing_properties.to_sentence} propertie(s) for #{self.class} component." if missing_properties.present?
        end

        private

        def _calc_missing_properties(locals)
          if locals.present?
            self.class.properties_list.map(&:to_s) - locals.keys.map(&:to_s)
          else
            self.class.properties_list.map(&:to_s)
          end
        end
      end
    end
  end
end
