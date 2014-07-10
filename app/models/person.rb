class Person < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, -> { order 'categories.name' }, through: :categorizations

  attr_accessor :new_category_name
  attr_accessor :full_name
  before_save :build_category_from_name
  
  def build_category_from_name
    puts("New Category Name = #{new_category_name}")
    self.categories.build(name: "#{new_category_name}") unless new_category_name.blank? 
  end
  
  def full_name
    [first_name, name].join(' ')
  end
end
