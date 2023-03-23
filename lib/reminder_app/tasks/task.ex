defmodule ReminderApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :name, :string
    field :description, :string
    field :interval, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :interval])
    |> validate_required([:name, :interval])
    |> validate_length(:description, max: 140)
    |> unique_constraint(:name)
  end
end
