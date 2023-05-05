defmodule Blog.Repo.Migrations.CreatePostContent do
  use Ecto.Migration

  def change do
    create table(:post_content) do
      add :full_text, :text
      add :post_id, references(:posts, on_delete: :delete_all), null: :false

      timestamps()
    end

    create index(:post_content, [:post_id])
  end
end
