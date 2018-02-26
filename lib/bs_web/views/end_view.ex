defmodule BsWeb.EndView do
  alias BsWeb.Api.DeathView

  use BsWeb, :view

  def render("show.json", %{
        winners: winners,
        deadSnakes: deadSnakes,
        gameId: gameId
      }) do
    %{
      game_id: gameId,
      winners: winners,
      dead_snakes: %{
        object: :list,
        data:
          Enum.map(deadSnakes, fn snake ->
            %{
              id: snake.id,
              length: Enum.count(snake.coords),
              death:
                render_one(
                  snake.death,
                  DeathView,
                  "show.json"
                )
            }
          end)
      }
    }
  end
end
