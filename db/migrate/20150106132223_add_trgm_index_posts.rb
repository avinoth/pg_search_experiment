class AddTrgmIndexPosts < ActiveRecord::Migration
  def change
    execute "CREATE INDEX name_similarity_idx ON posts USING gin (name gin_trgm_ops);"
  end
end
