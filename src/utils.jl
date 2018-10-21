module utils

export @swap!
export dec2bin

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

function dec2bin(number::Int64, size::Int64)
	binary = Array{Int64, 1}(undef, size)
	quotient = number
	remainder = 0
	for i=size:-1:1
		remainder = mod(quotient, 2)
		quotient = div(quotient, 2)
		binary[i] = remainder
	end
	return binary
end


end