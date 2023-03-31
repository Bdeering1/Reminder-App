defmodule ReminderAppWeb.TaskJSON do
  alias ReminderApp.Tasks.Task

  @doc """
  Renders a list of tasks.
  """
  def index(%{tasks: tasks}) do
    %{data: for(task <- tasks, do: data(task))}
  end

  @doc """
  Renders a single task.
  """
  def show(%{task: task}) do
    %{data: data(task)}
  end

  defp data(%Task{} = task) do
    %{
      id: task.id,
      name: task.name,
      description: task.description,
      next_date: task.next_date,
      interval: task.interval,
    }
  end
end
