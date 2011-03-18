require 'spec_helper'

describe "show course" do
  context "with assignments" do
    before do
      c = Course.create(:name => 'Creative Writing', :description => 'Learn to write fiction.')
      c.assignments.create(:description => "a conversation with your mother",
                       :assigned_on => Date.civil(2010,1,2),
                       :due_on => Date.civil(2010,1,15))      
    end
  end
end
