module ViewElements::Helper
  # ViewElements.register_components_helpers(self)

  def render_view_element(name, locals = {})
    ViewElements::Locator.build(self, name, locals).render
  end

  def jquery_render(selector, view_name, locals = {})
    <<-JAVASCRIPT
    $('#{selector}')
    .replaceWith("#{escape_javascript(el(view_name, locals))}")
    JAVASCRIPT
  end

  alias_method :el, :render_view_element

end
