//5_7_1g

data{
  int T;
  vector[T] y;
}

parameters{
  real<lower=0> s_w;
  real b_ar;
  real intercept;
}

model{
  for(i in 2:T){
    y[i] ~ normal(intercept + y[i - 1] * b_ar,s_w);
  }
}