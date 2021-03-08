from collections import Counter
import string

print("Exalton HTB Challenge Solution")

#password found in unpacked UPX binary; compared with user input; likely encoded
encoded_password="1152 1344 1056 1968 1728 816 1648 784 1584 816 1728 1520 1840 1664 784 1632 1856 1520 1728 816 1632 1856 1520 784 1760 1840 1824 816 1584 1856 784 1776 1760 528 528 2000";

print("\nEncoded Password: \n\t",encoded_password, "\n")

#split and sort the encoded chars
encoded_chars = encoded_password.split(' ')

#undo the << 4 
decoded = [chr(int(i) >> 4) for i in encoded_chars]

print("Decoded password:\n", "".join(decoded))
