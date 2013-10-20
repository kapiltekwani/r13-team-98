class UsersController < ApplicationController
  def facebook_oauth
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, users_initialize_data_url)
    auth_url =  session[:oauth].url_for_oauth_code
    redirect_to auth_url
  end

  def initialize_data
    if params[:code]
      # acknowledge code and get access token from FB
      session[:access_token] = session[:oauth].get_access_token(params[:code])
      api = Koala::Facebook::API.new(session[:access_token])
    end

    begin
      User.delay.generate_user_data(api) if current_user.sign_in_count.to_i <= 1
    rescue Exception => ex
      p ex.message
      #if user is not logged in and an exception is caught, redirect to the page where logging in is requested
      redirect_to users_facebook_oauth_path and return
    end

    redirect_to new_answer_path and return
  end
end
