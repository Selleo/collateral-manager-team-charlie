require 'rails_helper'

RSpec.describe LeadsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      lead = create(:lead)
      get :show, params: {id: lead.id}
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #edit" do
    it 'returns http success' do
      lead = create(:lead)
      get :show, params: {id: lead.id}
      expect(response).to have_http_status(302)
    end
  end
end
