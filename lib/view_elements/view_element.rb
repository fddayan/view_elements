module ViewElements
  class ViewElement
    include ViewElements::RailsSupport

    attr_reader :action_view, :locals, :view_path

    def initialize(action_view, locals = {})
      @locals = locals
      @action_view = action_view
      @view_path = ::Rails.root.join('app', 'view_elements')

      define_locals_accessors(locals) if locals.present?
    end

    def render_sub_element(sub_item_element_name, locals)
      # action_view.render file: template_path, locals: build_locals(locals), :formats=>[:html]
      # prybug
      action_view.el sub_item_path_for(sub_item_element_name), locals
    end

    def render
      # action_view.controller.append_view_path(File.dirname(template_path))
      action_view.render file: template_path, locals: build_locals(locals), formats: [:html]
    end

    private

    def sub_item_path_for(element_name)
      element_dir_path.join(element_name).to_s
    end

    def element_path
      # @element_name ||= Pathname.new(method(:render).source_location.first)
      @element_path = Pathname.new(self.class.name.underscore)
    end

    def element_dir_path
      @element_dir_path ||= element_path.dirname
    end

    def build_locals(l)
      {}.tap do |new_locals|
        new_locals.merge!(l)
        new_locals[:element] = self
        new_locals[:e] = self
        temp = expose_locals
        new_locals.merge!(temp) if temp
      end
    end

    def expose_locals
      {}
    end

    def view_path_for(path)
      view_path.join(path)
    end

    def template_path
      view_path_for(self.class.to_s.underscore)
    end

    def define_locals_accessors(locals)
      (class << self; self; end).class_eval do
        locals.each do |k, v|
          define_method(k) { v }
        end
      end
    end
  end
end
