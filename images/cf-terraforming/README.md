# Cloudflare cf-terraforming to backup the Cloudflare configuration

[Cloudflare cf-terraforming](https://github.com/cloudflare/cf-terraforming) image:

* [Alpine Linux](https://github.com/iBossOrg/k8s-alpine) as a base system.
* [Cloudflare cf-terraforming](https://github.com/cloudflare/cf-terraforming) to backup the Cloudflare configuration.
* [cf-backup script](rootfs/usr/bin/cf-backup) for Kubernetes Cron Job.

## Usage

You can run `cf-terraforming` command directly using:

```bash
docker run --rm iboss/cf-terraforming all --account <CF_ACCOUNT> --email <CF_EMAIL> --token <CF_TOKEN> > main.tf
```

or you can use `cf-backup` command with this sample Kubernetes CronJob spec:

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: cf-backup
spec:
  schedule: "33 4 * * *" # Run daily at 04:33 UTC
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: cf-backup
            image: iboss/cf-terraforming
            workingDir: /home
            command: ["/usr/bin/cf-backup"]
            env:
              BACKUP_FILE: main.tf
              COMMAND: all
              CF_ACCOUNT: <CF_ACCOUNT>
              CF_EMAIL: <CF_EMAIL>
              CF_TOKEN: <CF_TOKEN>
            volumeMounts:
            - name: cf-backup
              mountPath: /home
          restartPolicy: OnFailure
          volumes:
          - name: cf-backup
            persistentVolumeClaim:
              claimName: cf-backup-pv-claim
```

### Environment variables

`cf-terraforming` command does not use any environment variables. See [cf-terraforming command help](https://github.com/cloudflare/cf-terraforming#usage)

`cf-backup` command accepts the following environment variables:

| Variable | Default value | Description |
| -------- | ------------- | ----------- |
| BACKUP_FILE | `main.tf` or `terraform.tfstate` | Where the `cf-terraforming` output will be saved. Default value depends on `EXPORT_TFSTATE` variable. |
| COMMAND | `all` | [cf-terraforming command](https://github.com/cloudflare/cf-terraforming#usage) |
| CF_ACCOUNT | - | Cloudflare account id. |
| CF_EMAIL | - | Cloudflare accont email. |
| CF_KEY | - | Cloudflare API global key. |
| CF_TOKEN | - | Cloudflare API global token. |
| CF_ZONE | - | Limit the export to a single zone (name or ID). |
| EXPORT_TFSTATE | - | If defined, export the Terrform state instead of the configuration. |
| LOG_LEVEL | `info` | `cf-terraforming` log level. |

## Contributing

Use the command `make`:

```bash
make all                      # Build an image, run tests, and then clean
make image                    # Build an image and run tests
make pull                     # Pull all images from the Docker Registry
make lint                     # Lint Dockerfile and shell scripts
make build                    # Build an image
make rebuild                  # Rebuild an image
make vars                     # Show the make variables
make up                       # Delete all containers and then run them fresh
make create                   # Create the containers
make start                    # Start the containers
make wait                     # Wait for the containers to start
make ps                       # List running containers
make logs                     # Show the container logs
make tail                     # Follow the container logs
make sh                       # Run the shell in the container
make test                     # Run the tests
make tsh                      # Run the shell in the test container
make restart                  # Restart the containers
make stop                     # Stop the containers
make down                     # Delete the containers
make publish                  # Publish the image into the Docker Registry
make clean                    # Delete the containers and working files
```
