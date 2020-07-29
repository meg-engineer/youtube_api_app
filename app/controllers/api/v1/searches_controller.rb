class Api::V1::SearchesController < ApplicationController
  def index
    @items = Youtube::SearchService.new(params[:keyword], params[:order]).run
  end
end