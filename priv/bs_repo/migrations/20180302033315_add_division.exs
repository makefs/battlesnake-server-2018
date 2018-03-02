defmodule BsRepo.Migrations.AddDivision do
  use Ecto.Migration

  def change do
    alter table(BsRepo.GameForm) do
      add(:division, :any)
    end

    alter table(:bs_repo_game) do
      add(:division, :any)
    end
  end
end
