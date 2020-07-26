shared_examples_for 'a Stampable model' do |factory|
  context 'callbacks' do
    let(:creator) { create(:user) }
    let(:updater) { create(:user) }
    before(:each) do
      Current.user = creator
      @item = create(factory)
    end
    it 'before_create #set_creator' do
      expect(@item.creator).to eq(creator)
      expect(@item.updater).to eq(creator)
    end

    it 'before_update #set_updater' do
      Current.user = updater
      @item.update(purpose: 'Purpose')
      expect(@item.updater).to eq(updater)
    end
  end
end
