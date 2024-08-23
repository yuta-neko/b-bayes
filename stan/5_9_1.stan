//5_9_1

data{
  int T;         //データ取得期間
  vector[T] X;   //説明変数
  array[T] int y;      //観測値
}

parameters{
  vector[T] mu;          //水準 + ドリフト成分の推定値
  vector[T] r;           //ランダム効果
  real b;                //係数の推定値
  real<lower = 0> s_z;   //ドリフト成分の変動の大きさを表す標準偏差
  real<lower = 0> s_r;   //ランダム効果の標準偏差
}

transformed parameters{
  vector[T] lambda;      //観測値の期待値のlog
  for(i in 1:T){
    lambda[i] = mu[i] + b * X[i] + r[i];
  }
}

model{
  r ~ normal(0,s_r);   //ランダム効果
  
  for(i in 3:T){       //状態方程式
    mu[i] ~ normal(2 * mu[i-1] - mu[i-2],s_z);
  }
  
  for(i in 1:T){       //観測方程式
    y[i] ~ poisson_log(lambda[i]);
  }
}

generated quantities{
  vector[T] lambda_exp;             //状態推定値
  vector[T] lambda_smooth;          //ランダム効果以外の状態推定値
  vector[T] lambda_smooth_fix;      //ランダム効果除外，説明変数固定の状態推定値
  
  lambda_exp = exp(lambda);
  lambda_smooth = exp(mu + b * X);
  lambda_smooth_fix = exp(mu + b * mean(X));
}