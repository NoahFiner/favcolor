class ColorsController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create]
  before_action :correct_user, only: :destroy

  def create
    cp = color_params
    cp[:hex][0] = ""
    @color = current_user.colors.build(cp)
    if @color.save
      flash[:success] = "Color posted"
    else
      @feed_colors = []
      if cp[:description].length >= 100
        flash[:danger] = "Your " + cp[:description].length.to_s + " character description is too long (maximum is 100 characters)."
      else
        flash[:danger] = "Something went wrong"
      end
    end
    redirect_to current_user
  end

  def destroy
    deleted_hex = @color.hex
    @color.destroy
    flash[:success] = '#' + deleted_hex + " deleted."
    redirect_to request.referrer || feed_url
  end

  private

    def color_params
      params.require(:color).permit(:hex, :description)
    end

    def correct_user
      @color = current_user.colors.find_by(id: params[:id])
      if @color.nil?
        redirect_to feed_url
        flash[:danger] = "You can't delete that color!"
      end
    end
end
