module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def render_404
    render file: "public/404.html", status: 404, layout: false
  end

  def verify_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
