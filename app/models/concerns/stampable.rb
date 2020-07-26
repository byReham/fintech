require 'active_support/concern'

module Stampable
  extend ActiveSupport::Concern

  included do
    with_options class_name: 'User' do
      belongs_to :creator
      belongs_to :updater
    end

    before_create :set_creator
    before_update :set_updater
  end

  private

  def set_creator
    self.creator ||= Current.user
    self.updater = creator
  end

  def set_updater
    return unless changes.any?

    self.updater = Current.user
  end
end
