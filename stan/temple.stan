//データを指定するためのブロック
data {
  //サンプルサイズ
  int N;
  
  //応答変数
  vector[N] Y;  
  
  //説明変数
  vector[N] X;  
  
  
  //予測データの大きさ
  int N_pred;
  //予測対象となる説明変数
  vector[N_pred] X_pred; 
}


//パラメータを指定するためのブロック
parameters {
  //パラメータ切片
  real intercept; 
  
  //パラメータ係数
  real beta;          
  
  //パラメータ誤差
  real<lower=0> sigma;  
}


//モデルを指定するためのブロック
model {
  //事前分布の指定
  intercept ~ normal(0, 100);
  beta ~ normal(0, 100);
  temperature ~ normal(0, 100);
  
  //線形予測子
  vector[N] link = intercept + beta * X;
  
  //リンク関数
  vector[N] mu = link;    
  
  //確率分布
  Y ~ normal(mu, sigma);
}


//予測のためのブロック
//必要がなければ消す
generated quantities{
  
  //応答変数Yの期待値
  vector[N_pred] mu_pred;   
  //応答変数Yの予測値
  vector[N_pred] Y_pred;
  
  for (i in 1:N_pred){
     mu_pred[i] = intercept + beta * X_pred[i];
     Y_pred[i] = normal_rng(mu_pred[i], sigma);
  }
}