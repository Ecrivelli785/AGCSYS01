class AddPriorityToOrdenTrabajos < ActiveRecord::Migration[6.0]
  def change
    add_column :orden_trabajos, :priority, :string
  end
end
