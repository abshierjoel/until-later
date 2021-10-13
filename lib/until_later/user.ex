defmodule UntilLater.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias UntilLater.User

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many :auth_tokens, UntilLater.AuthToken

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email, downcase: true)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
