require 'rails_helper'

RSpec.describe CollateralsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe '#add_tags' do
    context 'when adding new tag' do
      it 'CollateralsTag should increment by 1' do
        params = {}
        params[:collateral] = {name: 'collateral_test', description: 'abc', url: 'www', collateral_type: 'article'}
        params[:added_tags] = [{weight: 1,
                                id: 1
                              }].to_json
        expect { post :create, params: params }.to change { CollateralsTag.count }.by(1)
      end
      it 'should find new tag on last position' do    
        expect(CollateralsTag.last).to eq(CollateralsTag.where({:tag_id => 1, :collateral_id => collateral['id']}))
      end
    end
    context 'when adding more than one new tag' do
      it 'should increment more than 1' do
        params = {}
        params[:collateral] = {name: 'collateral_test', description: 'abc', url: 'www', collateral_type: 'article'}
        params[:added_tags] = [
            {
              weight: 1,
              id: 1
            },
            {
              weight: 1,
              id: 2
            }].to_json
        expect { post :create, params: params }.to change { CollateralsTag.count }.by(2)
      end
    end
  end
end