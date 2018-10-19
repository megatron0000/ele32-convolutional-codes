
struct Transition
	in_bit::Int64
	output::Array{Int64}
	next_state::Int64
end

#=
Esta função deve retornar algo do tipo Array{Transition},
em que o Transition.in_bit é um bit de entrada, o Tranition.output 
é a saída gerada pelo tal bit de entrada e Transition.next_state é 
o próximo estado (notação binária)
=#
function transitions(code::ConvolutionalCode, origin_state::Int64)
end

struct TreeNode
	parent::TreeNode
	child::TreeNode
	level::Int64 # Nível da raiz deve ser 1
	cost::Int64 # Custo acumulado no algoritmo de Viterbi
	info_bit::Int64 # Bit de informação associado ao nó
	TreeNode(parent, child, level, cost, info_bit) = new(
		parent,
		child,
		level,
		cost,
		info_bit
	)
end

macro swap!(a::Symbol,b::Symbol)
	blk = quote
		if typeof($(esc(a))) != typeof($(esc(b)))
			throw(ArgumentError("Arrays of different type"))
		else
			c = $(esc(a))
			$(esc(a)) = $(esc(b))
			$(esc(b)) = c
		end
	end
	return blk
end
