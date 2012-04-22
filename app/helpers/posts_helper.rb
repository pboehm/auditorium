module PostsHelper

  def format_link(post)
    link_to truncate(post.message, :length => 60), post_path(post)
  end

  def is_new_post(post)

    if post.is_newer_than(get_last_visit(post))
      ' <span class="label label-success">New</span>'.html_safe
    end
  end

  def new_comments(post)

    size = post.comments_newer_than(get_last_visit(post)).size
    if size > 0
      ('<span class="badge badge-warning">%d</span>' % size).html_safe
    end
  end

  def get_last_visit(post)

    date = session[:last_login] || Time.new
    if session[:post_visits] && session[:post_visits][post.id]
      date = session[:post_visits][post.id]
    end
    date
  end

end
