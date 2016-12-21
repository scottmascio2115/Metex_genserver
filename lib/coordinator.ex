require IEx;

defmodule Metex.Coordinator do
  use GenServer

  def start_link(cities_length) do
    GenServer.start_link(__MODULE__, cities_length)
  end

  def init(cities_length) do
    {:ok, [container: []] ++ cities_length}
  end

  def handle_cast({:ok, location}, state) do
    cities = [location | state[:container]]
    if state[:cities_count] == Enum.count(cities) do
      GenServer.cast(self, :exit)
    end

    state = Keyword.put(state, :container, cities)
    {:noreply, state}
  end

  def handle_cast(:exit, state) do
    IO.puts(state[:container] |> Enum.sort |> Enum.join(", "))
    {:noreply, state}
  end
end

