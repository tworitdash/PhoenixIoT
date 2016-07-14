defmodule Tworit.Password do
  	alias Tworit.Repo
  import Ecto.Changeset, only: [put_change: 3]
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  @doc """
    Generates a password for the user changeset and stores it to the changeset as encrypted_password.
  """

  def generate_password_and_token(changeset) do
    to_be_encoded_string = Enum.join([changeset.params["email"], changeset.params["password"]])

    token = Base.encode64(to_be_encoded_string)
    changeset = put_change(changeset, :token, token)

    put_change(changeset, :encrypted_password, hashpwsalt(changeset.params["password"]))
  end

  @doc """
    Generates the password for the changeset and then stores it to the database.
  """
  def generate_password_and_store_user(changeset) do
    changeset
      |> generate_password_and_token
      |> Repo.insert
  end
end
