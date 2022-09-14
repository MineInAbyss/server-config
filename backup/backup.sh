# Loads any secrets from a file as environment variables
source /home/container/secrets-backup

# Create restic backup
restic backup ${BACKUP_PATHS}

# Keeps all snapshots made within last day, daily for the last week, weekly for the last month, monthly for the last year, and yearly for the last 75 years
restic forget --keep-within 1d --keep-within-daily 7d --keep-within-weekly 1m --keep-within-monthly 1y --keep-within-yearly 75y
