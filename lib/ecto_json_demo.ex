defmodule Type.Point do
  use Ecto.Type

  def type, do: :array

  def cast([x, y]), do: {:ok, {x, y}}
  def cast(_), do: :error
  def dump({x, y}), do: {:ok, [x, y]}
  def load(a), do: cast(a)
end

defmodule TupleEncoder do
  alias Jason.Encoder

  defimpl Encoder, for: Tuple do
    def encode(data, options) when is_tuple(data) do
      data
      |> Tuple.to_list()
      |> Encoder.List.encode(options)
    end
  end
end

defmodule Schema.Window do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:lower_edge, :float, default: 1000.0)
    field(:upper_edge, :float, default: 2000.0)
    field(:offset, :float)
    field(:width, :float, default: 1000.0)
  end

  def changeset(window, attrs) do
    window
    |> cast(attrs, [:lower_edge, :upper_edge, :offset, :width])
    |> validate_required([:lower_edge, :upper_edge, :offset, :width])
  end
end

defmodule Schema.Wall do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:id, :string)
    field(:start, Type.Point)
    field(:end, Type.Point)
    embeds_many(:windows, Schema.Window)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :start, :end])
    |> cast_embed(:windows, with: &Schema.Window.changeset/2, required: true)
    |> validate_required([:id, :start, :end])
  end
end
