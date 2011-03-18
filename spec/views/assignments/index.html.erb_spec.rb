require 'spec_helper'

describe "assignments/index.html.erb" do
  before(:each) do
    assign(:assignments, [
      stub_model(Assignment,
        :description => "Description",
        :course_id => 1
      ),
      stub_model(Assignment,
        :description => "Description",
        :course_id => 1
      )
    ])
  end

  it "renders a list of assignments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
