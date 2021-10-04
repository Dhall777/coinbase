# A module that connects to the Coinbase server using the Websockex library. Of single purpose.
# We've utilized 'use' tool in WebSockex to inject WebSockex functionalities into our module.
defmodule Coinbase.Client do
  use WebSockex

  @url "wss://ws-feed.pro.coinbase.com"

# A behaviour module which directly starts the supervisor with a list of
# children via start_link/2, or you may define a module-based supervisor that implements
# the required callbacks.
# 
# Our WebSockex.start_link/3 starts a websocket client in a seperate process and 
# returns {:ok, pid} tuple. The subscribe/2 function automatically subscribes 
  def start_link(products \\ []) do
    {:ok, pid} = WebSockex.start_link(@url, __MODULE__, :no_state)
    subscribe(pid, products)
    {:ok, pid}
  end

# Callback function invoked after a connection is established. This can be invoked
# after both the initial connection or a reconnect.
# Our handle_connect/2 callback is called when the client is connected.
  def handle_connect(_conn, state) do
    IO.puts "Connected!"
    {:ok, state}
  end

# The  subscription_frame/1  function returns a frame ready to be sent to the server. A frame is a
# tuple {type, data}, where in our case type is :text and data is a JSON string.
#
# The products argument is a list of Coinbase product ids, which are strings like "BTC-USD", 
# "ETH-USD", "LTC-USD", "BCH-USD". Need to figure out how to list multiple in one channel.
#
# We build the subscription message using a Map with type, product_ids and channels keys. 
# This map is then converted to a JSON string using the Poison.encode!/1 function. The 
# returned frame looks like this once we define "products" from iex:
# {:text, "{"type":"subscribe","product_ids":["BCH-USD"],"channels":["matches"]}"}
  def subscription_frame(products) do

    subscription_msg = %{

      type: "subscribe",
      product_ids: products,
      channels: ["matches"]

    } |> Poison.encode!()

      {:text, subscription_msg}
  end

# We then add a subscribe function to our module, which will run once a connection is established. We need to subscribe
# to market products using their product_ids before messages can be returned in JSON format.
#
# The subscribe/2 function builds the subscription frame {:text, json_msg} using the 
# subscription_frame(products) function we've just written and sends the frame to the server using the 
# WebSockex.send_frame(pid, frame) function, where the pid is the websocket client process 
# id.
  def subscribe(pid, products) do
    frame = subscription_frame(products)
    WebSockex.send_frame(pid, frame)
  end

# Once we're subscribed, the Coinbase websocket server begins sending us messages in JSON format. We need to implement
# the callback handle_frame/2 function which is called when the client receives data from the server.
#
# A simple handle_frame(frame, state) function produces the following behaviours:
# 1. pattern match the frame, extracting the JSON message once it arrives.
# 2. decode the JSON message using Poison.decode!/1 function, which converts the JSON to a Map.
# 3. print the map to stdout/standard output
#
# The callback function handle_frame/2 also returns a {:ok, new_state} tuple if we decide to update our state 
# (i.e., handle_cast/2 in GenServer).
  def handle_frame({:text, msg}, state) do
    handle_msg(Poison.decode!(msg), state)
  end

# We want to filter the trade messages, so implement the private function handle_msg/2 using pattern matching.
#
# We cannot pattern match the message directly in the public function handle_frame/2 since "msg" is a JSON
# and we need to first convert it into a Map to print trade data to stdout using Poison.decode!/1 function.
  defp handle_msg(%{"type" => "match"} = trade, state) do
    IO.inspect(trade)
    # Instead of printing output to terminal, stream this Map into Postgres, and plot from front-end using Ecto queries
    {:ok, state}
  end

  defp handle_msg(_trade, state) do
    {:ok, state}
  end

# Implement reconnection process using public callback handle_disconnect/2 function
#
# This function is only evoked in the event of a connection failure. If the app crashes or errors for some other
# reason, this entire process will terminate (thus skipping this callback).
#
# If the "handle_initial_conn_failure: true" option is provided during the process startup, then this callback
# will be invoked if the process fails to establish an initial connection. This is useful for cold startup monitoring.
#
# If a connection is established by reconnecting, the handle_connect/2 callback will be invoked from earlier.
# The possible returns for this callback function are:
# 1. {:ok, state} will continue the process termination.
# 2. {:reconnect, state} will attempt to reconnect instead of terminating.
# 3. {:reconnect, conn, state} will attempt to reconnect with the connection data in conn. conn is expected to be 
#    a WebSockex.Conn.t/0. 
  def handle_disconnect(_conn, state) do
    IO.puts("disconnected")
    {:ok, state}
  end
end
