
```bash
rails new . -j esbuild --css=bootstrap
bin/rails g controller dashboards
bin/rails g system_test dashboards
bin/rails g model user email:string password_digest:string
bin/rails g controller users new create show index

bin/rails g simple_form:install
bin/rails g system_test

```
