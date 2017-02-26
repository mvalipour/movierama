class AuthorNotifier
  def movie_vote_cast(movie_id, voter_id, kind)
    # if moving to a queue model for sending emails
    # we simply need to change the implementation of this method
    # to put a message on a queue 
    # that a queue worker (independelty scaled) will pick up and process
    # .
    UserMailer.movie_vote_cast(Movie[movie_id], User[voter_id], kind).deliver
  end
end