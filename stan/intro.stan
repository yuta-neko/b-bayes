data {
  int N;
  vector[N] y;
}

parameters {
  real x;
  real<lower=0> sigma;
}



model {
  y ~ normal(x, sigma);
}

