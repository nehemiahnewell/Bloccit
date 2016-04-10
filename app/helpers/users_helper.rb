module UsersHelper
    def user_has_posts(current_user)
        (current_user.posts.count + current_user.comments.count) >= 1
    end
end
