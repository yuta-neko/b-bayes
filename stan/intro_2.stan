//データを指定するためのブロック
data {
  //サンプルサイズ
  int Nt;
  int Ns;
  
  //応答変数
  vector[Nt] t;
  vector[Ns] s;
}


//パラメータを指定するためのブロック
parameters {
  
  real theta_t;
  real<lower=0> sigma_t;
  
  real theta_s;
  real<lower=0> sigma_s;
}


//モデルを指定するためのブロック
model {
  //確率分布
  t ~ normal(theta_t, sigma_t);
  s ~ normal(theta_s, sigma_s);
}