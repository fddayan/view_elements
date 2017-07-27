require 'view_elements/helper'

module ViewElements
  class Railtie < Rails::Railtie
    initializer 'view_elements.add_helpers' do
      ActionView::Base.send :include, ViewElements::Helper
    end
  end
end
