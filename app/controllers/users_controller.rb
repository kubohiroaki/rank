class UsersController < ApplicationController
    
    def sign_up
        @user = User.new
        render layout: "application_not_login"
    end
  
    def sign_up_process
        @user = User.new(user_params)
        if @user.save
            user_sign_in(@user)
            redirect_to movies_path and return
        else
            flash[:danger] = "ユーザー登録に失敗しました"
            render "sign_up"
        end
    end
    
    def sign_in
        @user = User.new
        render layout: "application_not_login"
    end
    
    def sign_in_process
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            flash[:success] = "サインインに成功しました"
            user_sign_in(user)
            redirect_to movies_path and return
        else
            flash[:danger] = "サインインに失敗しました"
            render "sign_in"
        end
    end
    
    def sign_out
        user_sign_out
        redirect_to sign_in_path and return
    end
    
    def show
        @user = User.find_by(email: "shokatsuryou3@yahoo.co.jp")
    end
    
    def edit
        @user = User.find(current_user.id)
    end
    
    def update
      @user = User.find(current_user.id)
      if @user.update_attributes(user_params)
        flash[:success] = "プロフィール更新成功"
        redirect_to profile_show_path and return        
      else
        flash[:danger] = "プロフィール更新失敗"
        redirect_to profile_edit_path and return
      end
    end
    
    private
    def user_params
        params.require(:user).permit(:description, :name, :email, :password, :password_confirmation, :image, :image1, :image2, :image3)
    end

    
end

