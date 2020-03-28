class MenusController < ApplicationController
  def menu
    @menus = Menu.all
  end
end