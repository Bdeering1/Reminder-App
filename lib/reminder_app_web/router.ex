defmodule ReminderAppWeb.Router do
  use ReminderAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReminderAppWeb do
    pipe_through :api
    get "/", DefaultController, :index
    get "/try-notify", TaskController, :try_notify
    get "/tasks", TaskController, :index
    get "/task/:id", TaskController, :show
    post "/task", TaskController, :create
    patch "/task/:id", TaskController, :update
    delete "/task/:id", TaskController, :delete
  end
end
