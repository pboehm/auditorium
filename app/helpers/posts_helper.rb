module PostsHelper

  def shorten_text(post, size=80)
      if post.size > size
        return post[0..size-3] + "..."
      else
        return post
      end
  end

end
