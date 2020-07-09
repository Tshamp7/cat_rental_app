class CatsController < ApplicationController
    def index
      @cats = Cat.all
      render :index
    end

    def show
      @cat = Cat.find(params[:id])
      @owner = @cat.owner.username
      @catrentalrequests = Catrentalrequest.where(cat_id: @cat.id).order('start_date ASC')
      render :show
    end

    def new
      @cat = Cat.new
      render :new
    end

    def create
      @cat = Cat.new(cat_params)
      @cat.user_id = current_user.id

      if @cat.valid?
        @cat.save
        redirect_to cat_url(@cat)
      else
        render :new
      end
    end

    def edit
      @cat = ensure_owns_cats
      @action = "update"
      if @cat.nil?
        redirect_to cats_url
      else
        render :edit
      end
    end

    def update
      @cat = ensure_owns_cats
      
      if @cat.update_attributes(cat_params)
        redirect_to cat_url(@cat)
      else
        render :edit
      end
    end

    def destroy
      @cat = Cat.find(params[:id])
      if @cat.destroy
        redirect_to cats_url, notice: 'Cat was destroyed'
      else
        flash[:error] = 'Something went wrong...'
      end
      
    end

    private
      
      def cat_params
        params.require(:cat).permit(:name, :birth_date, :sex, :color, :description, :user_id)
      end

      def ensure_owns_cats
        current_user.cats.where("id = ?", params[:id]).first
      end



end