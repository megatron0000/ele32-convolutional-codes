module code_structs

export TreeNode
export Transition

mutable struct TreeNode
	parent::Union{TreeNode, Nothing}
	level::Int64 # Nível da raiz deve ser 1
	cost::Float64 # Custo acumulado no algoritmo de Viterbi
	info_bit::Int64 # Bit de informação associado ao nó
	codeword::Array{Int64, 1} # Palavra código do caminho até o nó
	TreeNode(parent, level, cost, info_bit) = new(
		parent,
		level,
		cost,
		info_bit
	)
end

struct Transition
	in_bit::Int64
	output::Array{Int64}
	next_state::Int64
	Transition(in_bit, output, next_state) = new(
		in_bit, output, next_state
	)
end

end