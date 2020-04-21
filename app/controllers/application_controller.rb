#---
# Excerpted from "Agile Web Development with Rails 6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails6 for more book information.
#---
class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params
  before_action :check_last_activity
  before_action :set_counter
  around_action :set_responded_in_header
  protected
    def authorize
      @current_user = User.find_by(id: session[:user_id])
      unless @current_user
        redirect_to login_url, notice: "Please log in"
      end
    end
  protected
    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def set_counter
      user_counter = @current_user.counters.find_by(url: request.original_url)
      if user_counter
        user_counter.increment(:count, by = 1)
      else
        @current_user.counters.build(url: request.original_url)
      end
      @counter = user_counter.count
    end
    
    def check_last_activity
      if Time.current - @current_user.last_activity_time > 300
        redirect_to sessions_destroy_path, notice: 'Session Expired after 5 minutes of inactivity'
      else
        @current_user.set_last_activity
      end
    end

    def set_responded_in_header
      request_start_time = Time.current
      yield
      response.headers["x-responded-in"] = Time.current - request_start_time
    end


end
