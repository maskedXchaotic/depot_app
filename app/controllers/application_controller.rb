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
  before_action :set_counter, -> { @request_start_time = Time.now }
  after_action -> { response.headers["x-responded-in"] = Time.now - @request_start_time }
  protected
    def authorize
      unless User.find_by(id: session[:user_id])
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
      if(session[:user_id])
        user_counter = Counter.find_by(user_id:session[:user_id])
        user_counter.count += 1
        @counter = user_counter.count
        user_counter.save
      end
    end
    
    def check_last_activity
      if(session[:user_id])
        user = User.find(session[:user_id])
        user.last_activity_time ||= Time.now
        if Time.now - user.last_activity_time > 300
          redirect_to sessions_destroy_path, notice: 'Session Expired after 5 mimnutes of activity'
        else
          user.last_activity_time = Time.now
          user.save
        end
      end
    end
end
