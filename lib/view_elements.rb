require "view_elements/version"
require 'view_elements/rails_support'
require 'view_elements/locator'
require 'view_elements/registry'
require 'view_elements/renderer'
require 'view_elements/template_finder'
require 'view_elements/view_element'
require 'view_elements/component'
require 'view_elements/components/renderer'
require 'view_elements/stylesheets'
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

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :components_path

    def initialize
      @components_path = Rails.root.join('app','view_elements')
    end

    def component_relative_dirs
      components_dirs.map { |dir| Pathname.new(dir).relative_path_from(components_path) }
    end

    def components_dirs
      Dir.glob(components_path.join('**/**'))
      .select { |dir| File.directory?(dir) }
    end

    def components_path=(path)
     @components_path = Pathname.new(path)
    end
  end
end
