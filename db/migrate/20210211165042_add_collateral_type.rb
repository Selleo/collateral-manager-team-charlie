class AddCollateralType < ActiveRecord::Migration[6.0]
  def change
    add_column :collaterals, :collateral_type, :integer
  end
end
