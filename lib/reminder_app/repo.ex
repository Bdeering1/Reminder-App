defmodule ReminderApp.Repo do
  use Ecto.Repo,
    otp_app: :reminder_app,
    adapter: Ecto.Adapters.Postgres
end
