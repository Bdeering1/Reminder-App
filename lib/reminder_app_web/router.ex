defmodule ReminderAppWeb.Router do
  use ReminderAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReminderAppWeb do
    pipe_through :api
    get "/", DefaultController, :index
    get "/try-notify", DefaultController, :try_notify
    get "/tasks", TaskController, :index
    post "/task", TaskController, :create
    get "/task/:id", TaskController, :show
    patch "/task/:id", TaskController, :update
  end
end
