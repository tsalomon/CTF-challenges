#include <stdio.h>

void print_xor(char *in)

{
  int index1;
  char *var;
  
  index1 = 0;
  var = in;
  while ((*var != '\t' && (index1 < 0x14))) {
    putchar((int)(char)(*var ^ 9));
    var = var + 1;
    index1 = index1 + 1;
  }
  putchar(10);
  return;
}

char buffer[20];
char local_48 = 0x41;
char local_47 = 0x5d;
char local_46 = 0x4b;
char local_45 = 0x72;
char local_44 = 0x3d;
char local_43 = 0x39;
char local_42 = 0x6b;
char local_41 = 0x30;
char local_40 = 0x3d;
char local_3f = 0x30;
char local_3e = 0x6f;
char local_3d = 0x30;
char local_3c = 0x3b;
char local_3b = 0x6b;
char local_3a = 0x31;
char local_39 = 0x3f;
char local_38 = 0x6b;
char local_37 = 0x38;
char local_36 = 0x31;
char local_35 = 0x74;

int main()
{
    printf("Testing...\n");
    print_xor(&local_48);
    return 0;
}
