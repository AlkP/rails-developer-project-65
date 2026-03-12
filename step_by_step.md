rails new . -j esbuild --css=bootstrap
bin/rails g controller dashboards index
bin/rails g system_test dashboards
