module decoder 

using conv_code
using utils
using transitions
using code_structs
using cost_functions

export decode

function decode(p::Float64, code::ConvolutionalCode, in_sequence::Array{Array{Float64, 1}, 1})

	# O nível da raiz é 1
	current_leaves::Array{TreeNode} = [
		TreeNode(nothing, 0, 0, -1) for i in range(1; length=2^code.quant_mem)
	]
	current_leaves[1].level = 1

	next_leaves::Array{TreeNode} = [
		TreeNode(nothing, 0, 0, -1) for i in range(1; length=2^code.quant_mem)
	]

	# No índice level, calcular as folhas do nível level+1
	for level=1:length(in_sequence)
		# Sequência recebida
		curr_seq = in_sequence[level]

		# Calcular os filhos
		for curr_leaf_index=1:length(current_leaves)
			curr_leaf_node = current_leaves[curr_leaf_index]
			
			if curr_leaf_node.level < level
				continue
			end

			for transition=transition_list(code, curr_leaf_index)
				child = TreeNode(
					curr_leaf_node,
					level+1, 
					exact_cost(p, curr_seq, curr_leaf_node, transition),
					transition.in_bit
				)
				# Se visto pela primeira vez, ou mais barato que o já
				# colocado na árvore, inserir `child` na árvore
				if next_leaves[transition.next_state].level < level+1 ||
					next_leaves[transition.next_state].cost > child.cost

					next_leaves[transition.next_state] = child

				end
			end
		end
		@swap!(current_leaves, next_leaves)
	end

	# Selecionar a folha mais barata do último nível
	best_leaf = current_leaves[1]
	for leaf=current_leaves
		if leaf.level != length(in_sequence)+1
			continue
		end
		if leaf.cost < best_leaf.cost
			best_leaf = leaf
		end
	end

	# Subir na árvore até a raiz
	node = best_leaf
	decoded_bits = Array{Int64}(undef, length(in_sequence))
	for i=length(in_sequence):-1:1
		decoded_bits[i] = node.info_bit
		node = node.parent
	end

	return decoded_bits
end

end