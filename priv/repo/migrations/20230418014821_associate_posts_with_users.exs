defmodule Blog.Repo.Migrations.AssociatePostsWithUsers do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    create index(:posts, [:user_id])
  end
end
