//5_3_1

//データを指定するためのブロック
data {
  //サンプルサイズ
  int T;
  
  //観測値
  vector[T] y;
  
  //予測期間の長さ
  int pred_term;
  
}


//パラメータを指定するためのブロック
parameters {
  vector[T] mu;
  real<lower=0> s_w;
  real<lower=0> s_v;
}


//モデルを指定するためのブロック
model {
  // 状態方程式
  mu[2:T] ~ normal(mu[1:(T-1)], s_w);
  
  // 観測方程式
  y ~ normal(mu, s_v);
}


generated quantities{
  //予測値も含めた状態の推定値
  vector[T + pred_term] mu_pred;
  
  //データ取得区間においては，状態推定値と同じ
  mu_pred[1:T] = mu;
  
  //データ取得区間を超えた部分を予測
  for(i in 1:pred_term){
    mu_pred[T + i] = normal_rng(mu_pred[T + i - 1], s_w);
  }
}