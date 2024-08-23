//5_2_1

//データを指定するためのブロック
data {
  //サンプルサイズ
  int T;
  
  //応答変数
  vector[T] y;
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
  for(i in 2:T){
    mu[i] ~ normal(mu[i-1], s_w);
  }
  
  
  // 観測方程式
  for(i in 1:T){
     y[i] ~ normal(mu[i], s_v);
  }
 
}
