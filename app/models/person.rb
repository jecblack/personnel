class Person < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, -> { order 'categories.name' }, through: :categorizations
  attr_accessor :new_category_name
  attr_accessor :full_name
  attr_writer :birthday_text 
  before_save :save_birthday_text
  before_save :build_category_from_name
  
  def build_category_from_name
    self.categories.build(name: "#{new_category_name}") unless new_category_name.blank? 
  end
  
  def full_name
    [first_name, name].join(' ')
  end
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%").order(name: :asc, first_name: :asc)
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
  
end
