defmodule EctoJsonDemoTest do
  use ExUnit.Case

  test "greets the world" do
    json_wall = """
      {
        "end": [
            200.0,
            200.0
        ],
        "id": "W1",
        "start": [
            100.0,
            100.0
        ],
        "windows": [
            {
                "lower_edge": 1.0e3,
                "offset": 0.0,
                "upper_edge": 2.0e3,
                "width": 1.0e3
            },
            {
                "lower_edge": 1.0e3,
                "offset": 1.0e3,
                "upper_edge": 2.0e3,
                "width": 1.0e3
            }
        ]
    }
    """

    wall =
      Schema.Wall.changeset(%Schema.Wall{}, Jason.decode!(json_wall))
      |> Ecto.Changeset.apply_changes()

    _json_wall = Jason.encode!(wall)
  end
end
