# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150106110820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "posts", force: true do |t|
    t.string   "name"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.tsvector "tsv_body"
  end

  add_index "posts", ["tsv_body"], name: "index_posts_on_tsv_body", using: :gin

  create_table "words", force: true do |t|
    t.string "word"
  end

  # no candidate create_trigger statement could be found, creating an adapter-specific one
  execute(<<-TRIGGERSQL)
CREATE OR REPLACE FUNCTION public.posts_before_insert_update_row_tr()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    new.tsv_body := to_tsvector('pg_catalog.english', coalesce(new.name,''));
    RETURN NEW;
END;
$function$
  TRIGGERSQL

  # no candidate create_trigger statement could be found, creating an adapter-specific one
  execute("CREATE TRIGGER posts_before_insert_update_row_tr BEFORE INSERT OR UPDATE ON posts FOR EACH ROW EXECUTE PROCEDURE posts_before_insert_update_row_tr()")

end
