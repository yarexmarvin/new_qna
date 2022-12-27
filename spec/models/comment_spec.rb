require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:question).optional }
  it { should belong_to(:answer).optional }
  it { should belong_to :user }


  it { should validate_presence_of(:body) }
end