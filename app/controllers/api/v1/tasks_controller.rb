class Api::V1::TasksController < ApplicationController
  def index
    # ユーザー検索機能実装時にeager_loadに変更する。
    tasks = Task.preload(:user).order(:id)

    render(
      json: tasks.map { |task|
        {
          id: task.id,
          title: task.title,
          status: task.status,
          user_id: task.user_id,
          user: {
            name: task.user.name
          }
        }
      }
    )
  end
end
