require 'ElevatorMedia/streamer.rb'
require 'rails_helper'
    # Test 1. describe ElevatorMedia::Streamer do
    # Test 2. describe '/getContent' do
    # Added context + Expecting 0 
    # it 'returns a useless quote as a string' do
    # Test 3.expect getContent to be_kind_of String
    #     end
 
describe ElevatorMedia::Streamer, :type => :feature do
    describe "getContent" do
        context "Get a useless quote" do
            it "returns a useless quote as a string" do
                expect(ElevatorMedia::Streamer.getContent).to be_kind_of String
            end
        end
    end
end

