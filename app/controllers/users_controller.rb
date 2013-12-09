class UsersController < ApplicationController
  before_action :guest_user,      only: [:new, :create]
  before_action :signed_in_user,  only: [:edit, :update, :index]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new #действие для отображения формы создания нового пользователя
    @user = User.new
  end

  def create #действие для сохранения нового пользователя по данным полученным их формы создания
    @user = User.new(user_params) 
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'      
    end
  end

  def edit #действие для отображения формы редактирования пользователя.      
  end

  def update #действие для сохранения новых данных пользователя из формы редактирования
    
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
      
    end

  end

  def destroy
    @user = User.find(params[:id])  
    unless @user.admin?
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url         
    else
      flash[:error] = "Can not delete admin"
      redirect_to users_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in." 
      end      
    end

    def guest_user
      redirect_to root_url if signed_in?              
    end

    def correct_user
      @user = User.find(params[:id])  
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end
