module ViewElements
  class Renderer

    attr_reader :action_view, :template, :presenter

    def initialize(action_view, template, presenter)
      @action_view = action_view
      @template = template
      @presenter = presenter
    end

    def render
      action_view.render file: template, locals: build_locals
    end

    def build_locals
      {}.tap do |new_locals|
        new_locals.merge!(presenter.locals)
        new_locals[:element] = presenter
        new_locals[:e] = presenter
        temp = presenter.expose_locals
        new_locals.merge!(temp) if temp
      end
    end

    # def self.render(action_view, template, presenter)
    #   new(action_view, template, presenter).render
    # end

  end
end
