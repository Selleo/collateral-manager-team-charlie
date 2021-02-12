require 'rails_helper'




# kontroler
# def index
#   FilterCollateralByTagsQuery.new(params[:tags]).result
# end

describe FilterCollateralByTagsQuery do
  describe '#result' do
    #context 'when two collateral with same weight exist for one tag'
    context 'when two collaterals have same weight for one tag' do
      it 'returns all collateral matching that tag' do
       tag=create(:tag, name: 'ruby')
        collateral_1 = create(:collateral, name: "wow")
        collateral_2 = create(:collateral, name: 'foo')
        create(:collaterals_tag, tag: tag, collateral: collateral_1)
        create(:collaterals_tag, tag: tag, collateral: collateral_2)
        
        result = FilterCollateralByTagsQuery.new(['ruby']).result
      
      expect(result).to eq [collateral_1,collateral_2]
      end
    end
  end
end

RSpec.describe CollateralController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    context "when tags_id parameter are provided" do
      it "returns collaterals filtered by tag_ids" do
        get :index, params: {filtered_ids: [1,2,3]}
        
        # collaterals = create(:collateral)

        expect = 
      
      end
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

end
