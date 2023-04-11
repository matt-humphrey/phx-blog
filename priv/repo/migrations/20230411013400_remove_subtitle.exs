defmodule Blog.Repo.Migrations.RemoveSubtitle do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :published_on, :date
      add :visible, :boolean, default: true

      remove :subtitle
    end
  end
end
