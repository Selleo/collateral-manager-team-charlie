require 'rails_helper'

RSpec.describe FilterCollateralByTagsQuery do
  describe '#result' do
    context 'when more than one collaterals have same weight for one tag' do
      it 'return all collaterals matching that tag' do
        tag_ruby = create(:tag)
        tag_js = create(:tag)
        collateral_matching1, collateral_matching2, collateral_non_matching = create_list(:collateral, 3)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_matching1, weight: 3)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_matching2, weight: 3)
        create(:collaterals_tag, tag: tag_js, collateral: collateral_non_matching, weight: 1)

        result = FilterCollateralByTagsQuery.new([tag_ruby]).result

        expect(result).to eq [{ collateral: collateral_matching1, weight: 3.0 }, { collateral: collateral_matching2, weight: 3.0 }]
      end
    end
    
    context 'when no collateral matches selected tags' do
      it 'returns nothing' do
        tag_ruby = create(:tag)
        tag_usa = create(:tag)
        tag_blog = create(:tag)
        collateral_non_matching1, collateral_non_matching2 = create_list(:collateral, 2)
        create(:collaterals_tag, tag: tag_usa, collateral: collateral_non_matching1)
        create(:collaterals_tag, tag: tag_blog, collateral: collateral_non_matching2)

        result = FilterCollateralByTagsQuery.new([tag_ruby]).result

        expect(result).to eq []
      end
    end
    context 'when more than one collateral matches selected tag' do
      it 'return collaterals in right order, basing on their weight' do
        tag_ruby = create(:tag)
        tag_js = create(:tag)
        collateral_strong, collateral_midi, collateral_weak, collateral_non_matching = create_list(:collateral, 4)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_strong, weight: 5)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_midi, weight: 3)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_weak, weight: 1)
        create(:collaterals_tag, tag: tag_js, collateral: collateral_non_matching, weight: 1)

        result = FilterCollateralByTagsQuery.new([tag_ruby]).result

        expect(result).to eq [{ collateral: collateral_strong, weight: 5.0 }, { collateral: collateral_midi, weight: 3.0 }, { collateral: collateral_weak, weight: 1.0 }]
      end
    end
    context 'when more than one tag is selected' do
      it 'return collaterals matching at least one of those tags' do
        tag_ruby = create(:tag)
        tag_js = create(:tag)
        tag_cs = create(:tag)
        collateral_matching_strong, collateral_matching_weaker, collateral_non_matching = create_list(:collateral, 3)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_matching_weaker, weight: 5)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_matching_strong, weight: 3)
        create(:collaterals_tag, tag: tag_js, collateral: collateral_matching_strong, weight: 5)
        create(:collaterals_tag, tag: tag_cs, collateral: collateral_non_matching, weight: 1)

        result = FilterCollateralByTagsQuery.new([tag_ruby, tag_js]).result

        expect(result).to eq [{collateral: collateral_matching_strong, weight: 4.0 }, { collateral: collateral_matching_weaker, weight: 2.5 }]
      end
    end
    context 'when there are no tags selected' do
      it 'return all collaterals' do
        collaterals = create_list(:collateral, 5)

        result = FilterCollateralByTagsQuery.new([]).result

        expect(result).to match_array(collaterals)
      end
    end
    context 'when at least one tag is selected' do
      it 'return matching collaterals with order, basing on their weight' do
        tag_ruby = create(:tag)
        tag_js = create(:tag)
        tag_python = create(:tag)
        collateral_matching_strong, collateral_matching_midi, collateral_matching_weak, collateral_non_matching = create_list(:collateral, 4)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_matching_strong, weight: 5)
        create(:collaterals_tag, tag: tag_js, collateral: collateral_matching_strong, weight: 5)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_matching_midi, weight: 3)
        create(:collaterals_tag, tag: tag_js, collateral: collateral_matching_midi, weight: 3)
        create(:collaterals_tag, tag: tag_ruby, collateral: collateral_matching_weak, weight: 1)
        create(:collaterals_tag, tag: tag_python, collateral: collateral_non_matching, weight: 1)

        result = FilterCollateralByTagsQuery.new([tag_ruby, tag_js]).result

        expect(result).to eq [{ collateral: collateral_matching_strong, weight: 5.0 }, { collateral: collateral_matching_midi, weight: 3.0 }, {collateral: collateral_matching_weak, weight: 0.5 }]
      end
    end
  end
end