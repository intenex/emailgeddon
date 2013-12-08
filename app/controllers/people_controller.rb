require './lib/functions.rb'

class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @person = Person.new
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    if person_params[:firstname].blank? == true || person_params[:lastname].blank? == true || person_params[:domain].blank? == true
        render :new
    end

    # must initialize this array or else the if @harvard[2] != nil statements throw a bitch fit at you
    @harvard = Array.new

    # if domain is college.harvard.edu or fas.harvard.edu, cross-check with spreadsheet instead of doing all the email combos
    if person_params[:domain] == 'college.harvard.edu' || person_params[:domain] == 'fas.harvard.edu'
      @harvard = find_harvard(person_params[:firstname], person_params[:lastname])
    end
    # if the person is found and an email for them is in the spreadsheet, just find the info for that email
    if @harvard[2] != nil
        @harvard_rapport = find_email(@harvard[2])
    # otherwise, if not a harvard undergrad email or no email for given person found, do the whole genEmails combo thing
    else
      # create a hash with all the different email combinations
      @combos = genEmails(person_params[:firstname], person_params[:lastname], person_params[:domain])
      @email_results = Array.new
      # for each combo check if email valid, and if so, add to @email_results
      @combos.each do |key, value|
        # use a temp array to store all returned results, even nil ones
        ephemeral_array = Array.new
        ephemeral_array.push(find_email(value))
        ephemeral_array.each do |person|
          # if person does exist, add them to @email_results
          if person != "Invalid email!"
            @email_results.push(person)
          end
        end
      end
    end

    respond_to do |format|
      if @person.save
        format.html { render action: 'show', status: :created, location: @person }
        format.json { render action: 'show', status: :created, location: @person }
      else
        format.html { render action: 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:firstname, :lastname, :domain)
    end
end