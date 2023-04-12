alias Blog.Posts
alias Blog.Posts.Post
alias Blog.Comments
alias Blog.Comments.Comment
alias Blog.Repo

date = ~D[2023-04-11]

# Create a post with lots of comments!
{:ok, post} = Posts.create_post(%{title: "100 Comments!", content: "It's so many!", published_on: date})

Enum.each(1..100, fn _ ->
  %Comment{}
  |> Comment.changeset(%{content: Faker.Lorem.sentence(5)})
  |> Ecto.Changeset.put_assoc(:post, post)
  |> Repo.insert!()
end)
