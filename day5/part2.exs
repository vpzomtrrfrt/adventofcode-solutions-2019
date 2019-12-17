content = IO.chardata_to_string(IO.read(:all))
split = String.split(content, ",")

initial_memory = Enum.map(split, fn x -> String.to_integer(String.trim(x)) end)

defmodule Intcode do
	def pow(_base, power) when power == 0, do: 1
	def pow(base, power) when power == 1, do: base	
	def pow(base, power), do: Intcode.pow(base, power - 1) * base

	def get_param(memory, position, op_field, index) do
		mode_id = Integer.mod(Integer.floor_div(op_field, Intcode.pow(10, index + 1)), 10)

		value_maybe = Enum.at(memory, position + index)

		case mode_id do
			0 -> Enum.at(memory, value_maybe)
			1 -> value_maybe
		end
	end

	def run(memory, position, input) do
		op_field = Enum.at(memory, position)

		op = Integer.mod(op_field, 100)

		case op do
			1 ->
				par_1 = Intcode.get_param(memory, position, op_field, 1)
				par_2 = Intcode.get_param(memory, position, op_field, 2)
				out_pos = Enum.at(memory, position + 3)

				result = par_1 + par_2

				Intcode.run(List.replace_at(memory, out_pos, result), position + 4, input)
			2 ->
				par_1 = Intcode.get_param(memory, position, op_field, 1)
				par_2 = Intcode.get_param(memory, position, op_field, 2)
				out_pos = Enum.at(memory, position + 3)

				result = par_1 * par_2

				Intcode.run(List.replace_at(memory, out_pos, result), position + 4, input)
			3 ->
				out_pos = Enum.at(memory, position + 1)

				{[result], new_input} = Enum.split(input, 1)

				Intcode.run(List.replace_at(memory, out_pos, result), position + 2, new_input)
			4 ->
				value = Intcode.get_param(memory, position, op_field, 1)

				[value | Intcode.run(memory, position + 2, input)]
			5 ->
				par_condition = Intcode.get_param(memory, position, op_field, 1)
				par_target = Intcode.get_param(memory, position, op_field, 2)

				Intcode.run(
					memory,
					if(par_condition != 0, do: par_target, else: position + 3),
					input
				)
			6 ->
				par_condition = Intcode.get_param(memory, position, op_field, 1)
				par_target = Intcode.get_param(memory, position, op_field, 2)

				Intcode.run(
					memory,
					if(par_condition == 0, do: par_target, else: position + 3),
					input
				)
			7 ->
				par_1 = Intcode.get_param(memory, position, op_field, 1)
				par_2 = Intcode.get_param(memory, position, op_field, 2)

				out_pos = Enum.at(memory, position + 3)

				result = if(par_1 < par_2, do: 1, else: 0)

				Intcode.run(List.replace_at(memory, out_pos, result), position + 4, input)
			8 ->
				par_1 = Intcode.get_param(memory, position, op_field, 1)
				par_2 = Intcode.get_param(memory, position, op_field, 2)

				out_pos = Enum.at(memory, position + 3)

				result = if(par_1 == par_2, do: 1, else: 0)

				Intcode.run(List.replace_at(memory, out_pos, result), position + 4, input)
			99 -> []
		end
	end
end

IO.puts(Enum.join(Intcode.run(initial_memory, 0, [5]), ""))
