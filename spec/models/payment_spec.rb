require 'rails_helper'

RSpec.describe Payment, type: :model do
  it_behaves_like 'a Stampable model', :payment

  describe 'AASM' do
    let(:current_user) { create(:user) }
    before(:each) { Current.user = current_user }
    let(:payment) { create(:payment) }

    describe 'definition' do
      subject { payment }
      it { is_expected.to have_state(:initial) }
      it { is_expected.to transition_from(:initial).to(:declined).on_event(:decline) }
    end

    describe 'Status flow' do
      describe '#accept' do
        describe 'last updater is current user' do
          subject { payment.accept! }

          it 'return false' do
            is_expected.to be_falsy
          end
        end
        describe 'last updater is not current user' do
          it 'return true' do
            payment.updater = create(:user)
            expect(payment.accept!).to be_truthy
          end
        end
      end

      describe '#decline' do
        subject { payment.decline! }

        it 'returns true' do
          is_expected.to be_truthy
        end
      end
    end
  end
end
