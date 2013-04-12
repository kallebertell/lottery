require 'spec_helper'

describe Event do
  before do
    @event = Event.create(name: "Wine lottery")
  end


  describe "when its name is not set" do
    before { @event.name = nil }
    it { @event.should_not be_valid }
  end

  describe "when it has participants" do 
    before do
      @event.participants.create(email: "somone1@foo.com")
      @event.participants.create(email: "somone2@foo.com")
    end

    it { @event.participants.should_not be_empty }

    describe "and has no winners" do 
      it { @event.winners.should be_empty }
    end

    describe "and we're selecting a winner" do 
      it "should result in 2 winners after two draws" do 
        @event.select_winner_and_save
        @event.select_winner_and_save
        @event.winners.size.should equal(2)
      end
    end

    describe "and has a winner" do
      before do 
        participation = @event.participations.first
        participation.won = true
        participation.save        
      end

      it { @event.winners.should_not be_empty }
    end
  end

end
