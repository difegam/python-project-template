"""Application entrypoints for fetching Pokemon API data."""

from __future__ import annotations

import argparse
import logging

import requests

LOGGER = logging.getLogger(__name__)


def main(limit: int) -> None:
    """Fetch Pokemon data from the public API."""
    response = requests.get(
        f"https://pokeapi.co/api/v2/pokemon?limit={limit!s}",
        timeout=5,
    )
    LOGGER.info("Response status code: %s", response.status_code)
    LOGGER.info("Response body: %s", response.text)


def cli() -> None:
    """CLI entrypoint for the app script."""
    parser = argparse.ArgumentParser(
        prog="Docker Python API Fetcher",
        description="Simple script to fetch data from an API",
    )
    parser.add_argument(
        "-l",
        "--limit",
        type=int,
        help="The number of items to fetch from the API",
        default=10,
    )
    args = parser.parse_args()
    main(args.limit)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    cli()
