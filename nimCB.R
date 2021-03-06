nimcode <- nimbleCode({
  ##prior distributions  
  reporting ~ dunif(0,1)
  effprop ~ dunif(0,1)
  beta ~ dunif(0,0.1)
  
  N0 ~ dbin(effprop,N)
  
  
  I[1] ~ dbin(1,i0) ##hack to make sure you get at least 1 infectious 
  S[1] <- N0 - i0
  pSI[1] <- 1 - (1-beta)^I[1]
  obs[1] ~ dbin(reporting,I[1])
  
  for(t in 2:numobs){
  I[t] ~ dbin(pSI[t-1],S[t-1])
  S[t] <- S[t-1] - I[t]
  pSI[t] <- 1 - (1-beta)^I[t]
  obs[t] ~ dbin(reporting,I[t])
  }

  
})