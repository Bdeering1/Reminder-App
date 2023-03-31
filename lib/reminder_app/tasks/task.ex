defmodule ReminderApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :name, :string
    field :description, :string
    field :next_date, :utc_datetime
    field :interval, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :next_date, :interval])
    |> validate_required([:name, :next_date])
    |> validate_length(:description, max: 140)
    |> validate_number(:interval, greater_than_or_equal_to: 1)
    |> unique_constraint(:name)
  end
end
