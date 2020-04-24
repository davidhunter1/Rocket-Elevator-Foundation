require 'rails_helper'
require 'spec_helper'

RSpec.describe "Interventions 200 response", :type => :controller do
    let!(:int){Intervention.new}
    # Testing if the interventions returns a succesful HTTP response
    it"should give back a 200 succesful HTTP response" do
        expect(@response.status).to eq (200)
    end    
end

