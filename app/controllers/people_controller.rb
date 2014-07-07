class PeopleController < ApplicationController
  before_filter :authenticate_user!

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
  end
    
  def create
    
    @person = Person.new(secure_params)
    if @person.save
      redirect_to @person
    else
      render 'new'
    end    
  end
  
  def index
    @people = Person.order(:name)
  end
  
  def show
    @person = Person.find(params[:id])
  end
  
  def update
    @person = Person.find(params[:id])

    if @person.update_attributes(secure_params)
      redirect_to @person, :notice => "Person updated."
    else
      redirect_to 'edit', :alert => "Unable to update person."
    end
  end

  def destroy
    person = Person.find(params[:id])

    person.destroy
    redirect_to people_path, :notice => "#{person.name} deleted."
  end

  private

  def secure_params
    params.require(:person).permit(:name, :address, :city, :state, :zip, :tel, :email, :new_category_name, category_ids: [])
  end
end