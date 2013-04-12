require 'spec_helper'

describe Participation do

	let(:user) { User.create(email: "some@user.com") }
	let(:event) { Event.create(name: "Some Event") }
	let(:participation) { user.participations.build(event_id: event.id) }
	
	subject { participation }
	it { should be_valid }
end
