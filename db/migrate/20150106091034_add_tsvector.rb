class AddTsvector < ActiveRecord::Migration
  def change
    add_column :posts, :tsv_body, :tsvector
    add_index(:posts, :tsv_body, using: 'gin')
  end
end
