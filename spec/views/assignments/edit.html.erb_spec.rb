require 'spec_helper'

describe "assignments/edit.html.erb" do
  before(:each) do
    @assignment = assign(:assignment, stub_model(Assignment,
      :description => "MyString",
      :course_id => 1
    ))
  end

  it "renders the edit assignment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => assignments_path(@assignment), :method => "post" do
      assert_select "input#assignment_description", :name => "assignment[description]"
      assert_select "input#assignment_course_id", :name => "assignment[course_id]"
    end
  end
end
