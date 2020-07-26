module Payments
  module StateMachine
      extend ActiveSupport::Concern
      included do
        include AASM
        aasm column: :status, enum: true, whiny_transitions: false, create_scopes: false do
          state :initial, initial: true
          state :executed
          state :declined

          event :accept do
            transitions from: :initial, to: :executed, guard: :can_accept?
          end

          event :decline do
            transitions from: :initial, to: :declined, guard: :can_decline?
          end
        end

        def can_accept?
          return true if initial? && updater_id != Current.user.id
        end

        def can_decline?
          return true unless executed?
        end

        def aasm_event_failed(_event, _state)
          errors.add(:base, I18n.t('optimistic_locked')) unless errors.any?
        end
      end
    end
  end
