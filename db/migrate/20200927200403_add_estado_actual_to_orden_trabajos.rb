class AddEstadoActualToOrdenTrabajos < ActiveRecord::Migration[6.0]
  def change
    add_column :orden_trabajos, :estado_actual, :string
  end
end
