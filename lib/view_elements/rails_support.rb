module ViewElements
  module RailsSupport

    # def self.included(target)
    #   target.include ApplicationHelper
    #   target.include AbstractController::Helpers
    #   target.include AbstractController::Translation
    #   target.include ActionView::Helpers
    #   target.include ::Rails.application.routes.url_helpers
    # end

    def method_missing(m, *args, &block)
      action_view.send(m, *args, &block)
    end

  end
end
