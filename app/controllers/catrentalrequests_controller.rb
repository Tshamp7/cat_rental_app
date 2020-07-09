class CatrentalrequestsController < ApplicationController
  def new
    @catrentalrequest = Catrentalrequest.new
    @cat_ids_for_form = Cat.all.ids
    render :new
  end

  def create
    @catrentalrequest = Catrentalrequest.new(catrentalrequest_params)
    
    if @catrentalrequest.valid?
      #@catrentalrequest.approve!
      @catrentalrequest.status = "PENDING"
      @catrentalrequest.save
      redirect_to cat_url(Cat.find(@catrentalrequest.cat_id))
    else
      render :new
    end
  end

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat_rental_request.current_cat)
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat_rental_request.current_cat)
  end



  private
   def catrentalrequest_params
     params.require(:catrentalrequest).permit(:cat_id, :start_date, :end_date, :status)
   end

   def current_cat_rental_request
    @rental_request ||= Catrentalrequest.includes(:cat).find(params[:id])
   end
end