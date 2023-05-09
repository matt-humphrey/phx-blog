defmodule Blog.Seeds do
  alias Blog.Comments
  alias Blog.Comments.Comment
  alias Blog.Posts
  alias Blog.Posts.Post
  alias Blog.Repo
  alias Blog.Tags
  alias Blog.Tags.Tag

  @date ~D[2023-05-08]

  def seed do
    seed_post()
    seed_post_with_comments()
    seed_tags()
  end

  def seed_post do
    case Repo.get_by(Post, title: "Hello World") do
      %Post{} = post ->
        IO.inspect(post.title, label: "Post Already Created")

      nil ->
        Posts.create_post(%{title: "Hello World", post_content: %{full_text: "Welcome to my humble abode."}, published_on: @date})
    end
  end

  def seed_post_with_comments do
    {:ok, post} =
      case Repo.get_by(Post, title: "Post with Comments") do
        %Post{} = post ->
          IO.inspect(post.title, label: "Post Already Created")
          {:ok, post}

        nil ->
          Posts.create_post(%{title: "Post with Comments", post_content: %{full_text: "See comments below."},  published_on: @date})
      end

    case Repo.get_by(Comment, content: "Love your work!") do
      %Comment{} = comment ->
        IO.inspect(comment.content, label: "Comment Already Created")

      nil ->
        Comments.create_comment(%{content: "Love your work!", post_id: post.id})
    end

    case Repo.get_by(Comment, content: "Can I have your autograph?") do
      %Comment{} = comment ->
        IO.inspect(comment.content, label: "Comment Already Created")

      nil ->
        Comments.create_comment(%{content: "Can I have your autograph?", post_id: post.id})
    end
  end

  def seed_tags do
    ["elixir", "phoenix", "writing", "reflection", "travel"]
    |> Enum.map(fn tag_name ->
      case Repo.get_by(Tag, name: tag_name) do
        %Tag{} = tag ->
          IO.inspect(tag_name, label: "Tag already created.")

        nil ->
          Tags.create_tag(%{name: tag_name})
      end
    end)
  end
end
