class SettingsController < ApplicationController
    def index
        authorize! :settings, current_user
        
        @user = current_user
        @validator = NullValidator.instance
    end

    def update
        authorize! :settings, current_user

        # get a fresh instance to avoid side effects on 
        # current_user internal cache
        @user = User[current_user.id]
        attrs = _update_params
        @user.update attrs

        @validator = UserValidator.new(@user)

        if @validator.valid?
            @user.save
            flash[:notice] = "Settings updated"
            redirect_to root_url
        else
            flash[:notice] = "Something is not right!"
            render 'index'
        end
    end

    private

    def _update_params
        res = params.permit(:name, :notifications_enabled)
        res[:notifications_enabled] = !!res[:notifications_enabled]
        res
    end
end
