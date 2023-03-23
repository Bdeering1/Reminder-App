defmodule ReminderAppWeb.Router do
  use ReminderAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReminderAppWeb do
    pipe_through :api
  end
end
