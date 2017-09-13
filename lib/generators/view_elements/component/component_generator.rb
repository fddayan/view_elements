class ViewElements::ComponentGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_class
    template 'presenter.rb', "app/view_elements/#{file_path}/presenter.rb"
  end

  def generate_view
    template 'index.html.erb', "app/view_elements/#{file_path}/index.html.erb"
  end

  def generate_js
    template 'component.js', "app/view_elements/#{file_path}/component.js"
  end

  def generate_scss
    template 'style.scss', "app/view_elements/#{file_path}/style.scss"
  end

  def css_class
    file_path.split('/').join('--')
  end

  def view_wrapper
    <<-HEREDOC
<%= presenter.wrapper do %>

<% end %>
    HEREDOC
  end
end
