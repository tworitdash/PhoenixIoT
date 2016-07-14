defmodule Tworit.EnergyMeter do
  use Tworit.Web, :model

  schema "energymeters" do
    belongs_to :user, Tworit.User
    field :powerfactor, :integer
    field :load, :integer
    field :reading, :integer
    field :thd, :integer
    field :name, :string

    timestamps
  end

  @required_fields ~w(powerfactor load reading thd name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
