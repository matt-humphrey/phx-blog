defmodule Blog.PostsTest do
  use Blog.DataCase

  alias Blog.Posts

  describe "posts" do
    alias Blog.Posts.Post

    import Blog.PostsFixtures

    @invalid_attrs %{content: nil, title: nil, published_on: nil, visible: true}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "list_posts/1 _ matching title" do
      post = post_fixture(title: "Hello World")
      assert Posts.list_posts({:title, "Hello World"}) == [post]
    end

    test "list_posts/1 _ non matching title" do
      post_fixture(title: "Hello World")
      assert Posts.list_posts({:title, "Goodbye"}) == []
    end

    test "list_posts/1 _ partially matching title" do
      post = post_fixture(title: "Hello World")
      assert Posts.list_posts({:title, "Hello"}) == [post]
      assert Posts.list_posts({:title, "Wor"}) == [post]
      assert Posts.list_posts({:title, "hElLo"}) == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{content: "some content", title: "some title", published_on: ~D[2000-01-01], visible: true}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.content == "some content"
      assert post.title == "some title"
      assert post.published_on == ~D[2000-01-01]
      assert post.visible == true
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{content: "some updated content", title: "some updated title", published_on: ~D[2023-04-11], visible: false}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.content == "some updated content"
      assert post.title == "some updated title"
      assert post.published_on == ~D[2023-04-11]
      assert post.visible == false
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
