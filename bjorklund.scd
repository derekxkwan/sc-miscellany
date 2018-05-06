//euclidean rhythm generator

~bjorklund = {|n=13,k=5,groups = 0|
	//n = seq len, k = number of 1s
	//if groups = 1, counting groups starting with 1s
	//else just list of 1s and 0s
	var ret, m,r;
	if(k>n, {n=k});
	m = n-k; //number of 0s
	r = min(m,k);
	ret = Array.fill(m+k, {|i| if(i<k, {[1]},{[0]});});
	while({r>1}, {
		var newlen, rng = min(m,k);
		for(0,rng-1,
			{|i| ret[i] = ret[i] ++ ret[i+k]});
		newlen = ret.size - rng;
		ret = ret[..(newlen-1)];
		if(m>=k,
			{m = m-k;},
			{var temp = k;
				k = m;
				m = temp - m;});
		r = min(m,k);
	});
	ret = ret.flat;
	if(groups > 0,
		{var grp = [], count = 1;
			ret = ret[1..];
			ret.do({|elt|
				if(elt == 1,
					{grp = grp ++ [count];
						count = 1;},
					{count = count + 1;});
			});
			grp  = grp ++ [count];},
		{ret;});
};
