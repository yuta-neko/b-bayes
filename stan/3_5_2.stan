data {
  //サンプルサイズ
  int N;
  
  //応答変数
  vector[N] sales;  
  
  //説明変数
  vector[N] temperature;      
  
}

parameters {
  //パラメータ切片
  real intercept; 
  
  //パラメータ係数
  real beta;          
  
  //パラメータ標準誤差
  real<lower=0> sigma;  
}

model {

  //線形予測子
  vector[N] link = intercept + beta * temperature;
  
  //リンク関数
  vector[N] mu = link;    
  
  //確率分布
  sales ~ normal(mu, sigma);
}

