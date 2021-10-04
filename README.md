# Coinbase

This is a Coinbase websocket API streaming application v0.0.1.
Market data is streamed to local files, then stored in CouchDB as JSON "documents", which can be downloaded as csv/pdf. Max DB time is 30 days, until I have more storage.
Market data has 4 primary categories: trade history, trade size, price (USD), and time.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `coinbase` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:coinbase, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/coinbase](https://hexdocs.pm/coinbase).

