class Post < ActiveRecord::Base
  def self.text_search(query)
    if query.present?
      where("name ilike :q", q: "%#{query}%")
    else
      all
    end
  end
end
