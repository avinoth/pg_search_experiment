class Post < ActiveRecord::Base
  include PgSearch

  # pg_search_scope :search, against: [:tsv_body], using: [:tsearch]

  def self.text_search(query)
    if query.present?
      #Using trigram and FTS
      # match_word = Word.where("word % ?", query).order("similarity(word, '#{query}') DESC")
      # terms = match_word.map{|t| "#{t.word}:*" }.join(' & ')
      # Post.where("tsv_body @@ to_tsquery('simple', ?)", terms)

      #Using only trigram
      Post.where("name % ?", query).where("similarity(name, '#{query}') > 0.3").order("similarity(name, '#{query}') DESC")
    else
      all
    end
  end
end
