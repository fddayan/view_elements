module ViewElements
  module Helper
    def cmp(name, locals = {})
      ViewElements::Component.new(self.controller.view_context, name, locals).render
    end
    alias_method :render_view_element, :cmp
    alias_method :el, :cmp
  end
end
