//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //応答変数
  vector[N] Y;  
  
  //説明変数
  vector[N] X;
  
  vector[N] D_1;
  
  vector[N] D_2;
  
  
  int N_pred;
  vector[N_pred] X_pred;
}


//パラメータを指定するためのブロック
parameters {
  
  //パラメータ
  real intercept;
  
  real beta1;
  
  real beta2;
  
  real beta3;
  
  //パラメータ誤差
  real<lower=0> sigma;  
  
}


//モデルを指定するためのブロック
model {
  vector[N] mu = intercept + beta1*D_1 + beta2*D_2 + beta3 * X;
  for(i in 1 : N){
    Y[i] ~ normal(mu[i], sigma);
  }
}

generated quantities{
  vector[N_pred] mu_pred_1;
  vector[N_pred] mu_pred_2;
  vector[N_pred] mu_pred_3;
  
  for(i in 1:N_pred){
    mu_pred_1[i]=intercept + beta3 * X_pred[i];
  }
  
  for(i in 1:N_pred){
    mu_pred_2[i]=intercept + beta1+ beta3 * X_pred[i];
  }
   for(i in 1:N_pred){
     mu_pred_3[i]=intercept + beta2 + beta3 * X_pred[i];
   }
}