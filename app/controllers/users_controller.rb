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
    
    
    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :image1, :image2, :image3)
    end

    
end

