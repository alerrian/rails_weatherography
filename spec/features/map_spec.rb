require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'can see a map on the page' do
    visit '/'

    expect(page).to have_css('#map')
  end
end
