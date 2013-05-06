# encoding: UTF-8
#============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
#============================================================================

#-----------------------------------------------------------------------------
# User CRUD controller
#
class UsersController < ApplicationController
  before_filter :authenticate_admin!
  helper_method :sort_column, :sort_direction

  include DeviseHelper

  def index
    @users = User.search(params[:search]).
        order(sort_specification).
        page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    set_waypoint
    @user = User.new
  end

  def edit
    set_waypoint
    @user = User.find(params[:id])
  end

  def create
    begin
      @user = User.new(params[:user])

      @user.password = User.reset_password_token #won't actually be used...
      @user.reset_password_token = User.reset_password_token
      @user.reset_password_sent_at = Time.new

      @user.save

      @user.welcome

      redirect_to waypoint, notice: 'User was successfully created.'
    rescue ActiveRecord::RecordNotUnique
      render action: 'new', notice: 'User with this email address already exists'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to waypoint, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    set_waypoint
    @user = User.find(params[:id])
    @user.restaurants.each do |restaurant|
      restaurant.users.delete(@user)
    end
    @user.destroy
    redirect_to waypoint
  end

  # Change password
  def change_password
    @user = User.find(params[:id])
    @user.password = User.reset_password_token #won't actually be used...
    @user.reset_password_token = User.reset_password_token

    if @user.save
      redirect_to waypoint, notice: 'Email with password change instructions sent.'
    else
      redirect_to waypoint, notice: 'Could not send password change instructions. Sorry.'
    end
  end

  # Invite user
  def invite
    @user = User.find(params[:id])
    @user.welcome
    redirect_to waypoint, notice: 'User was successfully invited.'
  end

  # Associate user to restaurant
  def associate_user
    begin
      @restaurant = Restaurant.find(params[:restaurant_id])
      @user = User.find(params[:user_id])
      @restaurant.users << @user if @user
      @restaurant.save
      redirect_to waypoint, notice: 'User successfully associated with restaurant.'
    rescue ActiveRecord::RecordNotUnique
      redirect_to waypoint, alert: 'User already associated with restaurant.'
    end
  end

  # Dissociate user from restaurant
  def dissociate_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @user = User.find(params[:user_id])
    @restaurant.users.delete(@user) if @user
    @restaurant.save
    redirect_to waypoint, notice: 'User not associated with restaurant anymore.'
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'email'
  end

end
