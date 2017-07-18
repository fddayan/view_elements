class ViewElements::ElementGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_class
    template 'element_class.rb', "app/view_elements/#{file_path}.rb"
  end

  def generate_view
    template 'element_view.html.erb', "app/view_elements/#{file_path}.html.erb"
  end
end
