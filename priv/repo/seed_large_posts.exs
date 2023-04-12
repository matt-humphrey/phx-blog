alias Blog.Posts
alias Blog.Posts.Post
alias Blog.Comments
alias Blog.Comments.Comment
alias Blog.Repo

date = ~D[2023-04-11]

# Create lots of posts!
Enum.each(1..100, fn _ ->
  Posts.create_post(%{title: Faker.Lorem.sentence(3), content: Faker.Lorem.Shakespeare.romeo_and_juliet(), published_on: date})
end)
