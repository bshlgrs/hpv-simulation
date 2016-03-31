# HPV monte carlo simulation

If I have regular sex with two women for a year, then one of them gets HPV, what's the chance that the other person has it? My friend asked me to calculate this, so here's some of my initial work.

Note that the numbers I have obviously don't add up. Here's a result from [a paper](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3203235/):

> Among 308 college-age women and their male sexual partners — all in relationships of less than 6 months' duration — researchers identified 179 couples discordant for one or more HPV types. About 6 months later, genital sampling indicated HPV transmission in 73 couples (41%). The transmission rate was 3.7 instances per 100 person-months, for a per-person transmission probability of about 20% during a 6-month period.
> [...]
> Transmission rates from women to men and men to women were the same and varied little with the circumcision status of the men, the lifetime sexual experience of uninfected partners, or the oncogenic risk of the HPV type.

Now, people also get better from HPV pretty fast--"Although most HPV infections go away within 8 to 13 months, some will not.", according to [Planned Parenthood](https://www.plannedparenthood.org/learn/stds-hiv-safer-sex/hpv#sthash.pCIcDiMH.dpuf).

But this makes no sense! If the average HPV infection lasts 12 months, which is a conservative reading of the previous result, then you have to cause one infection on average for HPV to persist in the population. If you have sex with someone for six months, then you only transmit it 20% of the time. So you'd have to be having regular sex for six months with an average for 2.5 people, which is almost certainly not true.

How do we reconcile these numbers?

Well, one obvious problem with the previous result is that if you get a bunch of people with HPV, then get them to have sex with other people for a while, some of your infected test subjects will get better, and some of your uninfected test subjects will get infected then get better again.

Another paper: http://aje.oxfordjournals.org/content/163/6/534.long

more papers: http://www.dlsph.utoronto.ca/faculty-profile/burchell-ann-natalie/

ann.burchell@utoronto.ca
