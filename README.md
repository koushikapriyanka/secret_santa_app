# README

# Secret Santa App

A Ruby on Rails application that assigns Secret Santa gift-givers while avoiding:
- Assigning someone to themselves
- Assigning the same match from the previous year
- Duplicate gift recipients

## Features

- Reads employee data from a CSV file
- Avoids previous year matches (optional input)
- Outputs results to a new CSV
- Modular and testable Ruby code
- Includes error handling
- Comes with RSpec tests

## Environment Setup (Install Ruby & Rails)
Make sure you have Homebrew installed before proceeding.

## 1. Install rbenv and ruby-build

brew install rbenv ruby-build

Add rbenv to your shell startup script:

#### For zsh (~/.zshrc):

echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc

source ~/.zshrc

#### For bash (~/.bash_profile or ~/.bashrc):

echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile

source ~/.bash_profile
## 2. Install Ruby
rbenv install 3.3.0

rbenv global 3.3.0

Check Ruby version:

ruby -v
## 3. Install Rails
gem install rails -v 8.0.2

Check Rails version:

rails -v

## 4. Install Bundler
gem install bundler

## 5. Install Dependencies for the App
From the root of the cloned project:

bundle install

## Setup Instructions

### 1. Clone the Repo

git clone https://github.com/koushikapriyanka/secret_santa_app.git

cd secret_santa_app

### 2. Install Dependencies

bundle install

### 3. Add Input Data
Place these files in the /data directory:

employees.csv: current year participants

last_year.csv: previous year assignments

#### Example employees.csv:

Employee_Name,Employee_EmailID

Alice Smith,alice@example.com

Bob Jones,bob@example.com


#### Example last_year.csv:

Employee_Name,Employee_EmailID,Secret_Child_Name,Secret_Child_EmailID

Alice Smith,alice@example.com,Bob Jones,bob@example.com


### 4. Run the Assignment
bundle exec rake secret_santa:run

The output CSV will be written to: data/output_assignments.csv

### 5. Running Tests

bundle exec rspec

All logic is unit tested with RSpec and located in the /spec folder.


### 6. Technologies Used
- Ruby on Rails (minimal app mode)

- RSpec

- Rake

- CSV parsing


