data {
  int N;                  //サンプルサイズ
  vector[N] sales;        //売上データ
  vector[N] temperature;  //気温データ

  int N_pred;                              //予測データの大きさ
  vector[N_pred] temperature_pred;         //予測対象となる気温
}



parameters {
  real intercept;       //切片
  real beta;            //係数
  real<lower=0> sigma;  //標準偏差
}



model {
  //平均Intersept + beta * temperature
  //標準偏差sigmaの正規分布に従ってデータが得られたと仮定
  sales ~ normal(intercept + beta * temperature, sigma);
}

generated quantities{
  vector[N_pred] mu_pred;       //売上の期待値
  vector[N_pred] sales_pred;    //売上の予測値
  
  for (i in 1:N_pred){
     mu_pred[i] = intercept + beta * temperature_pred[i];
     sales_pred[i] = normal_rng(mu_pred[i], sigma);
  }
}

