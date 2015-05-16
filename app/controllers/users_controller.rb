class UsersController < ApplicationController
  before_action :set_user, except: :index
  after_action :verify_authorized, except: :index, unless: :devise_controller?

  def index
    @users = policy_scope(User)
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
  end

  def ask_for_code
    authorize @user
  end

  def answer
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:digicode)
  end
end
