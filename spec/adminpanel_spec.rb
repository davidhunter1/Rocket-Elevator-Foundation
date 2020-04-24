require 'ElevatorMedia/streamer.rb'
require 'rails_helper'
require 'spec_helper'

describe "AdminPanel", :type => :feature do
    context "if you enter the right email and password combination, success" do
        it "redirects you to admin dashboard" do
            visit 'admin/login'
            fill_in 'Email', with: 'admin@example.com'
            fill_in 'Password', with: 'password' do
            expect(page).to have_text('Dashboard')
            end
        end
    end
end