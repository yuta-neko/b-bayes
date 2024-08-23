//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //グループの種類
  int M;
  
  //応答変数
  array[N] int Y;
  
  //説明変数
  vector[N] X;
  array[N] int<lower=1, upper=10> group;
  
  int N_pred;
  vector[N_pred] X_pred;
}


//パラメータを指定するためのブロック
parameters {
  //パラメータ
  real beta_0;
  real beta_1;

  
  //ハイパーパラメータ
  vector[M] r;
  vector[M] tau;
  
  real<lower=0> sigma_r;
  real<lower=0> sigma_tau;
  
}

transformed parameters{
  vector[N] lamb = beta_0 + (beta_1 + tau[group]) .* X + r[group];
}


//モデルを指定するためのブロック
model{
  r ~ normal(0, sigma_r);
  tau ~ normal(0, sigma_tau);
  Y ~ poisson_log(lamb);
}

generated quantities {
  array[N_pred, M] real lambda_pred;
  array[N_pred, M] real y_pred;
  
  for (j in 1:M) {
    for (i in 1:N_pred) {
      lambda_pred[i,j] = exp(beta_0 + (beta_1 + tau[j]) * X_pred[i] + r[j]);

      y_pred[i,j] = poisson_rng(lambda_pred[i,j]);
    }
  }
}
