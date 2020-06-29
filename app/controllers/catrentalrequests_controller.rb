class CatrentalrequestsController < ApplicationController
  def new
    @catrentalrequest = Catrentalrequest.new
    @cat_ids_for_form = Cat.all.ids
    render :new
  end

  def create
    @catrentalrequest = Catrentalrequest.new(catrentalrequest_params)

    if @catrentalrequest.valid?
      @catrentalrequest.approve!
      @catrentalrequest.save
      redirect_to cat_url(Cat.find(@catrentalrequest.cat_id))
    else
      render :new
    end
  end

  private
   def catrentalrequest_params
     params.require(:catrentalrequest).permit(:cat_id, :start_date, :end_date, :status)
   end
end