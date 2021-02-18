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

  def show
    @lead = Lead.find(params[:id])
    @selected_tags_id = @lead.tags.map(&:id)
    @result = FilterCollateralByTagsQuery.new(@selected_tags_id).result
    @collaterals = @result.map { |item| item[:collateral] }
  end

  def get_collaterals
    tags = params["tags"]
    if tags != nil
      array_of_tags = tags.map(&:to_i)
      found_collaterlas = FilterCollateralByTagsQuery.new(array_of_tags).result
      render json: found_collaterlas
    end
  end

  def leads_params
    params.require(:lead).permit(:name)
  end
end
