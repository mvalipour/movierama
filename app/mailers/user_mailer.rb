class UserMailer < ActionMailer::Base

  def movie_vote_cast(movie, voter, kind)
    return unless movie.user.email

    @voter = voter
    @movie = movie
    @user = movie.user
    @kind = kind

    mail(to: movie.user.email, subject: 'Someone voted on your movie!')
  end
  
end
