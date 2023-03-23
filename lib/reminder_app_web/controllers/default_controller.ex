defmodule ReminderAppWeb.DefaultController do
  use ReminderAppWeb, :controller

  def index(conn, _params) do
    text conn, "Reminder App API - #{Mix.env()}"
  end
end
