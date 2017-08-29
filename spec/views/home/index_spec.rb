require "spec_helper"

describe "home/index", type: :view do
  it "displays all the widgets" do
    render

    expect(rendered).to match /hello James Bond/
    expect(rendered).to match /Welcome/
    expect(rendered).to match /MySite/
  end
end
