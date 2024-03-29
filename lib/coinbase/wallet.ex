defmodule Coinbase.Wallet do
  import Aurum

  # export COINBASE_KEY and COINBASE_SECRET environment variables before running any of these functions

  # List CB account transactions
  def list_transactions do
    Aurum.Coinbase.get("/v2/accounts/primary/transactions")
  end

  # Buy $10 of Ethereum
  def buy_eth do
    eth_account = Aurum.Coinbase.get("/v2/accounts/eth")
    eth_resource = eth_account["data"]["resource_path"]
    buy_string = eth_resource <> "/buys"

    Aurum.Coinbase.post(buy_string, %{amount: 10, currency: "USD"})
  end


# Buy $20 of Cardano
  def buy_ada do
    ada_account = Aurum.Coinbase.get("/v2/accounts/ada")
    ada_resource = ada_account["data"]["resource_path"]
    buy_string = ada_resource <> "/buys"

    Aurum.Coinbase.post(buy_string, %{amount: 20, currency: "USD"})
  end

  # Buy $50 of Bitcoin
  def buy_btc do
    btc_account = Aurum.Coinbase.get("/v2/accounts/btc")
    btc_resource = btc_account["data"]["resource_path"]
    buy_string = btc_resource <> "/buys"

    Aurum.Coinbase.post(buy_string, %{amount: 50, currency: "USD"})
  end


end
