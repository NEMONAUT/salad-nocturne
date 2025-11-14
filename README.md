# salad-nocturne
A Docker Container for Salad.io to automate startup of the Nocturne miner when an instance is reallocated

# Instructions
**IMPORTANT**
Upon first start, a settings.json file will be created in the same directory as the miner binary. You **MUST** save this file, or it will be lost when the environment is reallocated. The timing of reallocation is not predictable. Sometimes an instance will go 24 hours before being reallocated.

If you are comfortable with your mnemonic showing in the SaladCloud logs, you can echo them. This will output them there just in case you forget to save the settings.json file. But I recommend against this.

## Salad.io Setup
Enter this as your image source: nemonaut/salad-nocturne:v3.0.0  
https://hub.docker.com/repository/docker/nemonaut/salad-nocturne/tags/v3.0.0/sha256-c52e758a5aa5c897096e03259fcff60289aafeb58a2c4965ab8c9a3e4a89ef09  

After you start the container and your Salad.io instance is running, you will need to edit the container to add environment variables. The container will use these during setup each time your instance is reallocated.

Edit -> Environment Variables -> Bulk Edit. You can paste these and fill in:  
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
After the above environment variables are added, save the environment. Now the container will use these during setup after each instance reallocation and auto-start the miner.
