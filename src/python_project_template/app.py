import argparse

import requests


def main(limit: int = 10) -> None:
    response = requests.get(f"https://pokeapi.co/api/v2/pokemon?limit={limit!s}", timeout=5)
    print(f"Response status code: {response.status_code}")
    print(response.text)


def cli() -> None:
    parser = argparse.ArgumentParser(
        prog="Docker Python API Fetcher",
        description="Simple script to fetch data from an API",
    )
    parser.add_argument(
        "-l",
        "--limit",
        type=int,
        help="The number of items to fetch from the API",
    )
    args = parser.parse_args()
    main(args.limit)


if __name__ == "__main__":
    cli()
