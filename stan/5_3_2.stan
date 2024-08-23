//5_3_1

//データを指定するためのブロック
data {
  //データを取得した期間
  int T;
  //観測値が得られた個数
  int len_obs;
  
  //観測値
  vector[len_obs] y;
  
  //観測値が得られた時点
  array[len_obs] int obs_no;
  
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
  y[1:len_obs] ~ normal(mu[obs_no[1:len_obs]], s_v);
}



generated quantities{
  vector[T] y_pred;
  for(i in 1:T){
    y_pred[i] = normal_rng(mu[i], s_v);
  }
}
