FROM saladtechnologies/misc:ubuntu24-dev

# Install jq + wget, download v2.2.0, extract in current dir
RUN apt-get update && \
    apt-get install -y jq wget && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://cdn.nocturne.offchain.club/releases/v2.2.0/nocturne-miner-linux-x64-v3.tar.gz -O miner.tar.gz && \
    tar -xzf miner.tar.gz && \
    chmod +x nocturne-miner && \
    rm miner.tar.gz

# Entrypoint: stay in current dir, use relative paths
RUN cat > /entrypoint.sh <<'EOF'
#!/bin/bash
set -euo pipefail

REQUIRED_VARS="WORKER_NAME GEN_END_INDEX MINER_ID MNEMONIC HWID WORKER_THREADS LOG_LEVEL LOG_DIRECTORY"
missing=()
for var in $REQUIRED_VARS; do
    if [ -z "${!var:-}" ]; then
        missing+=("$var")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    echo "Missing env vars: ${missing[*]} → skipping settings.json"
    exec ./nocturne-miner --optimal --random-ua --no-menu --auto
else
    echo "All env vars present → generating settings.json"
    jq -n \
      --arg wn "$WORKER_NAME" \
      --argjson gei "$GEN_END_INDEX" \
      --arg mi "$MINER_ID" \
      --arg mn "$MNEMONIC" \
      --arg hw "$HWID" \
      --argjson wt "$WORKER_THREADS" \
      --arg ll "$LOG_LEVEL" \
      --arg ld "$LOG_DIRECTORY" \
      '{
        worker_name: $wn,
        gen_end_index: $gei,
        miner_id: $mi,
        mnemonic: $mn,
        hwid: $hw,
        worker_threads: $wt,
        log_level: $ll,
        donate_to: "",
        log_directory: $ld
      }' > settings.json
    echo "settings.json generated"
fi

exec ./nocturne-miner --optimal --random-ua --no-menu --auto
EOF

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
