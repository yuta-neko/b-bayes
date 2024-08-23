//5_8_1

data{
  int T;                      //観測期間
  int len_obs;                //観測できた個数
  array[len_obs] int y;       //観測値
  array[len_obs] int obs_no;  //観測値が得られた時点
}

parameters{
  vector[T] mu;             //状態の推定値
  real<lower = 0> s_w;      //過程誤差の標準偏差
}

model{
  s_w ~ student_t(3, 0, 10);  //弱情報分布
  for(i in 2:T){              //状態方程式
    mu[i] ~ normal(mu[i-1], s_w);  
  }
  
  
  //観測方程式
  for(i in 1:len_obs){
    y[i] ~ bernoulli_logit(mu[obs_no[i]]);
  }
}

generated quantities{
  vector[T] probs;         //推定された勝率
  probs = inv_logit(mu);
}