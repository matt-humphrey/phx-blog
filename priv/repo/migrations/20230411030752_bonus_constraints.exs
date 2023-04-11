defmodule Blog.Repo.Migrations.BonusConstraints do
  use Ecto.Migration
  import Ecto.Query

  def change do
    alter table(:posts) do
      modify :title, :string, unique: true, size: 100
    end

    from("posts", update: [set: [visible: true]])
    |> Blog.Repo.update_all([])
  end
end
