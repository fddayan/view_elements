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
      ViewElements::Renderer.new(action_view, template_path, presenter).render
    end

    def presenter
      presenter_class.constantize.new(action_view, locals)
    rescue NameError => e
      raise e
      # raise ComponentNotFound.new("Component #{presenter_class} not found in #{components_path}")
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
  end

  class ComponentNotFound < StandardError ; end
end
