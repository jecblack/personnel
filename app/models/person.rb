class Person < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, against: [:name, :first_name, :notes],
    using: {tsearch: {dictionary: "english", prefix: true, any_word: true}, }, associated_against: {categories: :name}
    
  has_many :categorizations
  has_many :categories, -> { order 'categories.name' }, through: :categorizations
  attr_accessor :new_category_name, :full_name
  attr_writer :birthday_text, :anniversary_text  
  before_save :save_birthday_text, :build_category_from_name, :save_anniversary_text
  validates_presence_of :first_name, :name
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
  
  def build_category_from_name
    self.categories.build(name: "#{new_category_name}") unless new_category_name.blank? 
  end
  
  def full_name
    [first_name, name].join(' ')
  end
  
  def self.search(query)
    if query.blank?
      order(name: :asc, first_name: :asc)
    else
      search_by_name(query)
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
