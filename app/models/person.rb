class Person < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, against: [:name, :first_name, :notes],
    using: {tsearch: {dictionary: "english", prefix: true, any_word: true}, }, associated_against: {categories: :name}
    
  has_many :categorizations
  has_many :categories, -> { order 'categories.name' }, through: :categorizations
  attr_accessor :new_category_name
  attr_accessor :full_name
  attr_writer :birthday_text
  attr_writer :anniversary_text  
  before_save :save_birthday_text
  before_save :save_anniversary_text
  before_save :build_category_from_name
  validates_presence_of :first_name, :name
  
  def build_category_from_name
    self.categories.build(name: "#{new_category_name}") unless new_category_name.blank? 
  end
  
  def full_name
    [first_name, name].join(' ')
  end
  
  def self.search(query)
    if query
      search_by_name(query)
      #where("name @@ :q or first_name @@ :q", q: search).order(name: :asc, first_name: :asc)
    else
      order(name: :asc, first_name: :asc)
    end      
  end
  
  def birthday_text
      @birthday_text || birthday.try(:strftime, "%B-%e")
  end
  
  def save_birthday_text
      self.birthday = Chronic::parse(@birthday_text) if @birthday_text.present?
  end
  
  def anniversary_text
      @anniversary_text || anniversary.try(:strftime, "%B-%e")
  end
  
  def save_anniversary_text
      self.anniversary = Chronic::parse(@anniversary_text) if @anniversary_text.present?
  end
  
end
