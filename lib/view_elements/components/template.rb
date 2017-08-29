module ViewElements::Components
  module Template
    def view_path_for(path)
      components_path.join(path)
    end

    def template_path
      view_path_for(self.class.to_s.underscore)
    end
  end
end
