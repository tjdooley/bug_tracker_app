require 'spec_helper'

describe "Bugs" do

  before(:each) do
    developer = Factory(:developer)
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new bug" do
        lambda do
          visit newbug_path
          fill_in :title, :with => ""
          fill_in :description, :with => ""
          fill_in :status, :with => ""
          fill_in :developer, :with => ""
          click_button
          response.should render_template('shared/_error_messages')
          response.should have_selector("div#error_explanation")
        end.should_not change(Bug, :count)
      end
    end

    describe "success" do

      it "should make a new bug" do
        title_content = "New title"
        description_content = "New description"
        status_content = "New"
        developer_content = 1
        lambda do
          visit newbug_path
          fill_in :title, :with => title_content
          fill_in :description, :with => description_content
          fill_in :status, :with => status_content
          fill_in :developer, :with => developer_content
          click_button
          response.should have_selector("td", :content => title_content)
        end.should change(Bug, :count).by(1)
      end
    end
  end

end
