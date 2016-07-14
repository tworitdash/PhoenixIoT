defmodule Tworit.EnergyMeterController do
  use Tworit.Web, :controller

  def index(conn, _params) do
    current_user = get_session(conn, :current_user)
    render conn, "index.html", current_user: current_user
  end
end 
