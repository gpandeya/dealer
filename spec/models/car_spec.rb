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

require 'rails_helper'

RSpec.describe Car, type: :model do
 
 describe '.new' do
    it 'instantiates a Car object' do
        c= Car.new
        expect(c.is_a?(Car)).to be true
        expect(c.attributes.keys.count).to eql(13)
    end
 end
 
 describe '#save' do
     context 'happy path' do
        it 'saves a car' do
            c= Car.new(make: 'Ford', model: 'Fusion', year: 2015, vin: '0123456789abcdefg')
            c.save
            expect(c.id).to_not be_nil
            expect(c.vin).to eql('0123456789ABCDEFG')
            expect(c.created_at).to_not be_nil
            expect(c.updated_at).to_not be_nil
            
            p c
        end
    end
    
    context 'invalid data' do
        it 'missing model - will not save' do
            c= Car.new(make: 'Ford', year: 2015, vin: 'abcd')
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:model].first).to eql("can't be blank")
            
        end
        
        it 'missing model year - will not save' do
            c= Car.new(make: 'Ford', vin: 'abcd')
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:model].first).to eql("can't be blank")
            expect(c.errors[:year].first).to eql("can't be blank")
            
        end
        
        it 'vin number is too short - will not save' do
            c= Car.new(make: 'Ford',model: 'Fusion', year: 2015, vin: 'abcd')
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:vin].second).to eql("is the wrong length (should be 17 characters)")
           
        end
        
        it 'vin number has incorrect syntax- will not save' do
            c= Car.new(make: 'Ford',model: 'Fusion', year: 2015, vin: '*123456789ABCDEFG')
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:vin].first).to eql("invalid representation")
           
        end
        
        it 'vin number already taken- will not save' do
            c= Car.new(make: 'Ford',model: 'Fusion', category: 'car', year: 2015, vin: 'A0000000000000003')
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:vin].first).to eql("has already been taken")
           
        end
        
        it 'make model and year already taken- will not save' do
            c= Car.new(make: 'Honda',model: 'Civic', category: 'car', year: 2015, vin: 'A0000000000000004')
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:make].first).to eql("has already been taken")
           
        end
        
        it 'cylinders must be even' do
            c= Car.new(make: 'Honda',model: 'Civic', year: 1899, vin: 'A0000000000000004', cylinders: 5)
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:cylinders].first).to eql("must be even")
           
        end
        
        it 'cylinders must be greater than 4' do
            c= Car.new(make: 'Honda',model: 'Civic', year: 1899, vin: 'A0000000000000004', cylinders: 2)
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:cylinders].first).to eql("must be greater than or equal to 4")
           
        end
        
        it 'cylinders must be less than 12' do
            c= Car.new(make: 'Honda',model: 'Civic', year: 1899, vin: 'A0000000000000004', cylinders: 14)
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:cylinders].first).to eql("must be less than or equal to 12")
           
        end
        
        it 'cylinders must not contain 10' do
            c= Car.new(make: 'Honda',model: 'Civic', year: 1899, vin: 'A0000000000000004', cylinders: 10)
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:cylinders].first).to eql("must be other than 10")
           
        end
        
        it 'year must be greater than or equal to 1900' do
            c= Car.new(make: 'Honda',model: 'Civic', year: 1899, vin: 'A0000000000000004', cylinders: 4)
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:year].first).to eql("must be greater than or equal to 1900")
           
        end
        
        it 'year must be less than or equal to 2020' do
            c= Car.new(make: 'Honda',model: 'Civic', category: 'car', year: 2021, vin: 'A0000000000000004', cylinders: 4)
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:year].first).to eql("must be less than or equal to 2020")
           
        end
        
        it 'category must be car sport suv truck' do
            c= Car.new(make: 'Honda',model: 'Civic', category: 'tr', year: 2021, vin: 'A0000000000000004', cylinders: 4)
            c.save
            expect(c.id).to be_nil
            expect(c.errors[:year].first).to eql("must be less than or equal to 2020")
           
        end
        
        
        
        
        
    end
    
   
    
 end


end
