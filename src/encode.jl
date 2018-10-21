module encode

using conv_code

export current_out
export encode

function shift_mems!(new_bit::Int64, extended_mems::Array{Int64})
	for k=length(extended_mems):-1:2
		extended_mems[k] = extended_mems[k-1]
	end
	extended_mems[1] = new_bit
end

function current_out(code::ConvolutionalCode, extended_mems::Array{Int64})
	return map(
		indices -> reduce(
			(previous, index) -> previous + extended_mems[index] ,
			indices;
			init=0
		), 
		code.outs
	)
end

function encode(code::ConvolutionalCode, info_bits::Array{Int64})
	out_sequence = Array{Array{Int64, 1}, 1}(undef, length(info_bits))
	mems = Array{Int64}(undef, code.quant_mem + 1)
	fill!(mems, 0)

	for index=1:length(info_bits)
		shift_mems!(info_bits[index], mems)
		out_sequence[index] = current_out(code, mems)
	end

	return out_sequence
end

end