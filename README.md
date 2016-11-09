# CSV Spread

Mux rows in a CSV containing slashes into multiple rows.

# Example

See test/input.csv -> test/expected.csv.

# Usage

```sh
# Build
mix escript.build

# Run
./csv_spread  input.csv  # prints to stdout
./csv_spread  input.csv  output.csv  # prints number of lines written
```
