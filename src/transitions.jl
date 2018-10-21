module transitions

export transitions

struct Transition
	in_bit::Int64
	output::Array{Int64}
	next_state::Int64
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
function transitions(code::ConvolutionalCode, origin_state::Int64)
end

end