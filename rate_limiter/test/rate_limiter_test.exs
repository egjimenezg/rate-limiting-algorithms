defmodule RateLimiterTest do
  use ExUnit.Case, async: true
  doctest RateLimiter.Supervisor
  alias RateLimiter.Supervisor

  test "starts the dynamic supervisor for the rentals API" do
    Supervisor.start_link([])

    rate_limiters = [
      rentals_api: [requests_per_second: 2]
    ]

    Enum.each(rate_limiters, fn {id, opts} ->
      RateLimiter.DynamicSupervisor.spawn_rate_limiter(id, opts)
    end)

    times =
      1..10
      |> Task.async_stream(
        fn request_number ->
          IO.puts("Request #{request_number}")
          RateLimiter.LeakyBucket.wait_for_turn(:rentals_api)
          time = Time.truncate(Time.utc_now(), :second)
          IO.puts("[#{time}] Serviced request #{request_number}")
          time
        end,
        max_concurrency: 10,
        timeout: :infinity
      )
      |> Enum.to_list()
      |> Enum.map(fn {:ok, time} ->
        time.second
      end)
      |> Enum.uniq()

    assert length(times) == 5
  end
end
