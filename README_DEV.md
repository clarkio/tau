# Getting Started for Local Development using a Container

1. Make sure to do all the prerequisite stuff from the main README such as getting a Twitch Client ID and secret.
1. Install the [Remote Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code
1. Install [Docker](https://www.docker.com/)
1. Fork TAU to your GitHub account and then Clone your fork of TAU locally
1. In your terminal, change directory to the tau directory
1. Open the folder with VS Code
1. You will be prompted by VS Code to re-open the project using Containers. Choose yes and give it some time to set everything up
1. Copy the `.env_sample` file and paste it in the root directory.
1. Rename the copy to `.env`
1. Replace the values for `TWITCH_APP_ID` and `TWITCH_CLIENT_SECRET` with your values for them. Also it's best to modify the other environment variables to random values of your choice so it's not the same as what's stored in the repo (and available for anyone to see)
1. In your terminal go to this project root directory and run the following `./scripts/dev_setup.sh`
1. Once the script finishes run `./manage.py worker` in your terminal
1. Then open another instance of your terminal (or a tab) and run `./manage.py runserver`
1. Open your browser to [http://localhost:8000](http://localhost:8000) and follow the onscreen instructions/prompts
    1. Create a TAU login (to restrict access to it from others)
    1. Authorize TAU to access your Twitch account
1. You're all set to develop in TAU locally!
