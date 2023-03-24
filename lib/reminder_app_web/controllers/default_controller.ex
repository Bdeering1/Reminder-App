defmodule ReminderAppWeb.DefaultController do
  use ReminderAppWeb, :controller

  def index(conn, _params) do
    text conn, "Reminder App API - #{Mix.env()}"
  end

  def try_notify(_conn, _params) do
    ReminderApp.Notifications.try_notify()
  end
end
