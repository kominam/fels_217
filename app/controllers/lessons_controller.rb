class LessonsController < ApplicationController
  before_action :load_lesson

  def create
    @lesson = current_user.lessons.build category_id: params[:category_id],
      user_id: current_user.id
    if @lesson.save!
      flash[:success] = t ".lesson_created"
      redirect_to edit_lesson_path @lesson
    else
      flash[:danger] = @lesson.errors._full_messages
      redirect_to categories_path
    end
  end

  def edit
  end

  private

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end

  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :answer_id]
  end
end
