module channels

using Distributions

export BSC
export AWGN
export BPSK

function BSC(p::Float64, coded_bits::Array{Array{Int64, 1}, 1})

	line = 1
	prob = rand(length(coded_bits)*length(coded_bits[line]))
	indice = 1

	for line=1:length(coded_bits)
		for column=1:length(coded_bits[line])
			if prob[indice] < p
				coded_bits[line][column] = abs(coded_bits[line][column] - 1)
			end
			indice += 1
		end
	end

	return coded_bits
end

function AWGN(N0::Float64, coded_bits::Array{Array{Float64, 1}, 1})
	distribution = sampler(Normal(0, sqrt(N0/2)))

	for line=1:length(coded_bits)
		for column=1:length(coded_bits[line])
			coded_bits[line][column] = coded_bits[line][column] + rand(distribution)
		end
	end

	return coded_bits
end

function BPSK(bits::Array{Int64, 1})
	for indice=1:length(bits)
		if bits[indice] == 0
			bits[indice] = -1
		end
	end
	return bits
end

end