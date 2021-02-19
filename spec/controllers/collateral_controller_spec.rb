require 'rails_helper'
require 'will_paginate/array'

RSpec.describe CollateralsController, type: :controller do

  describe "GET #index" do
    it "redirects to /user/sign_in when not authenticated" do
      get :index
      expect(response).to redirect_to('http://test.host/users/sign_in')
    end
    
    it "returns http success" do
      sign_in(create(:user))

      get :index
      collaterals = create_list(:collateral, 6)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "redirects to /user/sign_in when not authenticated" do
      collateral = create(:collateral)
      get :show, params: {id: collateral.id}

      expect(response).to redirect_to('http://test.host/users/sign_in')
    end

    it "redirects to /collateral/#id when authenticated" do
      sign_in(create(:user))

      collateral = create(:collateral)
      get :show, params: {id: collateral.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #new" do
    it "redirects to /user/sign_in when not authenticated" do
      get :new

      expect(response).to redirect_to('http://test.host/users/sign_in')
    end

    it "returns http success" do
      sign_in(create(:user))
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #edit" do
    it "redirects to /user/sign_in when not authenticated" do
      collateral = create(:collateral)
      get :edit, params: {id: collateral.id}
      expect(response).to redirect_to('http://test.host/users/sign_in')
    end

    it "returns http success" do
      sign_in(create(:user))

      collateral = create(:collateral)
      get :edit, params: {id: collateral.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#add_tags' do
    context 'when adding new tag' do
      it 'CollateralsTag should increment by 1' do
        sign_in(create(:user))
        params = {}
        tag_ruby = create(:tag)
        params[:collateral] = {name: 'collateral_test', description: 'abc', url: 'www', collateral_type: 'article'}
        params[:added_tags] = [{weight: 1,
                                id: tag_ruby.id
                              }].to_json
        expect { post :create, params: params }.to change { CollateralsTag.count }.by(1)
        collateral = Collateral.find_by(name: 'collateral_test')
        expect(CollateralsTag.last).to have_attributes(:tag_id => tag_ruby.id, :collateral_id => collateral.id)
      end
    end
    context 'when adding more than one new tag' do
      it 'should increment more than 1' do
        sign_in(create(:user))
        tag_ruby = create(:tag)
        tag_js = create(:tag)
        # tag_cpp = create(:tag)
        params = {}
        params[:collateral] = {name: 'collateral_test', description: 'abc', url: 'www', collateral_type: 'article'}
        params[:added_tags] = [
            {
              weight: 1,
              id: tag_ruby.id
            },
            {
              weight: 1,
              id: tag_js.id
            }].to_json
        expect { post :create, params: params }.to change { CollateralsTag.count }.by(2)
      end
    end
  end

  describe '#remove_tags' do
    context 'when removing one tag and add tag' do
      it 'collateralsTags.counts should be equal' do
        sign_in(create(:user))
        tag_ruby = create(:tag)
        tag_js = create(:tag)
        collateral = create(:collateral)
        create(:collaterals_tag, tag: tag_js, collateral_id: collateral.id, weight: 1)
        # create(:collaterals_tag, tag: tag_ruby, collateral_id: collateral.id, weight: 1)

        params = {}
        params[:collateral] = {
          id: Collateral.find_by(name: collateral.name),
          name: collateral.name,
          description: collateral.description,
          collateral_type: collateral.collateral_type,
        }
        # params[:collateral] = {name: 'collateral_test', description: 'abc', url: 'www', collateral_type: 'article'}
        params[:added_tags] = [{
          id: tag_ruby.id,
          weight: 1
        }].to_json
        params[:removed_tags] = [tag_js.id.to_s].to_json
        params[:id] = collateral.id
        expect { put :update, params: params }.to change { CollateralsTag.count }.by(0)
      end
    end
  end
end