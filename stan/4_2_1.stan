




//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //応答変数
  array[N] int Y;
  
  //説明変数
  vector[N] X_1;
  vector[N] X_2;
  array[100] int group;
  
  vector[31] X_pred;
  vector[2] D_pred;
}


//パラメータを指定するためのブロック
parameters {
  //パラメータ
  real beta_0;
  real beta_1;
  real beta_2;
  
  //ハイパーパラメータ
  vector[10] r;
  real<lower=0> sigma_r;
  
}

transformed parameters{
  vector[N] lamb = beta_0 + beta_1*X_1 + beta_2*X_2 + r[group];
}
//モデルを指定するためのブロック
model{
  r ~ normal(0, sigma_r);
  Y ~ poisson_log(lamb);
}

generated quantities {
  array[31, 10, 2] real l_pred;
  array[31, 10, 2] real y_pred;
  
  for (d in 1:2){
    for (j in 1:10) {
      for (i in 1:31) {
        l_pred[i,j,d] = exp(beta_0 + beta_1*D_pred[d] + beta_2 * X_pred[i]+r[group[j]]);

        y_pred[i,j,d] = poisson_rng(l_pred[i,j,d]);
    }
  }
}
}
