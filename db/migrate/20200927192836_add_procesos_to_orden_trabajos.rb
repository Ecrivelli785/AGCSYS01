class AddProcesosToOrdenTrabajos < ActiveRecord::Migration[6.0]
  def change
    add_column :orden_trabajos, :procesos, :string
  end
end
