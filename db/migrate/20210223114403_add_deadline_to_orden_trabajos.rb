class AddDeadlineToOrdenTrabajos < ActiveRecord::Migration[6.0]
  def change
    add_column :orden_trabajos, :deadline, :date
  end
end
