defmodule BsWeb.GameController do
  alias BsRepo.GameForm

  import Ecto.Query

  use BsWeb, :controller

  def index(conn, _params) do
    games = BsRepo.all(from(g in GameForm, order_by: [desc: g.id]))
    render(conn, "index.html", games: games)
  end

  def new(conn, _params) do
    changeset = GameForm.changeset(%GameForm{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"game_form" => params}) do
    params = Map.put_new(params, "game_mode", get_game_mode(params))

    {:ok, game_form} =
      %GameForm{}
      |> GameForm.changeset(params)
      |> BsRepo.insert()

    redirect(conn, to: game_path(conn, :edit, game_form))
  end

  def show(conn, %{"id" => id}) do
    game_form = BsRepo.get!(GameForm, id)
    render(conn, "show.html", game: game_form)
  end

  def edit(conn, %{"id" => id}) do
    game_form = BsRepo.get!(GameForm, id)
    changeset = GameForm.changeset(game_form)
    render(conn, "edit.html", game: game_form, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game_form" => params}) do
    game_form = BsRepo.get!(GameForm, id)

    params = Map.put_new(params, "game_mode", get_game_mode(params))

    game_form
    |> GameForm.changeset(params)
    |> BsRepo.update()

    redirect(conn, to: game_path(conn, :edit, game_form))
  end

  defp get_game_mode(params) do
    params
    |> Map.get("snakes")
    |> Map.to_list()
    |> Enum.filter(fn s -> is_valid_snake(s) end)
    |> Enum.count()
    |> case do
      1 -> "singleplayer"
      _ -> "multiplayer"
    end
  end

  def is_valid_snake({_, %{"delete" => d, "name" => n, "url" => u}}) do
    if d != true && n != "" && u != "" do
      true
    else
      false
    end
  end

  def delete(conn, %{"id" => id}) do
    case BsRepo.get(GameForm, id) do
      nil -> :ok
      x -> BsRepo.delete(x)
    end

    index(conn, {})
  end

  def create_params(params) do
    %GameForm{
      width: String.to_integer(params["width"]),
      height: String.to_integer(params["height"])
    }
  end

  def update_params(_params) do
    %GameForm{}
  end
end
