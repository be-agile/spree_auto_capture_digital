# Spree Auto Capture Digital

This Spree extension enables automatic payment capture for orders containing only digital products, even when the payment method's `auto_capture` setting is disabled.

## Features

- Automatically captures payment for digital-only orders when configured
- Works with any payment method that includes the `AutoCaptureDigitalConcern`
- Maintains existing behavior for physical product orders
- Easy integration with existing payment methods

## Installation

Add this extension to your payment method's gemspec:

```ruby
s.add_dependency 'spree_auto_capture_digital', '~> 1.0'
```

## Usage

### For Payment Method Developers

To enable this feature in your payment method:

1. Include the concern in your payment method class:

```ruby
module Spree
  class PaymentMethod::YourGateway < Gateway
    include Spree::PaymentMethod::AutoCaptureDigitalConcern

    # ... rest of your payment method code
  end
end
```

2. Add the partial to your payment method's admin form:

```erb
<!-- app/views/spree/admin/payment_methods/custom_form_fields/_your_gateway_form_fields.html.erb -->
<div class="card mb-4">
  <div class="card-header">
    <h5 class="card-title">
      <%= Spree.t('your_gateway.settings') %>
    </h5>
  </div>

  <div class="card-body">
    <!-- Your existing settings -->

    <%= render 'spree/admin/payment_methods/auto_capture_digital_fields', f: f %>
  </div>
</div>
```

### For Store Administrators

1. Navigate to `/admin/payment_methods` in your store admin panel
2. Edit the payment method (e.g., GMO-PG)
3. Enable "Auto-capture for digital-only orders" checkbox
4. Save the payment method

## How It Works

When `auto_capture` is set to `false` and `auto_capture_for_digital_only_orders` is enabled:

- **Digital-only orders**: Payment is automatically captured (immediate settlement)
- **Orders with physical products**: Payment is only authorized (manual capture required)
- **Orders with mixed products**: Payment is only authorized (manual capture required)

### Processing Flow

```
Payment#process!
  ↓
  Check if auto_capture_for_digital_only_orders is enabled
  ↓
  YES: payment_method.respond_to?(:preferred_auto_capture_for_digital_only_orders) == true
       AND payment_method.auto_capture? == false
       AND payment_method.preferred_auto_capture_for_digital_only_orders == true
       AND order.digital? == true
  ↓
  Call purchase! (immediate settlement)
  ↓
  NO: Call super (existing behavior: follows auto_capture setting)
```

## Technical Details

### Concern: `Spree::PaymentMethod::AutoCaptureDigitalConcern`

Adds the `preferred_auto_capture_for_digital_only_orders` preference to the payment method.

### Decorator: `Spree::Payment::ProcessingDecorator`

Overrides the `process!` method to check if auto-capture should be applied for digital-only orders.

## Compatibility

- Spree Commerce 5.3.6
- Ruby 3.1.4+

## License

This extension is available as open source under the terms of the [AGPL-3.0-or-later](https://opensource.org/licenses/AGPL-3.0) and [BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause) licenses.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/be-agile/giga-repeat.
