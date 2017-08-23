require 'rails_helper'

RSpec.feature "Cars", type: :feature do
    scenario 'User views the /cars page' do
        car =Car.first
        visit '/cars'
       
        expect(page).to have_text('Cars')
        expect(page).to have_text('Toyota')
        expect(page.html).to include('<h1>Cars</h1>')
        expect(page).to have_link('New',href: '/cars/new')
        expect(page).to have_link(car.vin,"/cars/#{car.id}")
    end
    
    scenario 'User views car show page' do
        car = Car.first
        visit '/cars'
        click_link car.vin
        
        expect(page).to have_text(car.vin)
        expect(page).to have_text(car.make)
        expect(page).to have_link('Edit',href: "/cars/#{car.id}/edit")
        expect(page).to have_link('Delete',href: "/cars/#{car.id}")
        
    end
    
end
