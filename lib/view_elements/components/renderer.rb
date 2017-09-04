# require 'view_elements/components/template'

module ViewElements::Components
  class Renderer
    attr_reader :action_view, :components_path, :name, :locals

    def initialize(action_view, name, locals)
      @action_view = action_view
      @name = name
      @locals = locals
      @components_path = ViewElements.configuration.components_path
    end

    def render
      ViewElements::Renderer.new(action_view, template_path, build_locals).render
    end

    def presenter
      presenter_class.constantize.new(action_view, locals)
    rescue NameError => e
      # raise e
      raise ComponentNotFound.new("Cannot load #{presenter_class}: #{e.message}")
    end

    def presenter_class
      @presenter_class ||= "#{name.to_s.classify}::Presenter"
    end

    def presenter_path
      component_path.join('presenter')
    end

    def template_path
      component_path.join('index')
    end

    def component_path
      components_path.join(name.to_s)
    end

    def include_partial(name, partial_locals = {})
      ViewElements::Renderer.new(action_view, component_path.join("_#{name}"), build_locals.merge(partial_locals)).render
    end

    private

    def build_locals
      {}.tap do |new_locals|
        new_locals.merge!(presenter.locals)
        new_locals[:component] = self
        new_locals[:element] = presenter
        new_locals[:e] = presenter
        new_locals[:presenter] = presenter
        new_locals[:p] = presenter
        temp = presenter.expose_locals
        new_locals.merge!(temp) if temp
      end
    end
  end

  class ComponentNotFound < StandardError ; end
end
