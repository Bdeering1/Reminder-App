defmodule ReminderApp.Notifications do
  alias ReminderApp.Tasks
  use Timex

  def try_notify do
    IO.puts "Checking task list..."
    date = DateTime.utc_now
    tasks = Tasks.list_tasks()
    tasks_notified = for task <- tasks do
      if Timex.compare(task.next_date, date) < 1 do
        with :ok <- (send_notification(task) |> handle_response(task)), do: task
      end
    end
    tasks_notified
  end

  def send_notification(task) do
    HTTPoison.start
    url = Application.fetch_env!(:reminder_app, :url)
    app_key = Application.fetch_env!(:reminder_app, :app_key)
    app_secret = Application.fetch_env!(:reminder_app, :app_secret)
    body = Poison.encode!(%{
        app_key: app_key,
        app_secret: app_secret,
        target_type: "app",
        content: task.name
      })
    headers = ["Content-Type": "application/json"]
    HTTPoison.post(url <> "push", body, headers)
  end

  def handle_response(response, task) do
    {status, res} = response
    if status === :ok and res.status_code == 200 do
      if Map.fetch(task, :interval) === {:ok, nil} do
        Tasks.delete_task(task)
      else
        date = Timex.shift(task.next_date, days: task.interval)
        Tasks.update_task(task, %{next_date: date})
      end
      %{"response" => %{"message" => message}} = Poison.decode!(res.body)
      IO.puts "\n\"#{task.name}\" - #{message}\n"
      :ok
    else
      :error
    end
  end

end
