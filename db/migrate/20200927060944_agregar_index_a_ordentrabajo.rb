class AgregarIndexAOrdentrabajo < ActiveRecord::Migration[6.0]
  def change
  	add_index :orden_trabajos, :trnum 
  end
end
