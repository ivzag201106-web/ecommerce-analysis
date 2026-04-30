#Ананализ датасета
import pandas as pd
df = pd.read_csv('df_Payments.csv')
print(df.groupby('payment_type') ['payment_value'].agg(['sum','mean']))