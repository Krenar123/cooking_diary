module SessionsHelper
    def log_in(user)
        session[:user_id] = user_id
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        @current_user.present?
    end

    def log_out
        session.clear
        @current_user = nil
    end
end
