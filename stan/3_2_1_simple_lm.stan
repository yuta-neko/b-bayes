data {
  int N;
  vector[N] sales;
  vector[N] temperature;
}




parameters {
  real intercept;
  real beta;
  real<lower=0> sigma;
}



model {
  sales ~ normal(intercept + beta * temperature, sigma);
}

