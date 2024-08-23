//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //応答変数
  vector[N] Y;  
  
  //説明変数
  vector[N] D_1;
  vector[N] D_2;
  
}


//パラメータを指定するためのブロック
parameters {
  //パラメータ切片
  real beta_0; 
  
  //パラメータ係数
  real beta_1;
  real beta_2;
  
  //パラメータ誤差
  real<lower=0> sigma;  
}


//モデルを指定するためのブロック
model {
  
  vector[N] mu;
  
  for(i in 1:N){
    mu[i] = beta_0 + beta_1 * D_1[i] + beta_2 * D_2[i];
    Y[i] ~ normal(mu[i], sigma);
  }
}


generated quantities{
  
  //応答変数Yの期待値
  vector[1] mu_1;
  vector[1] mu_2;
  vector[1] mu_3;
  
  for (i in 1:1){
     mu_1[i] = beta_0;
     mu_2[i] = beta_0 + beta_1;
     mu_3[i] = beta_0 + beta_2;
  }
}