class CreateMicroposts < ActiveRecord::Migration[7.0]
  def change
    create_table(:microposts) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.text(:content)

      t.index([:user_id, :created_at])

      t.timestamps()
    end
  end
end
