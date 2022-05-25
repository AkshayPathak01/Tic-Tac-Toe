## ml 1
```sh
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression

df = pd.read_csv('hours.csv')

print(df)

x = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

print(x)
print(y)

model = LinearRegression()

model.fit(x, y)

print(model.score(x, y))

print('Intercept: ', model.intercept_)
print('Regression Coefficient: ', model.coef_)


pred = model.predict([[55]])

print(pred)
```
## ml2 dt
```sh

#import packages
import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.tree import DecisionTreeClassifier

dataset=pd.read_csv("tree1.csv")

x = dataset.iloc[:,:-1]
y = dataset.iloc[:,-1]


le = LabelEncoder()

x = x.apply(le.fit_transform)

print(x)


classifier=DecisionTreeClassifier()

classifier.fit(x.iloc[:,1:5],y)


y_pred = classifier.predict([[1,1,0,0]])

print(y_pred)

```
## ml 3 knn
```sh
import pandas as pd
import numpy as np

dataset=pd.read_csv("kdata.csv")

X=dataset.iloc[:,:-1].values
y=dataset.iloc[:,2].values

from sklearn.neighbors import KNeighborsClassifier

classifier=KNeighborsClassifier(n_neighbors=3)
classifier.fit(X,y)

X_test=np.array([6,6])

y_pred=classifier.predict([X_test])

print(y_pred)


classifier=KNeighborsClassifier(n_neighbors=3,weights='distance')
classifier.fit(X,y)

X_test=np.array([6,2])
y_pred=classifier.predict([X_test])
print(y_pred)





```
## ml 4 k means
```
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.cluster import KMeans


X = [[0.1,0.6],[0.2,0.5],[0.08,0.9],[0.16,0.85],[0.2,0.3],[0.25,0.5],[0.1,0.6],[0.3,0.2]]

print(X)

centroids = np.array([[0.1,0.6],[0.3,0.2]])

model = KMeans(n_clusters=2)

model.fit(X)

labels = model.labels_

# Refer problem from syllabus to understand the questions

print(labels)
print('p6 belogs to cluster :',model.labels_[6])
	
count=0
for i in range(len(labels)):
    if (labels[i]==1):
        count=count+1

print('No of population around cluster 2:',np.count_nonzero(model.labels_ == 1))

print('Previous value of m1 and m2 is:')
print('M1==',centroids[0])
print('M2==',centroids[1])

new_centroids = model.cluster_centers_

print('updated value of m1 and m2 is:')
print('M1==',new_centroids[0])
print('M2==',new_centroids[1])



```
## ics 1 des
```sh
# DES [Data Encryption Standard]

from sys import exit
from time import time
 
KeyLength = 10
SubKeyLength = 8
DataLength = 8
FLength = 4
 
# Tables for initial and final permutations (b1, b2, b3, ... b8)
IPtable = (2, 6, 3, 1, 4, 8, 5, 7)
FPtable = (4, 1, 3, 5, 7, 2, 8, 6)
 
# Tables for subkey generation (k1, k2, k3, ... k10)
P10table = (3, 5, 2, 7, 4, 10, 1, 9, 8, 6)
P8table = (6, 3, 7, 4, 8, 5, 10, 9)
 
# Tables for the fk function
EPtable = (4, 1, 2, 3, 2, 3, 4, 1)
S0table = (1, 0, 3, 2, 3, 2, 1, 0, 0, 2, 1, 3, 3, 1, 3, 2)
S1table = (0, 1, 2, 3, 2, 0, 1, 3, 3, 0, 1, 0, 2, 1, 0, 3)
P4table = (2, 4, 3, 1)
 
def perm(inputByte, permTable):
    """Permute input byte according to permutation table"""
    outputByte = 0
    for index, elem in enumerate(permTable):
        if index >= elem:
            outputByte |= (inputByte & (128 >> (elem - 1))) >> (index - (elem - 1))
        else:
            outputByte |= (inputByte & (128 >> (elem - 1))) << ((elem - 1) - index)
    return outputByte
 
def ip(inputByte):
    """Perform the initial permutation on data"""
    return perm(inputByte, IPtable)
 
def fp(inputByte):
    """Perform the final permutation on data"""
    return perm(inputByte, FPtable)
 
def swapNibbles(inputByte):
    """Swap the two nibbles of data"""
    return (inputByte << 4 | inputByte >> 4) & 0xff
 
def keyGen(key):
    """Generate the two required subkeys"""
    def leftShift(keyBitList):
        """Perform a circular left shift on the first and second five bits"""
        shiftedKey = [None] * KeyLength
        shiftedKey[0:9] = keyBitList[1:10]
        shiftedKey[4] = keyBitList[0]
        shiftedKey[9] = keyBitList[5]
        return shiftedKey
 
    # Converts input key (integer) into a list of binary digits
    keyList = [(key & 1 << i) >> i for i in reversed(range(KeyLength))]
    permKeyList = [None] * KeyLength
    for index, elem in enumerate(P10table):
        permKeyList[index] = keyList[elem - 1]
    shiftedOnceKey = leftShift(permKeyList)
    shiftedTwiceKey = leftShift(leftShift(shiftedOnceKey))
    subKey1 = subKey2 = 0
    for index, elem in enumerate(P8table):
        subKey1 += (128 >> index) * shiftedOnceKey[elem - 1]
        subKey2 += (128 >> index) * shiftedTwiceKey[elem - 1]
    return (subKey1, subKey2)
 
def fk(subKey, inputData):
    """Apply Feistel function on data with given subkey"""
    def F(sKey, rightNibble):
        aux = sKey ^ perm(swapNibbles(rightNibble), EPtable)
        index1 = ((aux & 0x80) >> 4) + ((aux & 0x40) >> 5) + \
                 ((aux & 0x20) >> 5) + ((aux & 0x10) >> 2)
        index2 = ((aux & 0x08) >> 0) + ((aux & 0x04) >> 1) + \
                 ((aux & 0x02) >> 1) + ((aux & 0x01) << 2)
        sboxOutputs = swapNibbles((S0table[index1] << 2) + S1table[index2])
        return perm(sboxOutputs, P4table)
 
    leftNibble, rightNibble = inputData & 0xf0, inputData & 0x0f
    return (leftNibble ^ F(subKey, rightNibble)) | rightNibble
 
def encrypt(key, plaintext):
    """Encrypt plaintext with given key"""
    data = fk(keyGen(key)[0], ip(plaintext))
    return fp(fk(keyGen(key)[1], swapNibbles(data)))
 
def decrypt(key, ciphertext):
    """Decrypt ciphertext with given key"""
    data = fk(keyGen(key)[1], ip(ciphertext))
    return fp(fk(keyGen(key)[0], swapNibbles(data)))  
 
if __name__ == '__main__':

	plainText = 0b1110001110
	key = 0b10101010
	cipText = encrypt(plainText, key)
	print(f'Cipher text for {plainText} is {bin(cipText)[2:]}')
	
	
'''
Output:

Cipher text for 910 is 11001010

'''

 
    
```

## ics 2 acs
```sh
# AES [Advanced Encryption Standard]

import sys
 
# S-Box
sBox  = [0x9, 0x4, 0xa, 0xb, 0xd, 0x1, 0x8, 0x5,
         0x6, 0x2, 0x0, 0x3, 0xc, 0xe, 0xf, 0x7]
 
# Inverse S-Box
sBoxI = [0xa, 0x5, 0x9, 0xb, 0x1, 0x7, 0x8, 0xf,
         0x6, 0x0, 0x2, 0x3, 0xc, 0x4, 0xd, 0xe]
 
# Round keys: K0 = w0 + w1; K1 = w2 + w3; K2 = w4 + w5
w = [None] * 6
 
def mult(p1, p2):
    """Multiply two polynomials in GF(2^4)/x^4 + x + 1"""
    p = 0
    while p2:
        if p2 & 0b1:
            p ^= p1
        p1 <<= 1
        if p1 & 0b10000:
            p1 ^= 0b11
        p2 >>= 1
    return p & 0b1111
 
def intToVec(n):
    """Convert a 2-byte integer into a 4-element vector"""
    return [n >> 12, (n >> 4) & 0xf, (n >> 8) & 0xf,  n & 0xf]            
 
def vecToInt(m):
    """Convert a 4-element vector into 2-byte integer"""
    return (m[0] << 12) + (m[2] << 8) + (m[1] << 4) + m[3]
 
def addKey(s1, s2):
    """Add two keys in GF(2^4)"""  
    return [i ^ j for i, j in zip(s1, s2)]
     
def sub4NibList(sbox, s):
    """Nibble substitution function"""
    return [sbox[e] for e in s]
     
def shiftRow(s):
    """ShiftRow function"""
    return [s[0], s[1], s[3], s[2]]
 
def keyExp(key):
    """Generate the three round keys"""
    def sub2Nib(b):
        """Swap each nibble and substitute it using sBox"""
        return sBox[b >> 4] + (sBox[b & 0x0f] << 4)
 
    Rcon1, Rcon2 = 0b10000000, 0b00110000
    w[0] = (key & 0xff00) >> 8
    w[1] = key & 0x00ff
    w[2] = w[0] ^ Rcon1 ^ sub2Nib(w[1])
    w[3] = w[2] ^ w[1]
    w[4] = w[2] ^ Rcon2 ^ sub2Nib(w[3])
    w[5] = w[4] ^ w[3]
 
def encrypt(ptext):
    """Encrypt plaintext block"""
    def mixCol(s):
        return [s[0] ^ mult(4, s[2]), s[1] ^ mult(4, s[3]),
                s[2] ^ mult(4, s[0]), s[3] ^ mult(4, s[1])]    
     
    state = intToVec(((w[0] << 8) + w[1]) ^ ptext)
    state = mixCol(shiftRow(sub4NibList(sBox, state)))
    state = addKey(intToVec((w[2] << 8) + w[3]), state)
    state = shiftRow(sub4NibList(sBox, state))
    return vecToInt(addKey(intToVec((w[4] << 8) + w[5]), state))
     
def decrypt(ctext):
    """Decrypt ciphertext block"""
    def iMixCol(s):
        return [mult(9, s[0]) ^ mult(2, s[2]), mult(9, s[1]) ^ mult(2, s[3]),
                mult(9, s[2]) ^ mult(2, s[0]), mult(9, s[3]) ^ mult(2, s[1])]
     
    state = intToVec(((w[4] << 8) + w[5]) ^ ctext)
    state = sub4NibList(sBoxI, shiftRow(state))
    state = iMixCol(addKey(intToVec((w[2] << 8) + w[3]), state))
    state = sub4NibList(sBoxI, shiftRow(state))
    return vecToInt(addKey(intToVec((w[0] << 8) + w[1]), state))
 
if __name__ == '__main__':
  
    plaintext = 0b1101011100101000
    key = 0b0100101011110101
    ciphertext = 0b0010010011101100
    keyExp(key)
    cipText = encrypt(plaintext)
   
    print(f'Cipher text for {plaintext} is {bin(cipText)[2:]}')
    
'''
Output:


Cipher text for 55080 is 10010011101100



'''

```


## ics 3 rsa
```sh
# RSA algorithm

from math import gcd

def main():

	p = int(input('Enter p: '))
	q = int(input('Enter q: '))

	#step 1
	
	n = p * q
	print(f'N is {n}')
	
	#step 2:
	
	phiOfN = (p-1) * (q-1)
	e = 2
	while e < phiOfN:
		if gcd(e,phiOfN)==1:
			break
		else:
			e = e+1
			
	
	k = 2
	d = (1+(k * phiOfN)) / e
	d = int(d)
	
	msg = int(input('Enter the message you want to encrypt: '))
	
	c = pow(msg, e, n)

	m = pow(c, d, n)
	
	print('Enc', bin(c)[2:])
	print('Dec', m)


main()

'''
Output:

Enter p: 5       
Enter q: 7
N is 35
Enter the message you want to encrypt: 6
Enc 110
Dec 6


'''


```



















