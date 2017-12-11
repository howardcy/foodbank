class FbAgenciesController < ApplicationController
#before_action :load_fbagency


  def index
    @fb_agencies = FbAgency.all
  end

  def show
  end
  
  def new
    @wizard = ModelWizard.new(FbAgency, session, params).start
    @fb_agency = @wizard.object
    logger.debug "New agency: #{@fb_agency.attributes.inspect}"
  end

  def create
    @wizard = ModelWizard.new(FbAgency, session, params, agencies_params).continue
    @fb_agency = @wizard.object
    if @wizard.save
      @fb_agency = FbAgency.create!(agencies_params)
        session[:fbagency_attributes] = nil
        render '/forms/groceryplan'
    else
      render :new
    end
  end 
    def edit
      @wizard = ModelWizard.new(@fb_agencies, session, params).start
      @fb_agency = FbAgency.find(params[:id])
    end
    def update
      @wizard = ModelWizard.new(@fb_agencies, session, params, agencies_params).continue
      @fb_agency = FbAgency.find params[:id]
      @fb_agency.update_attributes!(agencies_params)
      flash[:notice] = "#{@fb_agency.AgencyName} was successfully updated."
      redirect_to fb_agencies_path
    end
    def destroy
        @fb_agency = FbAgency.find(params[:id])
        @fb_agency.destroy
        flash[:notice] = "Agency '#{@fb_agency.AgencyName}' deleted."
        redirect_to fb_agencies_path
    end
    
    def agencies_params
        params.require(:fb_agency).permit(:current_step, :AgencyName, :AgencyCounty, :AgencyNumber, :TodaysDate, :DofLastMonitor, :ParentAgency,
        :PAgencyNum, :SiteAddress, :SiteNumber, :ContactName, :ContactNum, :Director, :DirectorNum, :AdditionalContact, :AdditionalNum, 
        :PrimaryEmail, :DateMostRecentTraining, :TaxExemptOnFile, :IRSVerification, :DateOfVerification, :EEP, :DateOfContract,
        :SoupKitchen, :GroupHome, :Shelter, :Daycare, :YouthProgram, :FoodPantry, :Seasonal, :MobilePantry, :Backpack, :PersonInterviewed, :DaysOfOperation, :SingleAudit, :HandicapAccessible)
    end
end