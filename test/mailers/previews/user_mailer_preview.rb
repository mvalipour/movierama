class UserMailerPreview < ActionMailer::Preview
  def movie_vote_cast
    UserMailer.movie_vote_cast(Movie.all.first, User.all.first, :like)
  end
end