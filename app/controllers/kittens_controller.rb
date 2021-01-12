class KittensController < ApplicationController

  def index 
    @kittens = Kitten.all 
    respond_to do |format| 
      format.html
      format.json { render json: @kittens }
    end 
  end

  def new 
    @kitten = Kitten.new 
  end 

  def show 
    @kitten = Kitten.find params[:id]
    respond_to do |format| 
      format.html
      format.json { render json: @kitten }
    end 
  end

  def edit 
    @kitten = Kitten.find params[:id]
  end 

  def create 
    @kitten = Kitten.new kitty_params 

    if @kitten.save 
      flash[:notice] = "Kitty made"
      redirect_to kittens_path @kitten
    else 
      flash.now[:alert] = "Something went wrong"
      render :new
    end
  end 

  def update 
    @kitten = Kitten.find(params[:id])
    if @kitten.update(kitty_params)
      flash[:notice] = "Kitty made"
      redirect_to @kitten 
    else 
      flash.now[:alert] = 'something went wrong'
      render :edit 
    end 
  end

  def destroy 
    @kitten = Kitten.find(params[:id])

    @kitten.destroy 
    flash[:notice] = "Congrats, Kitty killed"
    redirect_to root_path
  end 

  private

  def kitty_params 
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end 

end
