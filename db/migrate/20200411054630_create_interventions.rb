class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.references :author, foreign_key: { to_table: 'employees' }, :null => false
      t.references :customer_id, foreign_key: { to_table: 'customers' }, :null => false
      t.references :building_id, foreign_key: { to_table: 'buildings' }, :null => false
      t.references :battery_id, foreign_key: { to_table: 'batteries' }
      t.references :column_id, foreign_key: { to_table: 'columns' }
      t.references :elevator_id, foreign_key: { to_table: 'elevators' }
      t.references :employee_id, foreign_key: { to_table: 'employees' }
      t.datetime :start_intervention
      t.datetime :end_intervention
      t.string :result, :default => "Incomplete"
      t.string :report
      t.string :status, :default => "Pending"
      t.timestamps
    end
  end
end