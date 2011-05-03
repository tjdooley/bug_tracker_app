require 'spec_helper'

describe DevelopersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have a name field" do
      get :new
      response.should have_selector("input[name='developer[name]'][type='text']")
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "" }
      end

      it "should not create a developer" do
        lambda do
          post :create, :developer => @attr
        end.should_not change(Developer, :count)
      end

      it "should render the 'new' page" do
        post :create, :developer => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "Jim Developer" }
      end

      it "should create a developer" do
        lambda do
          post :create, :developer => @attr
        end.should change(Developer, :count).by(1)
      end

    end
  end

  describe "GET 'show'" do

    before(:each) do
      @developer = Factory(:developer)
      @bug = Factory(:bug)
    end

    it "should be successful" do
      get :show, :id => @developer
      response.should be_success
    end

    it "should find the right developer" do
      get :show, :id => @developer
      assigns(:developer).should == @developer
    end

    it "should include the developers's name" do
      get :show, :id => @developer
      response.should have_selector("strong", :content => @developer.name)
    end

    it "should include the developer's bugs" do
      get :show, :id => @developer
      response.should have_selector("td", :content => @bug.status)
    end

    it "should have a link to the developer's bugs" do
      get :show, :id => @developer
      bug_url = "/bugs/1"
      response.should have_selector("a", :href => bug_url,
                                         :content => @bug.title)
    end
  end

  describe "GET 'index'" do

    before(:each) do
      @developer = Factory(:developer)
      second = Factory(:developer, :name => "Second Developer", :id => "2")
      third  = Factory(:developer, :name => "Third Developer", :id => "3")

      @developers = [@developer, second, third]
      30.times do
        @developer = Factory(:developer, :name => Factory.next(:name), :id => Factory.next(:developer_id))
      end

    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have an element for each developer" do
      get :index
      @developers.each do |developer|
        response.should have_selector("a", :content => developer.name)
      end
    end

    it "should have an element for each developer" do
      get :index
      @developers[0..2].each do |developer|
        response.should have_selector("a", :content => developer.name)
      end
    end

    it "should paginate developers" do
      get :index
      response.should have_selector("a", :href => "/developers?page=2",
                                         :content => "2")
      response.should have_selector("a", :href => "/developers?page=2",
                                         :content => "Next")
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @developer = Factory(:developer)
    end

    it "should destroy the developer" do
      lambda do
        delete :destroy, :id => @developer
      end.should change(Developer, :count).by(-1)
    end

    it "should redirect to the developers page" do
      delete :destroy, :id => @developer
      response.should redirect_to(developers_path)
    end
  end

  describe "GET 'edit'" do

    before(:each) do
      @developer = Factory(:developer)
    end

    it "should be successful" do
      get 'edit', :id => @developer
      response.should be_success
    end

    it "should have a name field" do
      get :edit, :id => @developer
      response.should have_selector("input[name='developer[name]'][type='text']")
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @developer = Factory(:developer)
    end

    describe "failure" do

      before(:each) do
        @attr = { :name => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @developer, :developer => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @developer, :developer => @attr
        response.should have_selector("h1", :content => "Edit developer")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "Developer" }
      end

      it "should change the developer's attributes" do
        put :update, :id => @developer, :developer => @attr
        @developer.reload
        @developer.name.should  == @attr[:name]
      end

      it "should redirect to the developer's show page" do
        put :update, :id => @developer, :developer => @attr
        response.should redirect_to(developer_path(@developer))
      end

      it "should have a flash message" do
        put :update, :id => @developer, :developer => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

end
