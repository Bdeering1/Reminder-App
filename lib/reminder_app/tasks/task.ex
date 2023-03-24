defmodule ReminderApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :name, :string
    field :description, :string
    field :weekday, :integer
    field :interval, :integer
    field :last_notified_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :weekday, :interval, :last_notified_at])
    |> validate_required([:name, :weekday, :interval])
    |> validate_length(:description, max: 140)
    |> validate_number(:weekday, greater_than_or_equal_to: 1, less_than_or_equal_to: 7)
    |> validate_number(:interval, greater_than_or_equal_to: 1)
    |> unique_constraint(:name)
  end
end
