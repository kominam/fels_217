class StaticPagesController < ApplicationController
  skip_before_action :logged_in_user

  def show
    if valid_page?
      render template: "static_pages/#{params[:page]}"
    else
      render file: "public/404.html", status: 404, layout: false
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root +
      "app/views/static_pages/#{params[:page]}.html.erb"))
  end
end
