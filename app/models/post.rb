class Post < ActiveRecord::Base
  include PgSearch

  # pg_search_scope :search, against: [:tsv_body], using: [:tsearch]

  def self.text_search(query)
    if query.present?
      match_word = Word.where("word % ?", query).order("similarity(word, '#{query}')")
      terms = match_word.map{|t| "#{t.word}:*" }.join(' & ')
      Post.where("tsv_body @@ to_tsquery('simple', ?)", terms)
    else
      all
    end
  end
end
