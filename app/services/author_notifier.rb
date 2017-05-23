class AuthorNotifier
  def movie_vote_cast(movie_id, voter_id, kind)
    movie = Movie[movie_id]
    return unless movie.user.notifications_enabled

    voter = User[voter_id]

    # if moving to a queue model for sending emails
    # we simply need to change the implementation of this method
    # to put a message on a queue 
    # that a queue worker (independelty scaled) will pick up and process
    # .
    UserMailer.movie_vote_cast(movie, voter, kind).deliver
  end
end