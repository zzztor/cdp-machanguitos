# cdp-machanguitos
In this example we use [Machanguitos](https://github.com/IFCA/machanguitos) (Agent based model)
to simulate how cows and sheeps moves around CdP reservoir.
This simulation is intended to estimate the contribution of livestock to the eutrophication
of the reservoir. To define the movement of the Agents we used GIS layers (`4-abril.png`, `5-mayo.png` ...)
given by [IFCA](http://www.ifca.unican.es/).

As we can see in `cdpsimulation.lua` we simulate 214 days (~ 7 months) in ~30k steps (600s per step):

```
config.setvars({
	starttime = 0.0,
	endtime = 24 * 214,
	iters = 144 * 214,
	randomseed = 1,
})
```


