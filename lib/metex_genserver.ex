require IEx;

defmodule MetexGenserver do
  def temperatures_of(cities) do
    total_cities = cities
                    |> Enum.count

    {:ok, coordinator_pid} = Metex.Coordinator.start_link([cities_count: total_cities])

    cities |> Enum.each(fn city ->
      {:ok, pid} = Metex.Worker.start_link
      Metex.Worker.start(pid, {coordinator_pid, city})
    end)
  end
end
