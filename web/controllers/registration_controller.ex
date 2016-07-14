defmodule Tworit.RegistrationController do
  use Tworit.Web, :controller

  alias Tworit.Password

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    if changeset.valid? do
      new_user = Password.generate_password_and_store_user(changeset)
      conn
        |> put_flash(:info, "You are Sucessfully Registered :P ")
        |> redirect(to: session_path(conn, :new))
    else
      render conn, "new.html", changeset: changeset 
    end
  end
end
