class InterventionsController < ApplicationController
   
    

  def intervention
   
  end

  # Method to get buildings related to a selected customer
  def get_building
      if params[:customer].present?
          @buildings = Customer.find(params[:customer]).buildings
      else
          @buildings = Customer.all
      end
      if request.xhr?
          respond_to do |format|
              format.json {
                  render json: {buildings: @buildings}
              }
          end
      end
  end

  # Method to get batteries related to a selected building
  def get_battery
      if params[:building].present?
          @batteries = Building.find(params[:building]).batteries
      else
          @batteries = Building.all
      end
      if request.xhr?
          respond_to do |format|
              format.json {
                  render json: {batteries: @batteries}
              }
          end
      end
  end

  # Method to get columnns related to a selected battery
  def get_column
      if params[:battery].present?
          @columns = Battery.find(params[:battery]).columns
      else
          @columns = Battery.all
      end
      if request.xhr?
          respond_to do |format|
              format.json {
                  render json: {columns: @columns}
              }
          end
      end
  end

  # Method to get elevators related to a selected column
  def get_elevator
      if params[:column].present?
          @elevators = Column.find(params[:column]).elevators
      else
          @elevators = Column.all
      end
      if request.xhr?
          respond_to do |format|
              format.json {
                  render json: {elevators: @elevators}
              }
          end
      end
  end
  


  def new
    @intervention = Intervention.new
  end

  
  

#   declarations used for Zendesk API, and the controller submission form
 
  def create
    
    @intervention = Intervention.new(intervention_params)

      # Variables needed and used in the Zendesk API message

      @customer_company = Customer.find(params[:customer]).company_name

      # Rule to avoid an error message if no employee is selected
      if @intervention.employee_id != nil
      @employee_fname = Employee.find(params[:employee]).first_name
      @employee_lname = Employee.find(params[:employee]).last_name

      added_details = "(#{@employee_fname} #{@employee_lname} was asked to answer this ticket)"
      else
        added_details = ""
      end

     
      @intervention.employee_id = params[:employee]
      @intervention.customer_id = params[:customer]
      @intervention.building_id = params[:building]
      @intervention.battery_id = params[:battery]
      @intervention.column_id = params[:column]
      @intervention.elevator_id = params[:elevator]
      @intervention.result = "Incomplete"  #  Default value
      @intervention.report = params[:report]
      @intervention.status = "Pending"   # Default value

  
    
    #  Zendesk API  
  
    ZendeskAPI::Ticket.create!(@client, 
      :subject => "Intervention ticket from employee # -  - Rocket Elevators",
      :requester => {"name": "name"},
      :comment => { :value => "Employee #{@intervention.author}  working for customer #{@intervention.customer_id} (#{@customer_company}) on building  #{@intervention.building_id}, battery #{@intervention.battery_id}, column #{@intervention.column_id} and elevator #{@intervention.elevator_id} has dispatched an employee (#{@intervention.employee_id}) to answer the present ticket.
      Here is the report of the intervention : 
      #{@intervention.report}  
      #{added_details}
      "}, 
      :submitter_id => @intervention.author,
      :type => "problem",
      :priority => "urgent")
      
  #END Zendesk API session 

    respond_to do |format|
      if @intervention.save!
        format.html { redirect_to "/interventions" }
        format.json { render :show, status: :created, location: @intervention }
        p @intervention
        p "Intervention form sent"
      else
        format.html { redirect_to "/interventions" }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
        p "error"
      end
    end
  end

 

 

 

    
    def intervention_params
      params.permit( :employee_id, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :result, :report, :status)
    end
end