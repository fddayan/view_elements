require "view_elements/version"
require 'view_elements/rails_support'
require 'view_elements/locator'
require 'view_elements/registry'
require 'view_elements/renderer'
require 'view_elements/template_finder'
require 'view_elements/view_element'
require 'view_elements/component'
require 'view_elements/railtie'

module ViewElements
  def self.components_map
    @components_map ||= {}
  end

  def self.register(name, component)
    components_map[name] = component
    # define_component_helper name, component
  end

  def self.register_components_helpers(helper_module)
    Dir.glob("#{Rails.root}/app/view_elements/**/*.rb").sort.each do |file|
      p = Rails.root.join('app','view_elements/').to_s
      e = file.gsub(p, '').gsub('.rb','')

      clazz = e.classify.constantize
      clazz.define_helper(helper_module) if clazz.respond_to?(:define_helper)
    end
  end

  def self.helper_names
    ViewElements::Registry.components_map.keys
  end
end
