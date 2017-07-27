module ViewElements

  module Locator

    def self.locate_presenter(element_name)
      class_name = element_name.classify
      class_name.constantize
    end

    def self.build(action_view, element_name, locals)
      locate_presenter(element_name).new(action_view, locals)
    end
  end
end
