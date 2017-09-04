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

    # def build_locals
    #   {}.tap do |new_locals|
    #     new_locals.merge!(presenter.locals)
    #     new_locals[:element] = presenter
    #     new_locals[:e] = presenter
    #     new_locals[:presenter] = presenter
    #     new_locals[:p] = presenter
    #     temp = presenter.expose_locals
    #     new_locals.merge!(temp) if temp
    #   end
    # end

    # def self.render(action_view, template, presenter)
    #   new(action_view, template, presenter).render
    # end

  end
end
