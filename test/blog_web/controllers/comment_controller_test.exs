defmodule BlogWeb.CommentControllerTest do
  use BlogWeb.ConnCase

  import Blog.CommentsFixtures
  import Blog.AccountsFixtures

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  setup :register_and_log_in_user

  describe "index" do
    test "lists all comments", %{conn: conn} do
      conn = get(conn, Routes.comment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Comments"
    end
  end

  describe "new comment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.comment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Comment"
    end
  end

  describe "create comment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.comment_path(conn, :create), comment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.comment_path(conn, :show, id)

      conn = get(conn, Routes.comment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Comment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.comment_path(conn, :create), comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Comment"
    end
  end

  describe "edit comment" do

    test "renders form for editing chosen comment", %{conn: conn} do
      user = user_fixture()
      comment = comment_fixture(user_id: user.id)
      conn = log_in_user(conn, user)

      conn = get(conn, Routes.comment_path(conn, :edit, comment))
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "update comment" do

    test "redirects when data is valid", %{conn: conn} do
      user = user_fixture()
      comment = comment_fixture(user_id: user.id)
      conn = log_in_user(conn, user)

      conn = put(conn, Routes.comment_path(conn, :update, comment), comment: @update_attrs)
      assert redirected_to(conn) == Routes.comment_path(conn, :show, comment)

      conn = get(conn, Routes.comment_path(conn, :show, comment))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      comment = comment_fixture(user_id: user.id)
      conn = log_in_user(conn, user)

      conn = put(conn, Routes.comment_path(conn, :update, comment), comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "delete comment" do

    test "deletes chosen comment", %{conn: conn} do
      user = user_fixture()
      comment = comment_fixture(user_id: user.id)
      conn = log_in_user(conn, user)

      conn = delete(conn, Routes.comment_path(conn, :delete, comment))
      assert redirected_to(conn) == Routes.comment_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.comment_path(conn, :show, comment))
      end
    end
  end
end
