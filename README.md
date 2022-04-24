# Store Class
With this program you will be able to find out the status of the stores incidents between two given dates.

## Installation
### Pre-requisites
Ruby: 2.7.5
### Installing
After cloning this repository, please install the necessary gems and dependences by running on the terminal:
```bash
bundle install
```

## Main program
The Store class contains many methods, one of them is incident_status which receives two dates as arguments (entered by the user) and returns a collection with the required information. It was located on the store.rb file.

The incidents.rb file contains an array of hashes with the reported incidents. Each incident has three mandatory keys: description, status and date_incident. And only when the status is "solved", there is one more key: date_solution.
Just as an example, the array has four incidents this time, so it can be changed by the user.
The program is executed by running:
```bash
ruby store.rb
```

## Tests
The tests were created with the gem "minitest". To execute them, run on the terminal:
```bash
ruby store_test.rb
```

## Author
[Claudia Berríos](https://www.linkedin.com/in/claudia-berrios-939265b9/)
