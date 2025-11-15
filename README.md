# salad-nocturne
A Docker Container for Salad.io to automate startup of the Nocturne miner when an instance is reallocated

# Instructions
**IMPORTANT**  
Ideally you can follow step #1 below to generate the settings file locally before creating an instance. But if you cannot...  
Upon first start, a settings.json file will be created in the same directory as the miner binary. You **MUST** save this file, or it will be lost when the environment is reallocated. The timing of reallocation is not predictable. Sometimes an instance will go 24 hours before being reallocated

If you are comfortable with your mnemonic showing in the SaladCloud logs, you can echo them. This will output them there just in case you forget to save the settings.json file. But I recommend against this.

## Salad.io Setup
**1.)** To make it easier, you can start a Nocturne mining session on your local computer to generate a settings.json file. Do not start the miner, just go through the first time setup and exit. Save the settings.json file somewhere safe

**2.)** Enter this as your image source: **nemonaut/salad-nocturne:v3.0.0**  
https://hub.docker.com/repository/docker/nemonaut/salad-nocturne/tags/v3.0.0/sha256-c52e758a5aa5c897096e03259fcff60289aafeb58a2c4965ab8c9a3e4a89ef09  

**3.)** Use the information from the settings.json file in the environment variables for your Salad.io instance. Environment Variables -> Bulk Edit, filling in the info from your settings file  
```
WORKER_NAME=  
MINER_ID=  
MNEMONIC=  
HWID=  
GEN_END_INDEX=200  
WORKER_THREADS=64  
LOG_LEVEL=info  
DONATE_TO=  
LOG_DIRECTORY=.
```

The container will use these environment variables during setup each time your instance is reallocated.
