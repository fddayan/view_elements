module ViewElements
  class Renderer
    attr_reader :action_view, :template, :locals

    def initialize(action_view, template, locals)
      @action_view = action_view
      @template = template
      @locals = locals
    end

    def render
      action_view.render file: template, locals: locals, formats: [:html]
    end
  end
end
