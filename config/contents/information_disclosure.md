# Information Disclosure

Also known as [information leakage][0] or [information exposure][1], this vulnerability refers to system or internal information (such as debugging output, stack traces, error messages, etc.) which is displayed to an end user.

For example, Rails provides detailed exception reports by default in the development environment, but it is turned off by default in production:

    # Full error reports are disabled
    config.consider_all_requests_local = false


Brakeman warns if this setting is `true` in production or there is a `show_detailed_exceptions?` method in a controller which does not return `false`.

---
Source: http://brakemanscanner.org (CC BY 3.0)

[0]: https://www.owasp.org/index.php/Information_Leakage
[1]: http://cwe.mitre.org/data/definitions/200.html
