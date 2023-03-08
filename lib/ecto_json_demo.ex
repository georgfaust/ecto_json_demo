defmodule EctoJsonDemo do
  defmodule User do
    use Ecto.Schema

    import Ecto.Changeset

    alias EctoJsonDemo.Profile

    embedded_schema do
      field :username, :string
      field :email, :string
      embeds_one :profile, Profile
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, [:username, :email])
      |> cast_embed(:profile, with: &Profile.changeset/2, required: true)
      |> validate_required([:username, :email])
    end
  end

  defmodule Profile do
    use Ecto.Schema

    import Ecto.Changeset

    embedded_schema do
      field :timezone, :string
    end

    def changeset(profile, attrs) do
      profile
      |> cast(attrs, [:timezone])
      |> validate_required([:timezone])
    end
  end
end
