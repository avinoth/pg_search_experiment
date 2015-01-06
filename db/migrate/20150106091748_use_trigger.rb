class UseTrigger < ActiveRecord::Migration
  def change
    create_trigger(compatibility: 1).on(:posts).before(:insert, :update) do
      "new.tsv_body := to_tsvector('pg_catalog.english', coalesce(new.name,''));"
    end
  end
end
