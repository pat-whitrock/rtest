# RTest

A basic testing framework written in the style of RSpec.

## Purpose

Learn the basics of writing a Ruby DSL through one of the language's most well-known libraries.

The goal is to be able to run `ruby runner.rb` and have the following output:

```
PASSED: String #empty? when containing 0 characters returns true
FAILED: String #empty? when containing more than 1 character returns false
  - false does not equal true.
```

If you can get this working, you have written a small, but useful Ruby DSL that you can use to test your own code.

## Instructions

There is a full test suite on the `master` branch. Run `rspec` and follow TDD to reach the desired result.

If you get stuck, a finished solution is on the `solution` branch.

## Further Learning

If you finish writing RTest and want to keep going, try to implement additional [RSpec features](https://www.relishapp.com/rspec) or [package it as a gem](http://guides.rubygems.org/make-your-own-gem/).
