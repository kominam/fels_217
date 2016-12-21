class LessonsController < ApplicationController
  before_action :load_lesson
  before_action :valid_user, only: [:show, :edit, :update]

  def create
    unless current_user.is_admin
      @lesson = current_user.lessons.build category_id: params[:category_id]
      if @lesson.save
        flash[:success] = t ".lesson_created"
        @lesson.start_lesson_action current_user
        redirect_to edit_lesson_path @lesson
      else
        flash[:danger] = @lesson.errors.full_messages
        redirect_to categories_path
      end
    else
      flash[:danger] = t "permisson_restrict"
      redirect_to root_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson.update_attributes lesson_params.merge is_complete: true
      flash[:success] = t ".update_sucess"
      @lesson.finish_lesson_action current_user
      redirect_to lesson_path @lesson
    else
      flash[:danger] = t ".update_fail"
      redirect_to categories_path
    end
  end

  private

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end

  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :answer_id]
  end

  def valid_user
    unless current_user.id == @lesson.user_id
      flash[:danger] = t "permisson_restrict"
      redirect_to root_path
    end
  end
end
