#encoding:utf-8
class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.json
  before_filter :authenticate_user! ,:except => [:new, :create]
  def index
    @teams = Team.all

    respond_to do |format|
      format.html { } # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    @registrations = @team.registrations

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
     name = params[:team][:name]
    if Team.all.collect {|t| t.name}.include?(name)
      render :js =>'alert("这个队伍名称已经被别人用了哟，请换个名字")'
    else
      @audit = 0
      p params[:team]
      @team = Team.new(params[:team])
      @team.save
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url(audit: '0') }
      format.json { head :no_content }
    end
  end

  def show_postion
    @champion = Team.where("state = '冠军'").first
    @champion_registration = @champion.registrations
    @the_second = Team.where("state = '亚军'").first
    @the_second_registration = @the_second.registrations
    @the_third = Team.where("state = '季军'").first
    @the_third_registration = @the_third.registrations

  end

  def subgroup
    @team = Team.all
    #随机抽取俩个组
    z = Array.new
    y = Array.new
    x = Array.new
    @subgroup = Array.new
    @team.each.map {|x| y << x.id.to_s}

    subgroup_winer(y)

  end

  def get_winer_first

    if params[:get_winer_first].count == 1 && params[:o] #剩下3人的情况

      @the_one = params[:get_winer_first] #冠军
      @the_second_1 = params[:count]-params[:get_winer_first]  #争夺亚季军
      @the_second_2 = params[:o]#争夺亚季军
      redirect_to last_winer_teams_path(:person => '3',:the_one => @the_one, :the_second_1 => @the_second_1, :the_second_2 => @the_second_2)

    elsif params[:get_winer_first].count == 2 && params[:o].blank? #剩下4人的情况 

      @The_third = params[:count]-params[:get_winer_first] #季军的争夺
      @The_first = params[:get_winer_first] #冠亚军的争夺
      redirect_to last_winer_teams_path(:first=>@The_first,:third => @The_third)

    else

      if params[:o].blank?

      else
        params[:get_winer_first] = params[:get_winer_first] << params[:o]
      end
      subgroup_winer(params[:get_winer_first])
    end
  end

  def last_winer
    if params[:person] == '3'

      @the_one = params[:the_one]

      @second_arry = []
      @second_arry << params[:the_second_1].first
      @second_arry << params[:the_second_2]

    else

      @first = params[:first]
      @third = params[:third]

    end


  end

  def position #名次

    if params[:the_one] #剩三人情况
      @champion = Team.find(params[:the_one])  #冠军
      @champion.state = '冠军'
      @champion.save
      @second_place = Team.find(params[:the_second]) #亚军
      @second_place.state = '亚军'
      @second_place.save
      p params[:count]
      params[:count].delete(params[:the_second])
      p params[:count]
      p @third_place = Team.find(params[:count].first) #季军
      @third_place.state = '季军'
      @third_place.save

    else #剩四人情况

      @champion = Team.find(params[:the_first])  #冠军
      @champion.state = '冠军'
      @champion.save
      params[:first].delete(params[:the_first]) 
      @second_place = Team.find(params[:first].first) #亚军
      @second_place.state = '亚军'
      @second_place.save
      @third_place = Team.find(params[:the_third]) #季军
      @third_place.state = '季军'
      @third_place.save
    end
  end

  private
  def subgroup_winer(y)

    z = Array.new
    x = Array.new
    @subgroup = Array.new
    count = y.length
    if count%2 != 0
      luck = rand(count)
      @o = y[luck].to_s
      y.delete(@o)
    end
    count = y.length
    a = rand(count)
    x << a
    while x.size < 2 do
      b = rand(count)
      x << b unless b.eql?a
    end
    x.each do |x|
      z << y[x].to_s
    end
    @subgroup << z
    for i in 0..count/2-2 do
      y = y -z 
      count = y.length
      z = Array.new
      x = Array.new
      a = rand(count)
      x << a
      while x.size < 2 do
        b = rand(count)
        x << b unless b.eql?a
      end
      x
      x.each do |x|
        z << y[x].to_s
      end
      @subgroup << z
    end
  end
end
