# Backup Cloudflare configuration with cf-terraforming

[![GitHub Actions Status](../../workflows/Build%20and%20Publish%20to%20Docker%20Hub/badge.svg)](../../actions)

Backup [Cloudflare cf-terraforming](https://github.com/cloudflare/cf-terraforming) with:

* [cf-terraforming image](images/cf-terraforming)

## Usage

For full documentation see [cf-terraforming image](images/cf-terraforming).

## Reporting Issues

Issues can be reported by using [GitHub Issues](/../../issues). Full details on how to report issues can be found in the [Contribution Guidelines](CONTRIBUTING.md).

## Contributing

Clone the GitHub repository into your working directory:

```bash
git clone https://github.com/ibossorg/k8s-cf-backup
```

Use the command `make` in the project directory:

```bash
make all                      # Build Docker images
make images                   # Build Docker images and run tests
make clean                    # Delete all running containers and work files
```

Please read the [Contribution Guidelines](CONTRIBUTING.md), and ensure you are signing all your commits with [DCO sign-off](CONTRIBUTING.md#developer-certification-of-origin-dco).

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](/../../tags).

## Authors

* [Petr Řehoř](https://github.com/prehor) - Initial work.

See also the list of [contributors](../../contributors) who participated in this project.

## License

This project is licensed under the Apache License, Version 2.0 - see the [LICENSE](LICENSE) file for details.
