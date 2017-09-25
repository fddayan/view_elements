require "view_elements/version"
require 'view_elements/assets'
require 'view_elements/renderer'
# require 'view_elements/view_element'
# require 'view_elements/component'
require 'view_elements/component'
require 'view_elements/presenter'
require 'view_elements/railtie'
require 'view_elements/configuration'

module ViewElements
  # def self.components_map
  #   @components_map ||= {}
  # end

  # def self.register(name, component)
  #   components_map[name] = component
  #   # define_component_helper name, component
  # end

  # def self.register_components_helpers(helper_module)
  #   Dir.glob("#{Rails.root}/app/view_elements/**/*.rb").sort.each do |file|
  #     p = Rails.root.join('app','view_elements/').to_s
  #     e = file.gsub(p, '').gsub('.rb','')
  #
  #     clazz = e.classify.constantize
  #     clazz.define_helper(helper_module) if clazz.respond_to?(:define_helper)
  #   end
  # end

  def self.require_presenters!
    Dir.glob("#{configuration.components_path}/**/*.rb").each do |file|
      require file
    end
  end

  def self.helper_names
    ViewElements::Registry.components_map.keys
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
