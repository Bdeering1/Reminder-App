defmodule ReminderApp.Notifications do
  alias ReminderApp.Tasks
  use Timex

  def try_notify do
    IO.puts "Checking task list"
    date = DateTime.utc_now
    # date_edt = Timex.Timezone.convert(date, "America/Toronto")
    tasks = Tasks.list_tasks()
    for task <- tasks do
      if task_due?(task, date) do
        if send_notification(task) == :ok do
          IO.puts "Sending notification for \"#{task.name}\""
          Tasks.update_task(task, %{last_notified_at: date})
        end
      end
    end
  end

  def task_due?(task, date) do
    if task.weekday != Date.day_of_week(date), do: false
    case Map.fetch(task, :last_notified_at) do
      {:ok, nil} -> true
      {:ok, last_notified} ->
        div(Timex.Comparable.diff(date, last_notified, :days), 7) >= task.interval
      _ -> true
    end
  end

  def send_notification(_task) do
    :ok
  end

end
