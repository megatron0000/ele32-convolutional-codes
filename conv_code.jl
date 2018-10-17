struct ConvolutionalCode
	quant_mem::Int64
	outs::Array{Array{Int64, 1}, 1}
	ConvolutionalCode(quant_mem, outs) = new(quant_mem, outs)
end