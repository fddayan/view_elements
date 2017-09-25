module ViewElements
  class Configuration
    attr_accessor :components_path, :strict_properties

    def initialize
      @components_path = Rails.root.join('app','view_elements')
      @strict_properties = false
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
