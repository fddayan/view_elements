module ViewElements
  class Presenter
    module Locals
      def define_locals_accessors!
        return unless locals.present?
        l = locals
        (class << self; self; end).class_eval do
          l.each do |k, v|
            define_method(k) { v }
          end
        end
      end
    end
  end
end
