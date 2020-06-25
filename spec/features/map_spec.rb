require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'can see a map on the page' do
    visit root_path

    expect(page).to have_css('#map')
  end

  it 'has a section for controls' do
    visit root_path

    expect(page).to have_css('#controls')
  end
end
