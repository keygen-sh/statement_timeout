# statement_timeout

[![CI](https://github.com/keygen-sh/statement_timeout/actions/workflows/test.yml/badge.svg)](https://github.com/keygen-sh/statement_timeout/actions)
[![Gem Version](https://badge.fury.io/rb/statement_timeout.svg)](https://badge.fury.io/rb/statement_timeout)

Use `statement_timeout` to wrap an Active Record transaction or query in a
local statement timeout.

This gem was extracted from [Keygen](https://keygen.sh).

Sponsored by:

<a href="https://keygen.sh?ref=statement_timeout">
  <div>
    <img src="https://keygen.sh/images/logo-pill.png" width="200" alt="Keygen">
  </div>
</a>

_A fair source software licensing and distribution API._

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'statement_timeout'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install statement_timeout
```

## Usage

```ruby
User.statement_timeout 42.minutes do
  some_expensive_operation
end

User.posts.statement_timeout 10.seconds do
  some_cheap_operation
end

Tag.statement_timeout 6.hours do |conn|
  conn.execute 'VACUUM ANALYZE tags'
end
```

## Future

Right now, the gem only supports RSpec, but we're open to pull requests that
extend the functionality to other testing frameworks.

## Supported databases

We currently support PostgreSQL. We'd love contributions that add MySQL,
MariaDB, and SQLite support, but we probably won't add it ourselves.

## Supported Rubies

**`statement_timeout` supports Ruby 3.1 and above.** We encourage you to upgrade
if you're on an older version. Ruby 3 provides a lot of great features, like
better pattern matching and a new shorthand hash syntax.

## Is it any good?

Yes.

## Contributing

If you have an idea, or have discovered a bug, please open an issue or create a
pull request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
