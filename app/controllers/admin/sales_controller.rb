class Admin::SalesController < ApplicationController

def index
  #render :index
  @sales = Sale.all
end

end
