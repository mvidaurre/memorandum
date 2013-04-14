require "spec_helper"

describe UserReadMemosController do
  describe "routing" do

    it "routes to #index" do
      get("/user_read_memos").should route_to("user_read_memos#index")
    end

    it "routes to #new" do
      get("/user_read_memos/new").should route_to("user_read_memos#new")
    end

    it "routes to #show" do
      get("/user_read_memos/1").should route_to("user_read_memos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_read_memos/1/edit").should route_to("user_read_memos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_read_memos").should route_to("user_read_memos#create")
    end

    it "routes to #update" do
      put("/user_read_memos/1").should route_to("user_read_memos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_read_memos/1").should route_to("user_read_memos#destroy", :id => "1")
    end

  end
end
