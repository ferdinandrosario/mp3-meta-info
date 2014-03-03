require "spec_helper"

describe AudioFilesController do
  describe "routing" do

    it "routes to #index" do
      get("/audio_files").should route_to("audio_files#index")
    end

    it "routes to #new" do
      get("/audio_files/new").should route_to("audio_files#new")
    end

    it "routes to #show" do
      get("/audio_files/1").should route_to("audio_files#show", :id => "1")
    end

    it "routes to #edit" do
      get("/audio_files/1/edit").should route_to("audio_files#edit", :id => "1")
    end

    it "routes to #create" do
      post("/audio_files").should route_to("audio_files#create")
    end

    it "routes to #update" do
      put("/audio_files/1").should route_to("audio_files#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/audio_files/1").should route_to("audio_files#destroy", :id => "1")
    end

  end
end
