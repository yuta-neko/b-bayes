//3_10_3


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
  vector[N_pred] mu_pred_1;
  vector[N_pred] mu_pred_2;
  vector[N_pred] mu_pred_3;
  vector[N_pred] mu_pred_4;
  vector[N_pred] mu_pred_5;
  vector[N_pred] mu_pred_6;
  vector[N_pred] mu_pred_7;
  vector[N_pred] mu_pred_8;
  vector[N_pred] mu_pred_9;
  //応答変数Yの予測値
  vector[N_pred] Y_pred_1;
  vector[N_pred] Y_pred_2;
  vector[N_pred] Y_pred_3;
  vector[N_pred] Y_pred_4;
  vector[N_pred] Y_pred_5;
  vector[N_pred] Y_pred_6;
  vector[N_pred] Y_pred_7;
  vector[N_pred] Y_pred_8;
  vector[N_pred] Y_pred_9;
  
  for (i in 1:N_pred){
     mu_pred_1[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 1 + beta_3 * X_pred[i] * 1;
     Y_pred_1[i] = normal_rng(mu_pred_1[i], sigma);
    
     mu_pred_2[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 2 + beta_3 * X_pred[i] * 2;
     Y_pred_2[i] = normal_rng(mu_pred_2[i], sigma);
     
     mu_pred_3[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 3 + beta_3 * X_pred[i] * 3;
     Y_pred_3[i] = normal_rng(mu_pred_3[i], sigma);
    
     mu_pred_4[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 4 + beta_3 * X_pred[i] * 4;
     Y_pred_4[i] = normal_rng(mu_pred_4[i], sigma);
     
     mu_pred_5[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 5 + beta_3 * X_pred[i] * 5;
     Y_pred_5[i] = normal_rng(mu_pred_5[i], sigma);
    
     mu_pred_6[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 6 + beta_3 * X_pred[i] * 6;
     Y_pred_6[i] = normal_rng(mu_pred_6[i], sigma);
     
     mu_pred_7[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 7 + beta_3 * X_pred[i] * 7;
     Y_pred_7[i] = normal_rng(mu_pred_7[i], sigma);
    
     mu_pred_8[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 8 + beta_3 * X_pred[i] * 8;
     Y_pred_8[i] = normal_rng(mu_pred_8[i], sigma);
     
     mu_pred_9[i] = beta_0 + beta_1*X_pred[i] + beta_2 * 9 + beta_3 * X_pred[i] * 9;
     Y_pred_9[i] = normal_rng(mu_pred_9[i], sigma);
  }
}