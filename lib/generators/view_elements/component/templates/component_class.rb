class <%= class_name %>  < ViewElements::Component
  let(:some_variable) { }
  properties :property1, :property2
  selector :<%= human_name.to_s.parameterize.underscore %>
  template '<%= file_path %>'
end
