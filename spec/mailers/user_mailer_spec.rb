RSpec.describe UserMailer, :type => :mailer do

    describe 'movie vote cast' do 
        let(:kind) { :like }
        let(:movie) { Movie.create(user: author, title: 'Empire strikes back') }
        let(:voter) { User.create(name: 'Andy') }
        let(:mail) { described_class.movie_vote_cast(movie, voter, kind).deliver }

        context 'when author doesnt have email' do 
            let(:author) { User.create(name: 'Bob') }
            
            it 'mail is not sent' do
                expect(mail).to be_nil
            end
        end

        context 'when author does have email' do 
            let(:author) { User.create(name: 'Bob', email: 'bob@movierama.dev') }

            context 'mail is sent' do
                it { expect(mail).to_not be_nil }

                it 'to the right person' do
                    expect(mail.to).to eq(['bob@movierama.dev']) 
                end

                it 'with the right subject' do
                    expect(mail.subject).to eq('Someone voted on your movie!')
                end
            end

            context 'when it is a like' do
                it 'body says movie is liked' do
                    expect(mail.body.encoded).to include('recently liked your movie')
                end
            end

            context 'when it is a hate' do
                let(:kind) { :hate }
                
                it 'body says movie is hated' do
                    expect(mail.body.encoded).to include('recently hated your movie')
                end
            end
        end
    end

end