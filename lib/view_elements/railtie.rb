require 'view_elements/helper'

module ViewElements
  class Railtie < ::Rails::Engine
    initializer 'view_elements.add_helpers' do
      ActionView::Base.send :include, ViewElements::Components::Helper
    end
    initializer "view_elements.assets" do |app|
      Rails.application.config.assets.paths <<
       ViewElements.configuration.components_path
   end
  end
end
