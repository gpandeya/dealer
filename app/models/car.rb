# == Schema Information
#
# Table name: cars
#
#  id           :integer          not null, primary key
#  make         :string           not null
#  model        :string           not null
#  year         :integer          not null
#  vin          :string           not null
#  color        :string           default("black")
#  category     :string           default("car")
#  cylinders    :integer          default(4)
#  displacement :float            default(0.0)
#  mpg          :integer          default(0)
#  hp           :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Car < ApplicationRecord
    before_validation :upper_vin, :upper_category,:check_vin
    
    
    validates :make, :model, :year, presence: true
    validates :vin, uniqueness: true, length: {is: 17}
    validates :make, uniqueness: { scope: [:model, :year]}
    validates :category, inclusion: { in: %w(CAR SPORT SUV TRUCK), message: "%{value} is not a valid category" }
    validates :cylinders, numericality: { only_integer: true, even: true, greater_than_or_equal_to: 4, less_than_or_equal_to: 12 , other_than: 10}
    validates :year, numericality: { only_integer: true,  greater_than_or_equal_to: 1900, less_than_or_equal_to: 2020}
   
    
    private 
    
    def upper_vin
        self.vin = self.vin.upcase if self.vin
    end
    
     def upper_category
        self.category = self.category.upcase if self.category
    end
    
    def check_vin
        self.errors.add(:vin, 'invalid representation') if self.vin && self.vin !~ /^[0-9A-Z]{17}$/
    end
    
   
    
end
