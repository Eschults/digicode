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
    flash.now["notice"] = "Your code will only be shared to users you accepted / asked as friends"
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to users_path
      flash.now["notice"] = "Your code has been saved"
    else
      render :edit
    end
  end

  def ask_for_code
    if Friendship.find_by(sender: current_user, receiver: @user)
      @friendship = Friendship.find_by(sender: current_user, receiver: @user)
      @friendship.accepted = nil
    elsif Friendship.find_by(sender: @user, receiver: current_user)
      @friendship = Friendship.find_by(sender: @user, receiver: current_user)
      @friendship.accepted = nil
    else
      @friendship = Friendship.new(sender: current_user, receiver: @user)
    end
    if @friendship.save
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js
      end
    else
      redirect_to :back
    end
    authorize @user
  end

  def accept_request
    @friendship = Friendship.find_by(sender: @user, receiver: current_user)
    @friendship.accepted = true
    if @friendship.save
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js
      end
    else
      redirect_to :back
    end
    authorize @user
  end

  def decline_request
    @friendship = Friendship.find_by(sender: @user, receiver: current_user)
    @friendship.accepted = false
    if @friendship.save
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js
      end
    else
      redirect_to :back
    end
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
