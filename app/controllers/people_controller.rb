class PeopleController < ApplicationController
  require 'prawn'
#  require 'ap'
  require 'pp'
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
     
    respond_to do |format|
      format.html do 
        if !params[:query].blank?  
          session[:previous] = params[:query]
        end
        session[:query] = params[:query]
            
        @people = Person.search(session[:query]).paginate(:page => params[:page], per_page: '10')
#    puts (" Previous query #{session[:previous]}") 
#    puts (" Search query #{session[:query]}")
#    puts (" Current query #{params[:query]}") 
#    puts('End HTML')    
      end #HTML
      
      format.pdf do
        if !session[:previous].blank?
          session[:query] = session[:previous]
        end
        session[:previous]  = params[:query] 
        @people = Person.search(session[:query]) # unpaginated and uses previous search query string
        pdf = Prawn::Document.new
        @people.each do |person|
         pdf.text  person.full_name
         pdf.text  person.address
         pdf.text  person.city
         pdf.text  person.state
         pdf.text  person.zip
         pdf.move_down 30 
        end        
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
 # puts (" Previous query #{session[:previous]}") 
 # puts (" Search query #{session[:query]}")
 # puts (" Current query #{params[:query]}") 
 # puts ('end pdf')
      end #PDF
    end
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
    params.require(:person).permit(:first_name, :name, :address, :city, :state, :zip, :tel, :email, :birthday, 
    :birthday_text, :anniversary, :anniversary_text, :new_category_name,:notes, category_ids: [])
  end
end