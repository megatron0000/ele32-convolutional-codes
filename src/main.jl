module main

using conv_code
using encoder
using decoder
using channels

NN = [3.0, 3.0*10^(-0.1), 3.0*10^(-0.2), 3.0*10^(-0.3), 3.0*10^(-0.4), 3.0*10^(-0.5), 3.0*10^(-0.6), 3.0*10^(-0.7), 3.0*10^(-0.8), 3.0*10^(-0.9), 3.0*10^(-1.0)]
# Mapeamento p = Q(Sqrt(2 Eb / N0))
PP = [0.207108, 0.179801, 0.151996, 0.124387, 0.0978224, 0.0732565, 0.0516433, 0.0337817, 0.0201361, 0.0106902, 0.00491164]
code1 = ConvolutionalCode(3, [[1, 3, 4], [1, 2, 4], [1, 2, 3, 4]])
code2 = ConvolutionalCode(4, [[1, 3, 5], [1, 2, 4, 5], [1, 2, 3, 4, 5]])
code3 = ConvolutionalCode(6, [[1, 4, 5, 6, 7], [1, 3, 5, 6 , 7], [1, 2, 4, 5, 7]])

error1 = Array{Float64,1}(undef, length(NN))
error2 = Array{Float64,1}(undef, length(NN))
error3 = Array{Float64,1}(undef, length(NN))

info_bits = rand([0,1], 10000)
encoded_bits1 = encode(code1, info_bits)
encoded_bits2 = encode(code2, info_bits)
encoded_bits3 = encode(code3, info_bits)

for indice=1:length(PP)
	p = PP[indice]

	print("code1")
	decoded_bits1 = decode(p, code1, convert(Array{Array{Float64, 1}, 1}, BSC(p, encoded_bits1)))
	print("code2")
	decoded_bits2 = decode(p, code2, convert(Array{Array{Float64, 1}, 1}, BSC(p, encoded_bits2)))
	print("code3")
	decoded_bits3 = decode(p, code3, convert(Array{Array{Float64, 1}, 1}, BSC(p, encoded_bits3)))

# for indice=1:length(NN)
# 	p = 1.0 # qualquer. Não usado pelo euclidean_cost
# 	N0 = NN[indice]

# 	print("code1")
# 	decoded_bits1 = decode(p, code1, AWGN(N0, convert(Array{Array{Float64, 1}, 1}, BPSK.(encoded_bits1))))
# 	print("code2")
# 	decoded_bits2 = decode(p, code2, AWGN(N0, convert(Array{Array{Float64, 1}, 1}, BPSK.(encoded_bits2))))
# 	print("code3")
# 	decoded_bits3 = decode(p, code3, AWGN(N0, convert(Array{Array{Float64, 1}, 1}, BPSK.(encoded_bits3))))

	error1[indice] = sum(abs.(decoded_bits1 - info_bits))
	error2[indice] = sum(abs.(decoded_bits2 - info_bits))
	error3[indice] = sum(abs.(decoded_bits3 - info_bits))
end

open("/Users/Eduardo/Documents/GitHub/ele32-convolutional-codes/src/error1.txt", "w") do io
	for i=1:length(error1)
		println(io, error1[i])
	end
end

open("/Users/Eduardo/Documents/GitHub/ele32-convolutional-codes/src/error2.txt", "w") do io
	for i=1:length(error2)
		println(io, error2[i])
	end
end

open("/Users/Eduardo/Documents/GitHub/ele32-convolutional-codes/src/error3.txt", "w") do io
	for i=1:length(error3)
		println(io, error3[i])
	end
end

end