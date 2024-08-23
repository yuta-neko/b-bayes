//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //応答変数
  array[N] int Y;
  
  //説明変数
  vector[N] X_1;
  vector[N] X_2;
  
  
}


//パラメータを指定するためのブロック
parameters {
  //パラメータ
  real beta_0;
  real beta_1;
  real beta_2;
  
  //ハイパーパラメータ
  vector[N] r;
  real<lower=0> sigma_r;
  
}

transformed parameters{
  vector[N] lamb = beta_0 + beta_1*X_1 + beta_2*X_2 + r;
}
//モデルを指定するためのブロック
model{
  r ~ normal(0, sigma_r);
  Y ~ poisson_log(lamb);
}
