# Cast or withdraw a vote on a movie
class VotingBooth
  include Wisper::Publisher

  def initialize(user, movie)
    @user  = user
    @movie = movie
  end

  def vote(kind)
    set = case kind
      when :like then @movie.likers
      when :hate then @movie.haters
      else raise
    end
    unvote # to guarantee consistency
    set.add(@user)
    _update_counts

    broadcast(:movie_vote_cast, @movie.id, @user.id, kind)

    self
  end
  
  def unvote
    @movie.likers.delete(@user)
    @movie.haters.delete(@user)
    _update_counts
    self
  end

  private

  def _update_counts
    @movie.update(
      liker_count: @movie.likers.size,
      hater_count: @movie.haters.size)
  end
end
