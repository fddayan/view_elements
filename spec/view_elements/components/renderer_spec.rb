require 'spec_helper'

describe ViewElements::Components::Renderer, type: :helper do
  describe '#render' do
    it 'should render view' do
      ViewElements.configuration.components_path = Rails.root.join('app', 'view_elements')

      action_view = helper.controller.view_context
      # template = 'some_element/some_element'
      # presenter = SomeElement::SomeElement.new(action_view)

      renderer = ViewElements::Components::Renderer.new(action_view, :some_element)
      html = renderer.render
      expect(html).to include("some element content")
    end
  end
end
