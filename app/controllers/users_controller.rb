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
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def ask_for_code
    @friendship = Friendship.new(sender: current_user, receiver: @user)
    if @friendship.save
      redirect_to users_path
    else
      redirect_to :back
    end
    authorize @user
  end

  def accept_request
    @friendship = Friendship.find_by(sender: @user, receiver: current_user)
    @friendship.accepted = true
    @friendship.save
    redirect_to users_path
    authorize @user
  end

  def decline_request
    @friendship = Friendship.find_by(sender: @user, receiver: current_user)
    @friendship.accepted = false
    @friendship.save
    redirect_to users_path
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
