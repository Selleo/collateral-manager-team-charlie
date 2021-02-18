class LeadsController < ApplicationController
  def index
    @leads = Lead.paginate(page: params[:page], per_page: 2)
  end

  def add_tags(added_tags)
    added_tags.each do |tag|
      @existing_tag = Tag.find(tag['id'])      
      @created = LeadsTag.create({ tag_id: @existing_tag['id'],
                              lead_id: @lead['id'] }).save
    end
  end

  def remove_tags(removed_tags)
    removed_tags.each do |tag|
      @lead_tag = LeadsTag.joins(:tag).where('tags.id = ?', tag).first
      LeadsTag.destroy(@lead_tag['id'])
    end
  end

  def new
    @lead = Lead.new
    @all_tags = Tag.all
  end
  
  def search
    @all_tags = Tag.all
  end

  def create
    @lead = Lead.new(leads_params)
    if @lead.save
      @added_tags = JSON.parse(params['added_tags'].gsub('\"', '"').gsub('/', ''))
      add_tags(@added_tags)
      redirect_to "/leads/#{@lead.id}"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @lead = Lead.find(params[:id])
    @all_tags = Tag.all
  end

  def update
    @lead = Lead.find(params[:id])
    if @lead.update(leads_params)  
      @added_tags = JSON.parse(params['added_tags'].gsub('\"', '"').gsub('/', ''))
      @removed_tags = JSON.parse(params['removed_tags'].gsub('\"', '"').gsub('/', ''))
      add_tags(@added_tags)
      remove_tags(@removed_tags)
      redirect_to @lead
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Lead.destroy(params[:id])
    redirect_to "/leads"
  end

  #function to show collaterals
  def show
    @lead = Lead.find(params[:id])
    @selected_tags_id = @lead.tags.map(&:id)

    # @collaterals = collateral.all
    @collaterals = Collateral.includes(:tags).where(tags: {id: @selected_tags_id})
  end

  #Function to show collaterals by specific tags, 
  #if user chooses tags [ruby, js] it will find only those, which contain at least [ruby,js] 
  def show_by_tags
    @specific_tags = [1]
    Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @specific_tags}).map do |collateral|
      { collateral: collateral, weight: collateral.collaterals_tags.sum do |collateral_tag| 
        ((@specific_tags.reverse.index(collateral_tag.tag_id) + 1).to_f / @specific_tags.length.to_f) * collateral_tag.weight
        end
      }
    end.sort_by { |k| - k[:weight] }

  end

end

def leads_params
  params.require(:lead).permit(:name)
end

# Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @specific_tags}).map {|a| 1}



# working one
    # Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @specific_tags})
    #   .map {
    #     |collateral| collateral.collaterals_tags
    #       .map { 
    #         |collateral_tag| ((@specific_tags.reverse.index(collateral_tag.tag_id) + 1).to_f / @specific_tags.length.to_f) * collateral_tag.weight
    #       }.sum
    #   }


    # Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @specific_tags}).map do |collateral|
    #   { collateral: collateral, weight: collateral.collaterals_tags.sum do |collateral_tag| 
    #     ((@specific_tags.reverse.index(collateral_tag.tag_id) + 1).to_f / @specific_tags.length.to_f) * collateral_tag.weight
    #     end
    #   }
    # end.sort_by! { |k| k[:weight] * -1 }
