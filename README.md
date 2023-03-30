# Coinbase

Collection of Coinbase API utilities.

## Installation (if available)

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `coinbase` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:coinbase, "~> 0.1.0"}
  ]
end
```


## Starting the price livestream to console [streamer.ex worker streams real-time prices from Coinbase API)

1. Navigate to the ~/lib/coinbase/application.ex file
2. Uncomment line 12 to expose the example worker
	2.1 the example worker subscribes to ETH-USD by default, but you can change this and/or add more workers subscribed to separate products
3. Finally, run the app to see a livestream of your product(s) prices

```elixir
iex -S mix
``` 

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/coinbase](https://hexdocs.pm/coinbase).

