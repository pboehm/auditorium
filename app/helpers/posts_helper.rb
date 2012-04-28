module PostsHelper

  def format_link(post)
    link_to truncate(post.message, :length => 60), post_path(post)
  end

  def is_new_post(post)
    if post.is_newer_than?(get_last_visit(post))
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
    visit = Visit.find_by_user_id_and_post_id(current_user.id, post.id)

    date = nil
    if visit.nil?
      date = current_user.last_login
    else
      date = visit.updated_at
    end

    return date
  end

end
