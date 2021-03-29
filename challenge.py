#!/usr/bin/python3
import os

def printable_hex(string):
    hexx = ''.join('\\x{:02x}'.format(letter) for letter in string)
    return hexx

print("---------------------------------------------------------")
print("Reading ./flag.txt ...")
flag = open('flag.txt', 'r').read().strip()
print("  flag[txt]: ", flag)
flag = bytearray.fromhex(flag)
print("  flag[hex]: ", printable_hex(flag))
print("  flag[bytes]: ",flag)
print("---------------------------------------------------------")


class XOR:
    def __init__(self, key):
        self.key = key
    def encrypt(self, data: bytes) -> bytes:
        xored = b''
        for i in range(len(data)):
            xored += bytes([data[i] ^ self.key[i % len(self.key)]])
        return xored
    def decrypt(self, data: bytes) -> bytes:
        return self.encrypt(data)


def find_crib_key():

    known_plaintext = "HTB{".encode()
    known_bytes = bytes(known_plaintext)
    len_bytes = len(known_bytes)
    encrypted_bytes = flag[:len_bytes]

    key_bytes = []
    for i in range(len_bytes):
       known = known_bytes[i]
       unknown = encrypted_bytes[i]
       #print(known ," XOR ", unknown, " = ", known ^ unknown)
       key_bytes.append(int(known ^ unknown))
    
    key = ''.join('\\x{:02x}'.format(letter) for letter in key_bytes)
    
    print("---------------------------------------------------------")
    print("Finding XOR key using known plaintext (crib)...")
    print("Known plaintext: ", known_plaintext)
    print("Known hex: ", printable_hex(known_bytes))
    print("Ciphertext: ", encrypted_bytes)
    print("Cipher hex: ", printable_hex(encrypted_bytes))
    print("Found key!: ", key)
    print("---------------------------------------------------------")

    return key


def main():
    global flag
    #key = os.urandom(4)
    
    plain_key = find_crib_key()    
    key = bytearray.fromhex(plain_key.replace("\\x", ""))
    
    crypto = XOR(key)
    decrypted = crypto.decrypt(flag)
    
    print("---------------------------------------------------------")
    print ('Encrypted Flag: ', flag)
    print ('Decrypted Flag: ', decrypted)
    print ("Key: ", plain_key)
    print("---------------------------------------------------------")


if __name__ == '__main__':
        main()
