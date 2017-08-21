module ViewElements::Rendering
  def render_sub_element(sub_item_element_name, locals)
    action_view.el sub_item_path_for(sub_item_element_name.to_s), locals
  end

  def render_view_element(name, args = {})
    render_sub_element name, args
  end

  def render
    ViewElements::Renderer.new(action_view, template_path, self).render
  end

end
