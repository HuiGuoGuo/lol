#encoding:utf-8
class PersonRegistrationsController < ApplicationController
  # GET /person_registrations
  # GET /person_registrations.json
  before_filter :authenticate_user! ,:except => [:new, :create]
  def index
    @person_registrations = PersonRegistration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @person_registrations }
    end
  end

  # GET /person_registrations/1
  # GET /person_registrations/1.json
  def show
    @person_registration = PersonRegistration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person_registration }
    end
  end

  # GET /person_registrations/new
  # GET /person_registrations/new.json
  def new
    @person_registration = PersonRegistration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person_registration }
    end
  end

  # GET /person_registrations/1/edit
  def edit
    @person_registration = PersonRegistration.find(params[:id])
  end

  # POST /person_registrations
  # POST /person_registrations.json
  def create
    @person_registration = PersonRegistration.new(params[:person_registration])
    @person_registration.save
  end

  # PUT /person_registrations/1
  # PUT /person_registrations/1.json
  def update
    @person_registration = PersonRegistration.find(params[:id])

    respond_to do |format|
      if @person_registration.update_attributes(params[:person_registration])
        format.html { redirect_to @person_registration, notice: 'Person registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_registrations/1
  # DELETE /person_registrations/1.json
  def destroy
    @person_registration = PersonRegistration.find(params[:id])
    @person_registration.destroy

    respond_to do |format|
      format.html { redirect_to person_registrations_url }
      format.json { head :no_content }
    end
  end

  def show_postion
    @champion = PersonRegistration.where("state = '冠军'").first
    @the_second = PersonRegistration.where("state = '亚军'").first
    @the_third = PersonRegistration.where("state = '季军'").first
  end
  def subgroup
    @person_registrations = PersonRegistration.all
    #随机抽取俩个组
    z = Array.new
    y = Array.new
    x = Array.new
    @subgroup = Array.new
    @person_registrations.each.map {|x| y << x.id.to_s}

    subgroup_winer(y)

  end

  def get_winer_first

    if params[:get_winer_first].count == 1 && params[:o] #剩下3人的情况

      @the_one = params[:get_winer_first] #冠军
      @the_second_1 = params[:count]-params[:get_winer_first]  #争夺亚季军
      @the_second_2 = params[:o]#争夺亚季军
      redirect_to last_winer_person_registrations_path(:person => '3',:the_one => @the_one, :the_second_1 => @the_second_1, :the_second_2 => @the_second_2)

    elsif params[:get_winer_first].count == 2 && params[:o].blank? #剩下4人的情况 

      @The_third = params[:count]-params[:get_winer_first] #季军的争夺
      @The_first = params[:get_winer_first] #冠亚军的争夺
      redirect_to last_winer_person_registrations_path(:first=>@The_first,:third => @The_third)

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
      @champion = PersonRegistration.find(params[:the_one])  #冠军
      @champion.state = '冠军'
      @champion.save
      @second_place = PersonRegistration.find(params[:the_second]) #亚军
      @second_place.state = '亚军'
      @second_place.save
      p params[:count]
      params[:count].delete(params[:the_second])
      p params[:count]
      p @third_place = PersonRegistration.find(params[:count].first) #季军
      @third_place.state = '季军'
      @third_place.save

    else #剩四人情况

      @champion = PersonRegistration.find(params[:the_first])  #冠军
      @champion.state = '冠军'
      @champion.save
      params[:first].delete(params[:the_first]) 
      @second_place = PersonRegistration.find(params[:first].first) #亚军
      @second_place.state = '亚军'
      @second_place.save
      @third_place = PersonRegistration.find(params[:the_third]) #季军
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
