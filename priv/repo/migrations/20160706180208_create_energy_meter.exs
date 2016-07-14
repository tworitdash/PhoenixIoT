defmodule Tworit.Repo.Migrations.CreateEnergyMeter do
  use Ecto.Migration

  def change do
    create table(:energymeters) do
      add :powerfactor, :integer
      add :load, :integer
      add :reading, :integer
      add :thd, :integer
      add :name, :string
      add :user_id, references(:users)
      timestamps
    end
    create index(:energymeters, [:user_id])
  end
end
