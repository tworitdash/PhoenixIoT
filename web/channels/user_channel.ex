defmodule Tworit.UserChannel do
  use Tworit.Web, :channel

  def join("users:" <> user_token, payload, socket) do
    if authorized?(payload) do
      {:ok, "Joined To User:#{user_token}", socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("control", payload, socket) do
    broadcast socket, "control", payload
    {:noreply, socket}
  end

  def handle_in("sensor_output", payload, socket) do
    broadcast socket, "sensor_output", payload
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (users:lobby).
  def handle_in("shout", payload, socket) do
    #broadcast socket, "shout", payload
    broadcast socket, "change", payload
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  def broadcast_change(toy, current_user) do
    payload = %{
      "name" => toy.name,
      "body" => toy.body
    }
    Tworit.Endpoint.broadcast("users:#{current_user.token}", "change", payload)
  end

end
