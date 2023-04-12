defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :title, :string
    field :published_on, :date
    field :visible, :boolean, default: true
    has_many :comments, Blog.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published_on, :visible])
    |> validate_required([:title, :content])
    |> validate_length(:title, min: 3, max: 100)
  end
end
