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

  def user_activity activity
    activity.user.user_name if activity.user == current_user
  end

  def activity_description activity
    case activity.action_type
    when Activity.actions[:start_lesson]
      t ".started_lesson"
    when Activity.actions[:finish_lesson]
      t ".finish_lesson"
    when Activity.actions[:follow]
      t ".follow"
    when Activity.actions[:unfollow]
      t ".unfollow"
    end
  end

  def target_object activity
    case activity.action_type
    when Activity.actions[:start_lesson]
      t ".started_lesson"
      lesson = Lesson.find_by id: activity.target_id
      link_to lesson.category_name, lesson.category
    when Activity.actions[:finish_lesson]
      t ".finish_lesson"
      lesson = Lesson.find_by id: activity.target_id
      link_to lesson.category_name, lesson.category
    when Activity.actions[:follow]
      t ".follow"
      user = User.find_by id: activity.target_id
      link_to user.user_name, user
    when Activity.actions[:unfollow]
      t ".unfollow"
      user = User.find_by id: activity.target_id
      link_to user.user_name, user
    end
  end
end
