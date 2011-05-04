require 'spec_helper'

describe "Developers" do

  describe "creation" do

    describe "failure" do

      it "should not make a new developer" do
        lambda do
          visit newdeveloper_path
          fill_in :name, :with => ""
          click_button
          response.should render_template('shared/_error_messages')
          response.should have_selector("div#error_explanation")
        end.should_not change(Developer, :count)
      end
    end

    describe "success" do

      it "should make a new developer" do
        content = "New developer"
        lambda do
          visit newdeveloper_path
          fill_in :name, :with => content
          click_button
          response.should have_selector("td", :content => content)
        end.should change(Developer, :count).by(1)
      end
    end
  end

end
