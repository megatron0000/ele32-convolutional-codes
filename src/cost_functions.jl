module cost_functions

using code_structs
using channels

export hamming_cost
export exact_cost
export euclidean_cost

function hamming_cost(p::Float64, curr_seq::Array{Float64,1}, node::TreeNode, transition::Transition)
	return node.cost + sum(abs.(transition.output - curr_seq))
end

function exact_cost(p::Float64, curr_seq::Array{Float64,1}, node::TreeNode, transition::Transition)

	difference = hamming_cost(p, curr_seq, node, transition)

	return difference*log(p) + (node.level*length(transition.output) - difference)*log(1-p)
end

function euclidean_cost(p::Float64, curr_seq::Array{Float64,1}, node::TreeNode, transition::Transition)
	return sqrt(node.cost^2 + sum((BPSK(transition.output) - curr_seq).^2))
end

end