# Command Injection

Injection is \#1 on the 2010 [OWASP Top Ten][0] web security risks. Command injection occurs when shell commands unsafely include user-manipulatable values.

There are many ways to run commands in Ruby:

    `ls #{params[:file]}`

    system("ls #{params[:dir]}")

    exec("md5sum #{params[:input]}")


Brakeman will warn on any method like these that uses user input or unsafely interpolates variables.

See [the Ruby Security Guide][1] for details.

---
Source: http://brakemanscanner.org (CC BY 3.0)

[0]: https://www.owasp.org/index.php/Top_10_2010-A1
[1]: http://guides.rubyonrails.org/security.html#command-line-injection
