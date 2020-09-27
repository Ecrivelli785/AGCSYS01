class AgregarotroIndexAOrdentrabajo < ActiveRecord::Migration[6.0]
  def change
  	add_index :orden_trabajos, :clinom 
  end
end
