module transitions

using conv_code
using encoder
using utils


export transition_list

struct Transition
	in_bit::Int64
	output::Array{Int64}
	next_state::Int64
	Transition(in_bit, output, next_state) = new(
		in_bit, output, next_state
	)
end

#=
Esta função deve retornar algo do tipo Array{Transition},
em que o Transition.in_bit é um bit de entrada, o Transition.output 
é a saída gerada pelo tal bit de entrada e Transition.next_state é 
o próximo estado (notação binária)

O 'origin_state' correspondendo ao estado com:
	- todas as memórias nulas é 1
	- todas as memórias=1 é 2^(code.quant_mem)
=#
function transition_list(code::ConvolutionalCode, origin_state::Int64)
	if haskey(transitions_cache, code)
		return transitions_cache[code][origin_state]
	end

	transition_list = Array{Array{Transition, 1}, 1}(undef, 2^code.quant_mem)

	for i=0:2^(code.quant_mem) - 1
		transition_list[i+1] = []
		binary = dec2bin(i, code.quant_mem+1)
		binary[1] = 0
		push!(transition_list[i+1], Transition(0, current_out(code, binary), i >> 1 + 1))
		binary[1] = 1
		push!(transition_list[i+1], Transition(1, current_out(code, binary), 
			2^(code.quant_mem-1) + (i >> 1) + 1
		))
	end

	transitions_cache[code] = transition_list

	return transitions_cache[code][origin_state]
end

transitions_cache = Dict()

end