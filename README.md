# SecretSantaSelector

## Concept
Secret Santa Selector is a CLI that will match givers and receivers with the following rules...
1. No one can have themselves as a giver/receiver
1. No one can have their partner as a giver/receiver

## Usage
Once you run the application locally using `ruby run.rb` it will generate some URLs for you to transmit to your participants.

1. Download this repository
1. Edit the `run.rb` file to add your participants to the "couples" list
1. Run the program `ruby run.rb`
1. Transmit the URLs to the designated parties
1. When your participants access their URLs they will see their assignments

# Known Issues
- This application only handles couples, no single participants.
- Cannot be used with less than 4 people. 