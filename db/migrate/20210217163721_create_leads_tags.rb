class CreateLeadsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :leads_tags do |t|
      t.belongs_to :lead
      t.belongs_to :tag
  
      t.timestamps
    end
  end
end
