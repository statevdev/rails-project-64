setup:
	bundle
start:
	bin/rails s
lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/
tests:
	bin/rails test
