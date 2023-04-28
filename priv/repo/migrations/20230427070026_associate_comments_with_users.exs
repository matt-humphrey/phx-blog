defmodule Blog.Repo.Migrations.AssociateCommentsWithUsers do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    create index(:comments, [:user_id])
  end
end
