defmodule Neoscan.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Neoscan.Addresses.Address
  alias Neoscan.Sql


  schema "addresses" do
    field :address, :string
    field :tx_ids, :map
    field :balance, :map
    field :claimed, {:array, :map}
    has_many :vouts, Neoscan.Addresses.Address

    timestamps()
  end

  @doc false
  def create_changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:address, :balance, :tx_ids, :claimed])
    |> validate_required([:address])
  end

  def update_changeset(%Address{} = address, attrs) do

    Sql.add_tx(attrs.tx_ids)

    address
    |> cast(attrs, [:address, :balance, :claimed])
    |> validate_required([:address])
  end
end
