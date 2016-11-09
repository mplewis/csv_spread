require Combinatorics

defmodule CsvSpread do
  def main([input_csv, output_csv | _]) do
    output_file = File.open! output_csv, [:write, :utf8]
    processed = spread(input_csv)
    processed |> Enum.each(&IO.write(output_file, &1))
    IO.puts "Wrote #{Enum.count processed} lines to #{output_csv}"
  end

  def main([input_csv | _]) do
    spread(input_csv)
    |> Enum.map(&IO.write/1)
  end

  def main([]) do
    IO.puts :stderr, "Usage: csv_spread MY_SHEET.CSV"
    System.halt 1
  end

  def spread(csv_path) do
    [header | raw] =
      csv_path
      |> File.stream!
      |> CSV.decode
      |> Enum.to_list

    clean = raw |> process_rows

    [header] ++ clean
      |> CSV.encode
      |> Enum.to_list
  end

  defp process_rows(rows) do
    rows |> Enum.flat_map(&mux_row/1)
  end

  defp mux_row(row) do
    row
    |> Enum.map(fn c -> String.split(c, "/") end)
    |> Combinatorics.product
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.to_list
  end
end
