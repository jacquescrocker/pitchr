class PitchesController < ApplicationController
  layout "application"
  before_filter :login_required
  before_filter :billing_required

  # GET /pitches
  # GET /pitches.json
  def index
    @pitches = current_user.pitches

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pitches }
    end
  end

  # GET /pitches/1
  # GET /pitches/1.json
  def show
    @pitch = current_user.pitches.by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pitch }
    end
  end

  # GET /pitches/new
  # GET /pitches/new.json
  def new
    @pitch = current_user.pitches.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pitch }
    end
  end

  # GET /pitches/1/edit
  def edit
    @pitch = current_user.pitches.by_id(params[:id])
  end

  # POST /pitches
  # POST /pitches.json
  def create
    @pitch = current_user.pitches.build(pitch_attributes)

    respond_to do |format|
      if @pitch.save
        format.html { redirect_to @pitch, notice: 'Pitch was successfully created.' }
        format.json { render json: @pitch, status: :created, location: @pitch }
      else
        format.html { render action: "new" }
        format.json { render json: @pitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pitches/1
  # PUT /pitches/1.json
  def update
    @pitch = current_user.pitches.by_id(params[:id])

    respond_to do |format|
      if @pitch.update_attributes(pitch_attributes)
        format.html { redirect_to @pitch, notice: 'Pitch was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pitches/1
  # DELETE /pitches/1.json
  def destroy
    @pitch = current_user.pitches.by_id(params[:id])
    @pitch.destroy

    respond_to do |format|
      format.html { redirect_to pitches_url }
      format.json { head :ok }
    end
  end

  protected
  def pitch_attributes
    # choose only the attributes that are allowed to be editable
    (params[:pitch] || {}).slice(*[
      :title,
      :body,
    ])
  end
end
