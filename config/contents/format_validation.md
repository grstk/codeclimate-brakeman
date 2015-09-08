# Format Validation

Calls to `validates_format_of ..., :with => //` which do not use `\A` and `\z` as anchors will cause this warning. Using `^` and `$` is not sufficient, as they will only match up to a new line. This allows an attacker to put whatever malicious input they would like before or after a new line character.

See [the Ruby Security Guide][0] for details.

---
Source: http://brakemanscanner.org (CC BY 3.0)

[0]: http://guides.rubyonrails.org/security.html#regular-expressions
