//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //応答変数
  int Y[N];  
  
  //説明変数
  vector[N] X;
  
  vector[N] D;
  
  
  //予測データの大きさ
  int N_pred;
  //予測対象となる説明変数
  vector[N_pred] X_pred;
}


//パラメータを指定するためのブロック
parameters {
  //パラメータ切片
  real beta_0; 
  real beta_1;
  real beta_2;
  
}

//モデルを指定するためのブロック
model {
  vector[N] lamb;
  
  for(i in 1:N){
  lamb[i] = exp(beta_0 + beta_1 * D[i] + beta_2 * X[i]);    
  Y[i] ~ poisson(lamb[i]);
  }
}


generated quantities{
  
  //応答変数Yの期待値
  vector[N_pred] lamb_pred_1;
  vector[N_pred] lamb_pred_2;
  vector[N_pred] Y_pred_1;
  vector[N_pred] Y_pred_2;
  
  for (i in 1:N_pred){
     lamb_pred_1[i] = exp(beta_0 + + beta_2 * X_pred[i]);
     lamb_pred_2[i] = exp(beta_0 +beta_1 + beta_2 * X_pred[i]);
     
     Y_pred_1[i] = poisson_rng(lamb_pred_1[i]);
     Y_pred_2[i] = poisson_rng(lamb_pred_2[i]);
  }
}