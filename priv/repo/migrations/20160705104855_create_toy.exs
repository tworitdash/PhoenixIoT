defmodule Tworit.Repo.Migrations.CreateToy do
  use Ecto.Migration

  def change do
    create table(:toys) do
      add :body, :string
      add :name, :string

      timestamps
    end

  end
end
