defmodule UntilLater.Repo do
  use Ecto.Repo,
    otp_app: :until_later,
    adapter: Ecto.Adapters.Postgres
end
