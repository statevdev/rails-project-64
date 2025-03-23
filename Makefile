setup:
	bundle
	bin/rails assets:precompile
	bin/rails db:migrate
	DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bin/rails db:drop db:create db:migrate db:fixtures:load
start:
	bin/rails s
lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/
tests:
	bin/rails test
