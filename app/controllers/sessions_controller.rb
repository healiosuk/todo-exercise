class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    digest = Rails.application.credentials.password_digest
    if BCrypt::Password.new(digest) == params[:password]
      session[:authenticated] = true
      redirect_to todos_path, notice: "Signed in."
    else
      flash.now[:alert] = "Invalid password."
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    session.delete(:authenticated)
    redirect_to login_path, notice: "Signed out."
  end
end
