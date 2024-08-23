data{
  //サンプルサイズ
  int N;
  
  //応答変数
  int Y[N];
  
  //説明変数
  vector[N] D;
  vector[N] X;
  
  //予測
  int N_pred;
  real X_pred[N_pred];
}

parameters{
  real beta_0;
  real beta_1;
  real beta_2;
}

model{
  vector[N] prob;
  
  for(i in 1:N){
    prob[i] = inv_logit(beta_0+beta_1*D[i]+beta_2*X[i]);
    Y[i] ~ binomial(10, prob[i]);
  }
}

generated quantities{
  vector[N_pred] P_1;
  vector[N_pred] P_2;
  int Y_1[N_pred];
  int Y_2[N_pred];
  
  for(i in 1:N_pred){ 
    P_1[i] = inv_logit(beta_0 + beta_2 * X_pred[i]);
    P_2[i] = inv_logit(beta_0 + beta_1 + beta_2 * X_pred[i]);
    Y_1[i] = binomial_rng(10,P_1[i]);
    Y_2[i] = binomial_rng(10, P_2[i]);
  }
}