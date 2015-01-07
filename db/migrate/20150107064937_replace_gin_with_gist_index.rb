class ReplaceGinWithGistIndex < ActiveRecord::Migration
  def change
    execute "DROP INDEX name_similarity_idx;"
    execute "CREATE INDEX name_similarity_idx ON posts USING gist (name gist_trgm_ops);"
  end
end
