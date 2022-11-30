# Launch MongoDB Compass from the command line

**To take advantage of all the capabilities described below, you will need Compass 1.35+.**

This repository contains a demo of how to launch MongoDB Compass from the command line and have it automatically
connect to a cluster by passing a given connection string.

# Why is this useful?

1. Maybe you've connected to a cluster using `mongosh` but now you want a more visual way to work with your data. In this case, you can just
   hit `Arrow Up`, replace the `mongosh` part of the command with the path to the Compass executable (I recommend creating a symlink to make this more convenient) and you are good to go.
2. You want to start Compass automatically and connect it to the right cluster right away, e.g. when the user logs in.

# What is this demo about?

In `launch-compass.sh`, we are assuming that the connection string, and the username/password for the database user are securely stored in Bitwarden.

The script fetches all the information from there, builds up the following Compass command:

```
/path/to/compass <URI> --username <username> --password <password> [--protectConnectionStrings]
```

which launches Compass and automnatically gets it connected.

The optional `--protectConnectionStrings` adds an extra layer of security and prevents the user from seeing or exporting the credentials.

If you want to try this out with Bitwarden, copy `secret.example.sh` to `secret.sh` and fill-in your Bitwarden Cliend ID, Client Secret and master password.

**Note:** this demo was built on macOS but it should be easy enough to run it on linux by setting the `COMPASS_PATH` variable in `launch-compass.sh` to the right path.