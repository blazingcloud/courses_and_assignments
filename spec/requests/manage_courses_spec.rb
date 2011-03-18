require 'spec_helper'

describe "manage courses" do

  context "with 3 people" do
    before do
      Course.create(:name => 'Creative Writing', :description => 'Learn to write fiction.')
      Course.create(:name => 'Ruby on Rails', :description => 'Build awesome web applications.')
      Course.create(:name => 'American History', :description => "Those who don't know history are doomed to repeat it.")

      visit courses_path # index
    end

    it "displays list of course names and their descriptions" do
      # page.save_and_open_page
      page.should have_content('Creative Writing')
      page.should have_content('Learn to write fiction.')
      page.should have_content('Ruby on Rails')
      page.should have_content('Build awesome web applications.')
      page.should have_content('American History')
      page.should have_content("Those who don't know history are doomed to repeat it.")
    end
  end

end
