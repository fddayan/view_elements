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
    include ViewElements::Presenter::RailsSupport

    attr_reader :action_view, :locals

    def initialize(action_view, locals = {})
      @locals = locals
      @action_view = action_view

      validate_properties!
      define_locals_accessors!
    end

    def helper
      action_view
    end
  end
end
