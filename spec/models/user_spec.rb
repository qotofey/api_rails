# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  birth_date           :date
#  confirmed_at         :datetime
#  deleted_at           :datetime
#  email                :string(255)
#  first_name           :string(255)
#  gender               :integer
#  last_name            :string(255)
#  login                :string(255)
#  middle_name          :string(255)
#  password_digest      :string(255)
#  phone                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  confirmed_by_user_id :bigint
#  created_by_user_id   :bigint
#  deleted_by_user_id   :bigint
#  updated_by_user_id   :bigint
#
# Indexes
#
#  index_users_on_confirmed_by_user_id  (confirmed_by_user_id)
#  index_users_on_created_by_user_id    (created_by_user_id)
#  index_users_on_deleted_by_user_id    (deleted_by_user_id)
#  index_users_on_updated_by_user_id    (updated_by_user_id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'valid record' do
    expect(build(:user)).to be_valid
  end

  describe 'when some attribute is blank' do
    it 'phone valid' do
      user = build(:user, phone: '')
      expect(user).to be_valid
    end

    it 'login invalid' do
      user = build(:user, login: '')
      expect(user).not_to be_valid
    end

    it 'first_name invalid' do
      user = build(:user, first_name: '')
      expect(user).not_to be_valid
    end

    it 'middle_name valid' do
      user = build(:user, middle_name: '')
      expect(user).to be_valid
    end

    it 'last_name invalid' do
      user = build(:user, last_name: '')
      expect(user).not_to be_valid
    end

    it 'created_by_user_id valid' do
      user = build(:user, created_by_user_id: nil)
      expect(user).to be_valid
    end

    it 'updated_by_user_id valid' do
      user = build(:user, updated_by_user_id: nil)
      expect(user).to be_valid
    end

    it 'deleted_by_user_id valid' do
      user = build(:user, deleted_by_user_id: nil)
      expect(user).to be_valid
    end

    it 'deleted_by_user_id valid' do
      user = build(:user, confirmed_by_user_id: nil)
      expect(user).to be_valid
    end
  end
end
