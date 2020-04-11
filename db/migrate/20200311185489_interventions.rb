class Interventions < ActiveRecord::Migration[5.2]
    def self.up
      create_table :interventions do |t|
        t.bigint :author, null: false
        t.bigint :building_id, null: false
        t.bigint :customer_id, null: false
        t.bigint :battery_id
        t.bigint :column_id
        t.bigint :elevator_id
        t.bigint :employee_id
        t.string :result
        t.string :status
        t.string :report
        t.datetime :start_intervention
        t.datetime :end_intervention

        t.timestamps
      end
    end
  end