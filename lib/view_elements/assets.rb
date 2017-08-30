module ViewElements
  module Assets
    def self.files
      components_path = ViewElements.configuration.components_path
      Dir.glob(components_path.join('**/style**'))
      .select { |dir| File.file?(dir) }
      .map { |dir| Pathname.new(dir).relative_path_from(components_path) }
      # prybug
      # "@import 'gifts/your_order/card_list';"
    end
  end
end
