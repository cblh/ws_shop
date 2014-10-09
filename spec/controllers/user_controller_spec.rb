require 'rails_helper'

RSpec.describe UserController, :type => :controller do

  describe "GET edit_info" do
    it "returns http success" do
      get :edit_info
      expect(response).to be_success
    end
  end

  describe "GET update_info" do
    it "returns http success" do
      get :update_info
      expect(response).to be_success
    end
  end

  describe "GET valid_phone" do
    it "returns http success" do
      get :valid_phone
      expect(response).to be_success
    end
  end

end
