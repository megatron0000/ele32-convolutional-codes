module channels

using Distributions

export BSC
export AWGN
export BPSK

function BSC(p::Float64, coded_bits::Array{Array{Int64, 1}, 1})

    changed_bits = Array{Array{Int64, 1}, 1}(undef, length(coded_bits))
    for i=1:length(changed_bits)
        changed_bits[i] = Array{Int64, 1}(undef, length(coded_bits[1]))
    end

	line = 1
	prob = rand(length(coded_bits)*length(coded_bits[line]))
	indice = 1

	for line=1:length(coded_bits)
		for column=1:length(coded_bits[line])
			if prob[indice] < p
                changed_bits[line][column] = abs(coded_bits[line][column] - 1)
            else
                changed_bits[line][column] = coded_bits[line][column]
			end
			indice += 1
		end
	end

	return changed_bits
end

function AWGN(N0::Float64, coded_bits::Array{Array{Float64, 1}, 1})
    changed_bits = Array{Array{Float64, 1}, 1}(undef, length(coded_bits))
    for i=1:length(changed_bits)
        changed_bits[i] = Array{Int64, 1}(undef, length(coded_bits[1]))
    end

	distribution = sampler(Normal(0, sqrt(N0/2)))

	for line=1:length(coded_bits)
		for column=1:length(coded_bits[line])
			changed_bits[line][column] = coded_bits[line][column] + rand(distribution)
		end
	end

	return changed_bits
end

function BPSK(bits::Array{Int64, 1})
    bpsk_bits = Array{Int64, 1}(undef, length(bits))
    
    for indice=1:length(bits)
		if bits[indice] == 0
            bpsk_bits[indice] = -1
        else
            bpsk_bits[indice] = 1
		end
    end
    
	return bpsk_bits
end

end