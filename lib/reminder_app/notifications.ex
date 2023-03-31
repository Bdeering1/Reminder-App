defmodule ReminderApp.Notifications do
  alias ReminderApp.Tasks
  use Timex

  def try_notify do
    IO.puts "Checking task list"
    date = DateTime.utc_now
    # date_edt = Timex.Timezone.convert(date, "America/Toronto")
    tasks = Tasks.list_tasks()
    for task <- tasks do
      if task.next_date <= date do
        if send_notification(task) == :ok do
          IO.puts "Sending notification for \"#{task.name}\""
          if Map.fetch(task, :interval) === {:ok, nil} do
            Tasks.delete_task(task)
          else
            date = Timex.shift(task.next_date, days: task.interval)
            Tasks.update_task(task, %{next_date: date})
          end
        end
      end
    end
  end

  def send_notification(_task) do
    HTTPoison.start
    :ok
  end

end
