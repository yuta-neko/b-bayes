//5_4_1

data {
  int N;
  vector[N] y;
  vector[N] x;
  
  vector[9] x_pred;
}




parameters {
  real beta_0;
  real beta_1;
  real<lower=0> sigma;
}



model {
  y ~ normal(beta_0 + beta_1 * x, sigma);
}

generated quantities{
  vector[9] mu_pred;
  for(i in 1:9){
    mu_pred[i] = beta_0 + beta_1 * x_pred[i];
  }
}