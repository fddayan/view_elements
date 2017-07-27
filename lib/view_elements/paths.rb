module ViewElements::Paths
  def sub_item_path_for(element_name)
    element_dir_path.join(element_name).to_s
  end

  def element_path
    # @element_name ||= Pathname.new(method(:render).source_location.first)
    @element_path = Pathname.new(self.class.name.underscore)
  end

  def element_dir_path
    @element_dir_path ||= element_path.dirname
  end

  def view_path_for(path)
    view_path.join(path)
  end

  def template_path
    view_path_for(self.class.to_s.underscore)
  end
end
