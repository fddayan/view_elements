require 'spec_helper'

describe ViewElements::Renderer, type: :helper do
  describe '#render' do
    it 'should render view' do
      action_view = helper.controller.view_context
      template = Rails.root.join('app', 'view_elements', 'some_element/some_element')
      presenter = SomeElement::SomeElement.new(action_view)
      renderer = ViewElements::Renderer.new(action_view, template, presenter)

      html = renderer.render

      expect(html).to include("some element content")
    end
  end
end
