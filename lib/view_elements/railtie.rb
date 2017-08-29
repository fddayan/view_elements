require 'view_elements/helper'

module ViewElements
  class Railtie < ::Rails::Engine
    initializer 'view_elements.add_helpers' do
      ActionView::Base.send :include, ViewElements::Helper
    end
    initializer "view_elements.assets" do |app|
      Rails.application.config.assets.paths <<
       ViewElements.configuration.components_path

       #  Rails.application.config.assets.precompile += %w( mountain_view/styleguide.css
                                                      #  mountain_view/styleguide.js )
   end
  end
end
