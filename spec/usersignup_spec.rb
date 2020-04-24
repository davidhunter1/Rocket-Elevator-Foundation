require 'ElevatorMedia/streamer.rb'
require 'rails_helper'

describe "Sign_Up", :type => :feature do
    context "if you enter proper credentials, success" do
        it "redirects you to index page when logged" do
            visit 'users/sign_up'
            fill_in 'Email', with: 'Signuptest@example.com'
            fill_in 'Password', with: 'Password1@' do
            expect(page).to have_text('Dashboard')
            end
        end
    end
end