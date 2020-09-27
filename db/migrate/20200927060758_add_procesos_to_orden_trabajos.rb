class AddProcesosToOrdenTrabajos < ActiveRecord::Migration[6.0]
  def change
    add_column :orden_trabajos, :procesos, :string
    add_column :orden_trabajos, :observaciones, :string
    add_column :orden_trabajos, :estado_actual, :string
    add_column :orden_trabajos, :estado, :boolean
  end
end
