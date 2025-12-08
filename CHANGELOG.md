# Changelog

## [Unreleased]

- Add support for transaction `:mode`, useful in cases where a PgBouncer is in
  sitting front of Postgres and in transaction mode. In this case, the default
  session-based `SET statement_timeout = ...` will not work consistently.

## v1.0.0

Initial release.
