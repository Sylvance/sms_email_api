# SMS EMAIL API

This is a simple app to send sms and emails.

The postman collection for this api is in the `public/docs` folder and it is called `sms_email_api.postman_collection.json`.

## Running the app

- `rails s` will run on port 3000

## Running the tests

- `bundle exec rspec spec`

## Running the jobs

- `bundle exec good_job start` in prod

- In development, GoodJob executes jobs immediately in a separate thread ("async" mode). 

## Endpoints

1. POST `communications/send_communication`

BODY
``` 
    {
        "from": "+254790000000",
        "to": "+254790000000",
        "subject": "test",
        "message": "Congratulations, your transaction is successful.",
        "medium": "sms"
    }
```

## Technologies used

- rails
- rspec
- goodjob - for async workers
- postgres
- postman - for documentation and testing

## Author

Sylvance Kerandi.
