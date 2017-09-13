module ViewElements
  module Components
    module Helper
      def cmp(name, locals = {})
        ViewElements::Components::Renderer.new(self.controller.view_context, name, locals).render
      end

      # def sub_cmp(name, locals = {})
      #   self.controller.view_context.component.cmp(name, locals).render
      # end

      alias_method :render_view_element, :cmp
      alias_method :el, :cmp
    end
  end
end
