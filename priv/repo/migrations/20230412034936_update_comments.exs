defmodule Blog.Repo.Migrations.UpdateComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      remove :body

      add :content, :text
      add :post_id, references(:posts, on_delete: :nothing)
    end

    create index(:comments, [:post_id])
  end
end
