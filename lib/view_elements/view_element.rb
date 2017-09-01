# require 'view_elements/paths'
# require 'view_elements/rendering'

module ViewElements
  class ViewElement
    include ViewElements::RailsSupport
    # include ViewElements::Rendering
    # include ViewElements::Paths

    attr_reader :action_view, :locals
    #, :view_path

    def initialize(action_view, locals = {})
      @locals = locals
      @action_view = action_view
      # @view_path = ::Rails.root.join('app', 'view_elements')

      define_locals_accessors(locals) if locals.present?
    end

    # def build_locals(locals)
    #   {}.tap do |new_locals|
    #     new_locals.merge!(locals)
    #     new_locals[:element] = self
    #     new_locals[:e] = self
    #     temp = self.expose_locals
    #     new_locals.merge!(temp) if temp
    #   end
    # end

    def helper
      @action_view
    end

    def expose_locals
      {}.tap do |e|
        exposes = self.class.exposes
        if exposes
          exposes.each do |name, block|
            e[name] = instance_eval(&block)
          end
        end
      end
    end

    def self.expose(name, &block)
      @exposes ||= {}
      @exposes[name] = block
    end

    def self.exposes
      @exposes
    end

    private

    def define_locals_accessors(locals)
      (class << self; self; end).class_eval do
        locals.each do |k, v|
          define_method(k) { v }
        end
      end
    end
  end
end
