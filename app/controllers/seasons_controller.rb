class SeasonsController < ApplicationController
  before_filter :only => [:create]

  def index


  end

  def new
    @season = Season.new
    render  :partial => 'form'
  end

  def create

    @season = Season.create(season: params[:season][:code])
    redirect_to :back 

  end

  private 

  def get_season
    @season = Season.find(params[:id])
  end

end
