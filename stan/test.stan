//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  
  //応答変数
  array[N] int Y;
  
  //説明変数
  matrix[N,22] X;
  
  matrix[110,22] X_pred;
}


//パラメータを指定するためのブロック
parameters {
  //パラメータ
  vector[22] beta;

  
  //ハイパーパラメータ
  
  
}

transformed parameters{
  vector[N] lamb = X*beta;
}


//モデルを指定するためのブロック
model{
  Y ~ poisson_log(lamb);
}



generated quantities{
  vector[110] lamb_pred;
  lamb_pred = X_pred * beta;
}






