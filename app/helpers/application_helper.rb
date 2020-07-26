module ApplicationHelper
  def render_flash_messages
    out         = []
    flash_types = { 'success' => 'alert-success', 'error' => 'alert-danger', 'notice' => 'alert-info' }
    flash.delete('timedout')
    flash.each do |key, flash_attributes|
      value = flash_attributes
      if flash_attributes.is_a? Hash
        value = flash_attributes['message']
        button = flash_attributes['button']
      end

      content = value
      if value.is_a? Array
        content = '<div class="list">'
        value.each do |message|
          content += "<div class=\"item\">#{message}</div>"
        end
        content += '</div>'
      end

      class_flash = flash_types[key] || 'alert-danger'
      out << "<div class=\"alert #{class_flash}\" role=\"alert\">"
      out << '<button type="button" class="close" aria-label="Close" data-dismiss="alert"><span aria-hidden="true">&times;</span></button>'
      out << "<div class='content'>#{content}</div>"
      out << "<a class=\"flash_button\" href=\"#{button['link']}\"> #{button['message']}</a>" if button.present?
      out << '</div>'
    end
    out.join('').html_safe
  end

  def payments_changes(payment, version)
    changes = version.changeset
    amount_changes = changes.delete('amount_in_cents') || []
    account_changes = changes.delete('account_id') || []

    content_tag('ul') do
      content = []
      if amount_changes.any?
        content << content_tag('li') do
          [content_tag('h6', 'Amount in cents: '),
          amount_changes.map do |amount|
            humanized_money_with_symbol(Money.new(amount, version.changeset['currency']&.last || payment.currency))
          end.join(' -> ')].join.html_safe
        end
      end
      if account_changes.any?
        content << content_tag('li') do
          [content_tag('h6', 'Account: '),
          account_changes.map { |id| User.find_by(id: id)&.email }.compact.join(' -> ')].join.html_safe
        end
      end
      version.changeset.each do |attr, set|
        content << content_tag('li') do
          [content_tag('h6', "#{attr}: "),
          set.compact.join(' -> ')].join.html_safe
        end
      end

      content.join.html_safe
    end
  end
end
