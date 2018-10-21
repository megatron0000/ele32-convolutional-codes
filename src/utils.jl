module utils

export @swap!

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

end