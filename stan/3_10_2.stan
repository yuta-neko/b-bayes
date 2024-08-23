//3_10_2


//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //応答変数
  vector[N] Y;  

  //説明変数
  vector[N] X_1;
  vector[N] X_2;

  //予測データの大きさ
  int N_pred;
  vector[N_pred] X_pred;
}


//パラメータを指定するためのブロック
parameters {
  //パラメータ切片
  real beta_0; 
  
  //パラメータ係数
  real beta_1;
  real beta_2;
  real beta_3;

  //パラメータ誤差
  real<lower=0> sigma;  
}


//モデルを指定するためのブロック
model {
  
  vector[N] mu;
  
  //確率分布
  for(i in 1:N){
     mu[i] = beta_0 + beta_1*X_1[i] + beta_2*X_2[i] + beta_3 * X_1[i] * X_2[i];
     Y[i] ~ normal(mu[i], sigma);
  }
}


//予測のためのブロック
//必要がなければ消す
generated quantities{
  
  //応答変数Yの期待値
  vector[N_pred] mu_pred_0;
  vector[N_pred] mu_pred_1;
  //応答変数Yの予測値
  vector[N_pred] Y_pred_0;
  vector[N_pred] Y_pred_1;
  
  for (i in 1:N_pred){
     mu_pred_0[i] = beta_0 + beta_2 * X_pred[i];
     Y_pred_0[i] = normal_rng(mu_pred_0[i], sigma);
    
     mu_pred_1[i] = beta_0 + beta_1 + beta_2 * X_pred[i] + beta_3 * X_pred[i];
     Y_pred_1[i] = normal_rng(mu_pred_1[i], sigma);
  }
}