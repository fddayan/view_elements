require 'view_elements/presenter/exposures'
require 'view_elements/presenter/lets'
require 'view_elements/presenter/locals'
require 'view_elements/presenter/properties'
require 'view_elements/presenter/rails_support'

module ViewElements
  class Presenter
    include ViewElements::Presenter::Properties
    include ViewElements::Presenter::Exposures
    include ViewElements::Presenter::Locals
    extend ViewElements::Presenter::Lets
    # include ViewElements::Presenter::RailsSupport

    attr_reader :action_view, :locals, :component

    def initialize(action_view, locals = {}, component)
      @locals = locals
      @action_view = action_view
      @component = component

      validate_properties!
      define_locals_accessors!
    end

    def h
      action_view
    end

    def helper
      action_view
    end

    def wrapper_tag
      :div
    end

    def css
      wrapper_css_class
    end

    def jquery_selector
      @jquery_selector ||= begin
        s = ".#{component_css_class}"
        s << ".#{distinct_id_css_class}" if distinct_id
        s
      end
    end

    def wrapper_css_class
      @css_selector ||= "#{component_css_class} #{distinct_id_css_class}"
    end

    def distinct_id_css_class
      "distid-#{distinct_id}" if distinct_id.present?
    end

    def component_css_class
      component.name.split('/').join('--')
    end

    def distinct_id
    end

    def wrapper(&block)
      action_view.content_tag(wrapper_tag, action_view.capture(&block), class: "view_elements_wrapper #{wrapper_css_class}")
    end
  end
end
