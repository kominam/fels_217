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

  def load_user
    @user = User.find_by id: params[:id]
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def correct_answer answer_id
    answer_id.nil? ? false : Answer.find_by(id: answer_id).is_correct
  end

  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to(name, '#', class: "add_fields",
      data: {id: id, answers: fields.gsub("\n", "")})
  end
end
