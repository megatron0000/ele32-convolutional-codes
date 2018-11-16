module main

using conv_code
using encoder
using decoder
using channels

PP = [0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.04, 0.03, 0.02, 0.01, 0.005, 0.004, 0.003, 0.002, 0.001, 0.0005, 0.0004, 0.0003, 0.0002, 0.0001, 0.00005, 0.00004, 0.00003, 0.00002, 0.00001, 0.000005, 0.000004, 0.000003, 0.000002, 0.000001]
NN = [3.0, 3.0*10^0.1, 3.0*10^0.2, 3.0*10^0.3, 3.0*10^0.4, 3.0*10^0.5, 3.0*10^0.6, 3.0*10^0.7, 3.0*10^0.8, 3.0*10^0.9, 3.0*10^1.0]
code1 = ConvolutionalCode(3, [[1, 3, 4], [1, 2, 4], [1, 2, 3, 4]])
code2 = ConvolutionalCode(4, [[1, 3, 5], [1, 2, 4, 5], [1, 2, 3, 4, 5]])
code3 = ConvolutionalCode(6, [[1, 4, 5, 6, 7], [1, 3, 5, 6 , 7], [1, 2, 4, 5, 7]])

# error1 = Array{Float64,1}(undef, 30)
# error2 = Array{Float64,1}(undef, 30)
# error3 = Array{Float64,1}(undef, 30)

error1 = Array{Float64,1}(undef, 11)
error2 = Array{Float64,1}(undef, 11)
error3 = Array{Float64,1}(undef, 11)

info_bits = Array{Int64,1}(undef, 1000000)
fill!(info_bits, 0)

# for indice=1:length(PP)
# 	p = PP[indice]

# 	print("code1")
# 	decoded_bits1 = decode(p, code1, convert(Array{Array{Float64, 1}, 1}, BSC(p, encode(code1, info_bits))))
# 	print("code2")
# 	decoded_bits2 = decode(p, code2, convert(Array{Array{Float64, 1}, 1}, BSC(p, encode(code2, info_bits))))
# 	print("code3")
# 	decoded_bits3 = decode(p, code3, convert(Array{Array{Float64, 1}, 1}, BSC(p, encode(code3, info_bits))))

for indice=1:length(NN)
	p = 1.0
	N0 = NN[indice]

	print("code1")
	decoded_bits1 = decode(p, code1, AWGN(N0, convert(Array{Array{Float64, 1}, 1}, BPSK.(encode(code1, info_bits)))))
	print("code2")
	decoded_bits2 = decode(p, code2, AWGN(N0, convert(Array{Array{Float64, 1}, 1}, BPSK.(encode(code2, info_bits)))))
	print("code3")
	decoded_bits3 = decode(p, code3, AWGN(N0, convert(Array{Array{Float64, 1}, 1}, BPSK.(encode(code3, info_bits)))))

	error1[indice] = sum(decoded_bits1)
	error2[indice] = sum(decoded_bits2)
	error3[indice] = sum(decoded_bits3)
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