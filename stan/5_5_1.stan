//5_5_1

//データを指定するためのブロック
data {
  int T;        //データ取得期間の長さ
  vector[T] y;  //観測値
}


//パラメータを指定するためのブロック
parameters {
  vector[T] mu;       //水準＋ドリフト成分の推定値
  real<lower=0> s_z;  //ドリフト成分の変動の大きさを示す標準偏差
  real<lower=0> s_v;  //観測誤差の標準偏差
}


//モデルを指定するためのブロック
model {
  // 状態方程式
  for(i in 3:T){
    mu[i] ~ normal(2 * mu[i-1] - mu[i - 2], s_z);
  }
  
  
  // 観測方程式
  for(i in 1:T){
     y[i] ~ normal(mu[i], s_v);
  }
 
}
