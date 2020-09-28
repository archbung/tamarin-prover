TLS 1.3.
---

Needs m4 and perl

The following are result of running `bench.sh`

## Model A

No record, zero_rtt, post_hs, adversary

### prev_
57k

1898644
1841068
1912788
1872732
1914976

### p_
53k

1694804
1762336
1910676
1833924
1806288


## Model B

No zero_rtt, post_hs, adversary

### prev_
57k

1847304
1987816
1932228
1908632
1785736

### p_
53k

1881004
1916992
1858644
1917964
1842284


## Model C

No post_hs, adversary

### prev_
58k

1835172
1802216
1795260
1973148
1873884

### p_
54k

1752236
1840192
1962976
1937500
1913840


## Model D

No record, zero_rtt, post_hs

### prev_
57k

Command exited with non-zero status 137
12020324
Command exited with non-zero status 137
12074404
Command exited with non-zero status 137
12080112
Command exited with non-zero status 137
12040712
Command exited with non-zero status 137
12023572
