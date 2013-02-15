class TemplatesController < ApplicationController
  helper_method :partial_path
  layout false

  def index
  end

  private
  def partial_path
    "templates/#{params[:model]}/#{params[:partial_type]}"
  end
end
