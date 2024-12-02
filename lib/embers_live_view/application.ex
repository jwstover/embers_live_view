defmodule EmbersLiveView.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EmbersLiveViewWeb.Telemetry,
      EmbersLiveView.Repo,
      {DNSCluster, query: Application.get_env(:embers_live_view, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EmbersLiveView.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: EmbersLiveView.Finch},
      # Start a worker by calling: EmbersLiveView.Worker.start_link(arg)
      # {EmbersLiveView.Worker, arg},
      # Start to serve requests, typically the last entry
      EmbersLiveViewWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EmbersLiveView.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EmbersLiveViewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
