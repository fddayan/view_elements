module ViewElements
  class Presenter
    module RailsSupport
      def method_missing(m, *args, &block)
        if action_view.respond_to?(m)
          action_view.public_send(m, *args, &block)
        else
          super
        end
      end
    end
  end
end
