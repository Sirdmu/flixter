class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]

  def show
  end

  private

  def require_authorized_for_current_lesson
    unless current_user.enrolled_in?(current_lesson.section.course)
      # render plain: “Unauthorized”, status: :unauthorized
      redirect_to courses_path, alert: 'You are not currently enrolled in this Course'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
