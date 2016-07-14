defmodule Tworit.Router do
  use Tworit.Web, :router
  #use Phoenix.Router.Socket, mount: "/ws"

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tworit do
    pipe_through :browser # Use the default browser stack
    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create
    #get "/", PageController, :index
    get "/", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
    resources "/toys", ToyController
    get "/em", EnergyMeterController, :index
    #resources "/control", ControlController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Tworit do
  #   pipe_through :api
  # end
end
