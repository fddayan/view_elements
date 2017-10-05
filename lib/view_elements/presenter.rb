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

    def wrapper_css_class
      @css_selector ||= component.name.split('/').join('--')
    end

    def wrapper(&block)
      action_view.content_tag(wrapper_tag, action_view.capture(&block), class: wrapper_css_class)
    end
  end
end
