defmodule EmbersLiveView.Repo do
  use Ecto.Repo,
    otp_app: :embers_live_view,
    adapter: Ecto.Adapters.Postgres
end
