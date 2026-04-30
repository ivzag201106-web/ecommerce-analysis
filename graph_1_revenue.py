import pandas as pd
import matplotlib.pyplot as plt
df_1 = pd.read_csv('df_Orders.csv')
df_2 = pd.read_csv('df_Payments.csv')
df_merged = pd.merge(df_1,df_2, on = 'order_id')
df_merged['order_purchase_timestamp'] = pd.to_datetime(df_merged['order_purchase_timestamp'])
df_merged['month']= df_merged['order_purchase_timestamp'].dt.to_period('M')
monthly_revenue  = df_merged.groupby('month')['payment_value'].agg(['sum','mean'])
print(monthly_revenue )
monthly_revenue['sum'].plot()
plt.title('Выручка по месяцам')
plt.xlabel('Месяца')
plt.ylabel('Выручка')
plt.savefig('Выручка по месяцам.png')
plt.show()

