//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //応答変数
  vector[N] Y;  
  
}


//パラメータを指定するためのブロック
parameters {
  
  //パラメータ
  real theta;  
  real sigma;
}


//モデルを指定するためのブロック
model {
  //確率分布
  Y ~ normal(theta, sigma);
  theta ~ normal(170, 2);
}