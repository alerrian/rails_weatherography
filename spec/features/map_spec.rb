require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @arizona = State.create!(name: 'Arizona', lat: 34.4747, long: -111.7892, zoom: 5)
    @colorado = State.create!(name: 'Colorado', lat: 39.3026, long: -105.343061, zoom: 6)
    @connecticut = State.create!(name: 'Connecticut', lat: 41.5000, long: -72.7000, zoom: 9)
  end

  it 'can see a map on the page' do
    visit root_path

    expect(page).to have_css('#map')
  end

  it 'has a section for controls' do
    visit root_path

    expect(page).to have_css('#controls')
  end

  it 'has a drop down' do
    visit root_path

    expect(page).to have_css('#state_dropdown')
  end
end
