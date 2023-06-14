import csv
import chardet
import matplotlib
import pandas as pd
import matplotlib.pyplot as plt

# Detect the encoding of the file
with open('u2010m.csv', 'rb') as file:
    result = chardet.detect(file.read())

# Read the file with the detected encoding
data = pd.read_csv('u2010m.csv', encoding=result['encoding'])
print(getTitle(data))


# Iterate over the transposed data
#for column, value in grouped_data.iteritems():
    # column represents the imported country, value represents the sum
#    print(column, ":", value)
