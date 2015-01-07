class Post < ActiveRecord::Base
  def self.text_search(query)
    if query.present?
      where("to_tsvector('english', name) @@ plainto_tsquery('english', :q)", q: "%#{query}%")
    else
      all
    end
  end
end
