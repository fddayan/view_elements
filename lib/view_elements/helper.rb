module ViewElements
  module Helper
    def find_cmp(name,locals)
      ViewElements::Component.new(self.controller.view_context, name, locals)
    end

    def cmp(name, locals = {})
      find_cmp(name, locals).render
    end

    alias_method :render_view_element, :cmp
    alias_method :el, :cmp
  end
end
