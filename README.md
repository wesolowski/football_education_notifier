# Football Education Notifier

[![codecov](https://codecov.io/gh/wesolowski/football_education_notifier/branch/main/graph/badge.svg?token=9C026256MB)](https://codecov.io/gh/wesolowski/football_education_notifier)

### Business Requirement:


I need a script that navigates to the events calendar on the website https://www.dfbnet.org/ and looks for further education opportunities for coaches. 

I need this because in order to maintain my coaching football license, I must complete 20 hours of further education each year. 

I would like to be notified via email when new further education sessions are available so that I can register for them.


### Technical Requirement:

dart

### Installation:

1. Clone the repo
   ```sh
   git clone git@github.com:wesolowski/football_education_notifier.git
    ```
   
2. Install Dart
3. Install dependencies

   ```sh
   dart pub get
   ```
   
4. Create a .env file in the root directory and add the following environment variables:

   ```sh
   GMAIL_SMTP_EMAIL=YOUR_EMAIL
   GMAIL_SMTP_PASSWORD=YOUR_PASSWORD
   EMAIL_TO=YOUR_EMAIL_SEND
    ```
         

### Usage:

#### Run the script

   ```sh
   dart run
   ```

#### Run the script with debug mode

   ```sh
   dart run --observe --pause-isolates-on-start
   ```

#### Test

   ```sh
   dart test
   ```
