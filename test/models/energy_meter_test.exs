defmodule Tworit.EnergyMeterTest do
  use Tworit.ModelCase

  alias Tworit.EnergyMeter

  @valid_attrs %{load: 42, name: "some content", powerfactor: 42, reading: 42, thd: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = EnergyMeter.changeset(%EnergyMeter{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = EnergyMeter.changeset(%EnergyMeter{}, @invalid_attrs)
    refute changeset.valid?
  end
end
