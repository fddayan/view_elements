class ViewElements::ComponentGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_class
    template 'component_class.rb', "app/view_elements/#{file_path}.rb"
  end

  def generate_view
    template 'component_view.html.erb', "app/view_elements/#{file_path}.html.erb"
  end

  def generate_js
    template 'component.js', "app/view_elements/#{file_path}.js"
  end

  def generate_scss
    template 'component.scss', "app/view_elements/#{file_path}.scss"
  end
end
