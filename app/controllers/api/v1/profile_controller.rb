class Api::V1::ProfileController < ApplicationController
  def show
    render(
      json: {
        name: "Teruaki Shirai",
        role: "Web Developer",
        message: "Rails APIから取得したプロフィールです。"
      }
    )
  end
end
