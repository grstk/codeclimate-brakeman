# Remote Code Execution

Brakeman reports on several cases of remote code execution, in which a user is able to control and execute code in ways unintended by application authors.

The obvious form of this is the use of `eval` with user input.

However, Brakeman also reports on dangerous uses of `send`, `constantize`, and other methods which allow creation of arbitrary objects or calling of arbitrary methods.

Please see [this blog post][0] about the dangers of `constantize` and related methods.

---
Source: http://brakemanscanner.org (CC BY 3.0)

[0]: http://blog.conviso.com.br/2013/02/exploiting-unsafe-reflection-in.html
