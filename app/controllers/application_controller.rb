class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def moon
        cookies[:moon] = {
            value: 'dark'
        }
        redirect_to request.referer, notice: "Turn on dark mode"
    end

    def sun
        cookies.delete(:moon)
        redirect_to request.referer, notice: "Turn off dark mode"
    end

    protected
    
    def configure_permitted_parameters
        added_attrs = [:avatar, :username, :phone_number, :email, :password, :password_confirmation, :remember_me]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
