class LeadsController < ApplicationController
  layout "application"
  before_filter :login_required
  before_filter :billing_required

  # GET /leads
  # GET /leads.json
  def index
    @leads = current_user.leads

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leads }
    end
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
    @lead = current_user.leads.by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lead }
    end
  end

  # GET /leads/new
  # GET /leads/new.json
  def new
    @lead = current_user.leads.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lead }
    end
  end

  # GET /leads/1/edit
  def edit
    @lead = current_user.leads.by_id(params[:id])
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = current_user.leads.build(lead_attributes)

    respond_to do |format|
      if @lead.save
        format.html { redirect_to @lead, notice: 'Lead was successfully created.' }
        format.json { render json: @lead, status: :created, location: @lead }
      else
        format.html { render action: "new" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leads/1
  # PUT /leads/1.json
  def update
    @lead = current_user.leads.by_id(params[:id])

    respond_to do |format|
      if @lead.update_attributes(lead_attributes)
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    @lead = current_user.leads.by_id(params[:id])
    @lead.destroy

    respond_to do |format|
      format.html { redirect_to leads_url }
      format.json { head :ok }
    end
  end

  protected
  def lead_attributes
    # choose only the attributes that are allowed to be editable
    (params[:lead] || {}).slice(*[
      :name,
      :referral_url,
    ])

  end
end
