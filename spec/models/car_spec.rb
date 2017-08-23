require 'rails_helper'

RSpec.describe Car, type: :model do
 
 describe '.new' do
    it 'instantiates a Car object' do
        c= Car.new
        expect(c.is_a?(Car)).to be true
        expect(c.attributes.keys.count).to eql(13)
    end
 
 end


end
