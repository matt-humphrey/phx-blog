defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :title, :string
    field :published_on, :date
    field :visible, :boolean, default: true
    field :user_id, :id
    has_one :post_content, Blog.Posts.PostContent
    has_many :comments, Blog.Comments.Comment
    many_to_many :tags, Blog.Tags.Tag, join_through: "post_tags", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(post, attrs, tags \\ []) do
    post
    |> cast(attrs, [:title, :content, :published_on, :visible, :user_id])
    |> validate_required([:title])
    |> validate_length(:title, min: 3, max: 100)
    |> put_assoc(:tags, tags)
    |> cast_assoc(:post_content)
  end
end
