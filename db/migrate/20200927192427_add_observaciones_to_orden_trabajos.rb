class AddObservacionesToOrdenTrabajos < ActiveRecord::Migration[6.0]
  def change
    add_column :orden_trabajos, :observaciones, :string
  end
end
