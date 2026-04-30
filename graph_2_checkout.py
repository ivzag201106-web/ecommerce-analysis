import pandas as pd
import matplotlib.pyplot as plt
df_1 = pd.read_csv('df_Orders.csv')
df_2 = pd.read_csv('df_Payments.csv')
df_merge = pd.merge(df_1,df_2, on = 'order_id')
df_merge['order_purchase_timestamp'] = pd.to_datetime(df_merge['order_purchase_timestamp'])
df_merge['month'] = df_merge['order_purchase_timestamp'].dt.to_period('M')
df_merge['payment_value'].hist()
plt.title('Распределение суммы транзакций')
plt.xlabel('Сумма транзакций')
plt.xlim(0, 3000)
plt.ylabel('Колличество транзакций')

plt.show()