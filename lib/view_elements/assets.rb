module ViewElements
  module Assets
    def self.css_files
      components_path = ViewElements.configuration.components_path
      Dir.glob(components_path.join('**/style**'))
      .select { |dir| File.file?(dir) }
      .map { |dir| Pathname.new(dir).relative_path_from(components_path) }
    end

    def self.js_files
      components_path = ViewElements.configuration.components_path
      Dir.glob(components_path.join('**/component**'))
      .select { |dir| File.file?(dir) }
      .map { |dir| Pathname.new(dir).relative_path_from(components_path) }
    end
  end
end
