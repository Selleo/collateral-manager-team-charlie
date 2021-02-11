class CreateCollateralsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :collaterals_tags do |t|
      t.belongs_to :collateral
      t.belongs_to :tag
      t.integer :weight

      t.timestamps
    end
  end
end
