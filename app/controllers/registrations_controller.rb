#encoding:utf-8
class RegistrationsController < ApplicationController
  # GET /registrations
 # GET /registrations.json
  def index
    @registrations = Registration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    @team = Team.find(params[:id])
    @registration = Registration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  def new_member
    @team = Team.find(params[:id])
    @registration = Registration.new
    render :partial => 'new_member'
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params[:registration])
    @team = Team.find(params[:team_id])
    @registration.team_id = params[:team_id] 
    @registration.save
  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  def update
    @registration = Registration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end
  def judge_is_leader
    team = Team.find(params[:id])
    registrations = team.registrations
    if registrations.map {|registration| registration.is_leader}.include?(true)
      result = 1 
    end
    respond_to do |format|
      format.json {render :json=> result}
    end
  end
end
