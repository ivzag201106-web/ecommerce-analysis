import pandas as pd
import matplotlib.pyplot as plt
df_1 = pd.read_csv('df_OrderItems.csv')
df_2 = pd.read_csv('df_Products.csv')
df_merged = pd.merge(df_1,df_2, on = 'product_id')
df = df_merged.groupby('product_category_name')['price'].agg(['sum'])
top_10 = df.sort_values('sum',ascending=True).head(10)
top_10.plot(kind='barh')
plt.title('Топ 10 товаров по выручке')
plt.xlabel('Выручка')
plt.ylabel('Товар   ')
plt.show()
