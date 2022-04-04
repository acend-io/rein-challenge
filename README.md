# REIN, Inc Technical Challenge

### What is the challenge?
This is a small Rails API applicaiton meant to be used for our code challenge assignment. Use this as the starting 
point for the code challenge.

### Stack
#### Server
* Ruby 3.1.1
* Rails 6.1.5

## Getting Started
```shell
# Fork the repo to your own github account
# Clone and setuup the repo
git clone https://github.com/acend-io/rein-challenge
cd rein-challenge

# Install and setup server dependencies
bundle install
bundle exec rails db:setup
```

---

### Test It
```shell
bundle exec rails qa # will run rubocop and rspec
```
### Run It
```shell
bundle exec rails s
```
We have also provided a Procfile if you wish 
```shell
foreman start
```

## What it is
This is an API only application, so there isn't a front-end available. We highly encourage you to test with RSpec 
but you are also welcome to use tools such as Postman to test as well. There is also OpenAPI documentation in the 
`swagger/swagger.yml` file.

## What you need to do

We would like to add the ability for a Pilot to check out a drone on a specific day, and for each check-out to be 
visible via an API call. 

Requirements: 

Accept a POST request to an endpoint you create that accepts a `pilot_id`, a `drone_id`, and a date (YYYY-MM-DD) which 
will associate a pilot 
to a drone on a specific date. Make sure you create the backing models to go with it.
- Validate the `pilot_id` exists
- Validate the `drone_id` exists
- Validate the referenced Drone is not already checked out on that date
- If any of the validations fail, return a 400, along with the error that caused the validation to fail.

Accept a GET request to an endpoint you create that returns an array of all the checkouts that have happened. 
- Include the Pilot information in the response body (not just the pilot_id)
- Include the Drone information in the response body (not just the drone_id)
- Example:

```json
[
  {
    "date": "2022-01-01",
    "pilot": {
      "id": 1,
      "name": "Pilot Name",
      "license_type": "part107"
    },
    "drone": {
      "id": 1,
      "name": "Drone 1",
      "faa_registration_number": "FA123123",
      "drone_type_id": 1
    }
  },
  {
    "date": "2022-01-04",
    "pilot": {
      "id": 1,
      "name": "Pilot Name",
      "license_type": "part107"
    },
    "drone": {
      "id": 5,
      "name": "Drone 5",
      "faa_registration_number": "FA87234592",
      "drone_type_id": 1
    }
  }
]
```
