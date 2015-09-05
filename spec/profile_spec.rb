require File.dirname(__FILE__) + "/spec_helper"

RSpec.describe Profile do
  describe ".messagable" do
    it "returns profiles that can be messaged, and haven't been already" do
      messaged_profile = ProfileFactory.create_messagable
      MessageFactory.create(response: "the response", responded_at: DateTime.now, profile: messaged_profile)

      unmessaged_profile = ProfileFactory.create_messagable
      unmessagble_profile = ProfileFactory.create(interests: ['something-that-doesnt-match-anything'])

      expect(Profile.messagable(1).to_a).to eq([unmessaged_profile])
    end

    it "returns the number specified" do
      ProfileFactory.create_messagable
      ProfileFactory.create_messagable
      ProfileFactory.create_messagable

      expect(Profile.messagable(2).to_a.size).to eq(2)

    end
  end

  describe "#matches_any_topic?" do
    it "is true if the profile matches a topic" do
      expect(ProfileFactory.create(interests: ['biking']).matches_any_topic?).to be
    end

    it "is false if the profile matches no topics" do
      expect(ProfileFactory.create(interests: ['nothing']).matches_any_topic?).to_not be
    end
  end

  it "#name is parsed out of the profile" do
    p = ProfileFactory.from_test_fixture('profile.html')
    expect(p.username).to eq('misshubble2')
  end

  it "#bio is parsed out of the profile" do
    p = ProfileFactory.from_test_fixture('profile.html')
    expect(p.bio).to match(/\AI'm adventurous.*me laugh\.\Z/m)
  end

  it "#interests are parsed out of the profile" do
    interests = ProfileFactory.from_test_fixture('profile.html').interests

    #there are more, but this will prove the point
    expect(interests).to include('wine')
    expect(interests).to include('cheese')
  end
end
