# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Blog.Posts
alias Blog.Posts.Post
alias Blog.Comments
alias Blog.Comments.Comment
alias Blog.Repo

date = ~D[2023-04-11]

# Create blog post without comments
Posts.create_post(%{title: "New Post!", content: "G'day!", published_on: date})

# Create blog post with a comment
{:ok, post} = Posts.create_post(%{title: "Follow Up Post", content: "How's it garn?", published_on: date})

%Comment{}
|> Comment.changeset(%{content: "Well thanks!"})
|> Ecto.Changeset.put_assoc(:post, post)
|> Repo.insert!()

%Comment{}
|> Comment.changeset(%{content: "Yeah not bad."})
|> Ecto.Changeset.put_assoc(:post, post)
|> Repo.insert!()

# Create post and comment with lots of text
{:ok, long_post} = Posts.create_post(%{title: Faker.Lorem.sentence(10), content: Faker.Lorem.Shakespeare.romeo_and_juliet(), published_on: date})

%Comment{}
|> Comment.changeset(%{content: Faker.Lorem.sentence(50)})
|> Ecto.Changeset.put_assoc(:post, long_post)
|> Repo.insert!()
