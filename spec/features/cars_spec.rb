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
    
     scenario 'User deletes a car' do
        car = Car.first
        visit "/cars/#{car.id}"
        click_link 'Delete'
        
        expect(page).to have_text('Cars')
        expect(page).to_not have_text(car.vin)

        
    end
    
    scenario 'User creates a new car' do
      
        visit "/cars/new"
       
        expect(page).to have_text('Add New Car')
        fill_in 'car[vin]' , with: 'C0000000000000001'
        fill_in 'car[make]' , with: 'AMC'
        fill_in 'car[model]' , with: 'Gremlin'
        fill_in 'car[year]' , with: '1973'
        click_button 'Create Car'
        
        expect(page).to have_text('C0000000000000001')
        expect(page).to have_text('AMC')
        expect(page).to have_text('Gremlin')

     
    end
    
    scenario 'User creates a car with invalid VIN' do
      
        visit "/cars/new"
       
        expect(page).to have_text('Add New Car')
        fill_in 'car[vin]' , with: 'C000000000000001'
        fill_in 'car[make]' , with: 'AMC'
        fill_in 'car[model]' , with: 'Gremlin'
        fill_in 'car[year]' , with: '1973'
        click_button 'Create Car'
        
        expect(page).to have_text('Add New Car')
        expect(page).to have_text('is the wrong length (should be 17 characters')
      
     
    end
    
     scenario 'User tries to edit car detail' do
        car = Car.first
        
        visit "/cars//#{car.id}/edit"
       
        expect(page).to have_text('Edit Car')
         fill_in 'car[vin]' , with: car.vin
        fill_in 'car[make]' , with: 'AMC'
        fill_in 'car[model]' , with: 'Gremlin'
        fill_in 'car[year]' , with: '1973'
        
        click_button 'Edit Car'
        
        
    end
    
    
end
