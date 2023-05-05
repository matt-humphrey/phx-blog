defmodule Blog.Posts.PostContent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_content" do
    field :full_text, :string
    belongs_to :post, Blog.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(post_content, attrs) do
    post_content
    |> cast(attrs, [:full_text])
    |> validate_required([:full_text])
  end
end
