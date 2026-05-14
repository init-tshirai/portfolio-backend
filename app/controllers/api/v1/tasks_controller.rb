class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    # todo: ページネーション実装
    tasks = search_tasks(Task.preload(:user).order(due_date: :desc))

    render(
      json: tasks.map { |task|
        {
          id: task.id,
          title: task.title,
          status: task.status,
          due_date: task.due_date&.strftime("%Y-%m-%d"),
          user: {
            id: task.user.id,
            name: task.user.name
          }
        }
      }
    )
  end

  private

  def search_tasks(tasks)
    tasks = tasks.where("title LIKE ?", "%#{Task.sanitize_sql_like(params[:title])}%") if params[:title].present?
    tasks = tasks.where(status: status_param) if params[:status].present?
    tasks = tasks.where("due_date >= ?", due_date_from.beginning_of_day) if params[:due_date_from].present?
    tasks = tasks.where("due_date <= ?", due_date_to.end_of_day) if params[:due_date_to].present?
    tasks = tasks.where(user_id: params[:user_id]) if params[:user_id].present?

    tasks
  end

  def status_param
    status = params[:status]
    return status if Task.statuses.key?(status)

    raise ActionController::BadRequest, "Invalid status: #{status}"
  end

  def due_date_from
    Date.iso8601(params[:due_date_from])
  rescue Date::Error
    raise ActionController::BadRequest, "Invalid due_date_from: #{params[:due_date_from]}"
  end

  def due_date_to
    Date.iso8601(params[:due_date_to])
  rescue Date::Error
    raise ActionController::BadRequest, "Invalid due_date_to: #{params[:due_date_to]}"
  end
end
