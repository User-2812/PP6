# PP6

## Goal

In this exercise you will:

* Learn how to produce text output to the terminal in four different environments:

  1. **Bash** shell scripting
  2. **GNU Assembler** (GAS) using system calls
  3. **C** via the standard library
  4. **Python 3** using built‑in printing functions

**Important:** Start a stopwatch when you begin and work uninterruptedly for **90 minutes**. When time is up, stop immediately and record exactly where you paused.

---

> **⚠️ WARNING:** The **workflow** steps have been **updated** for PP6. Please review the new workflow below carefully before proceeding.

## Workflow

1. **Fork** this repository on GitHub
2. **Clone** your fork to your local machine
3. Create a **solutions** directory at the repository root: `mkdir solutions`
4. For each task, add your solution file into `./solutions/` (e.g., `[solutions/print.sh](./solutions/print.sh)`)
5. **Commit** your changes locally, then **push** to GitHub
6. **Submit** your GitHub repository link for review

---

## Prerequisites

* Several starter repos are available here:
  [https://github.com/orgs/STEMgraph/repositories?q=SSH%3A](https://github.com/orgs/STEMgraph/repositories?q=SSH%3A)

---

> **Note:** Place all your solution files under the `solutions/` directory in your cloned repo.

## Tasks

### Task 1: Bash Printing & Shell Prompt

**Objective:** Use both `echo` and `printf` to format and display text and variables, and customize your shell prompt and login/logout messages.

1. In `./solutions/`, create a file named `print.sh` based on the template below.
2. At the top of `print.sh`, add the shebang:

   ```bash
   #!/usr/bin/env bash
   ```
3. Implement at least three functions:

   * `print_greeting`: prints `Hello from Bash!` using `echo`.
   * `print_vars`: declares two variables (e.g., `name="Bash"`, `version=5.1") and prints them with `printf\` using format specifiers.
   * `print_escape`: demonstrates escape sequences: newline (`\n`), tab (`\t`), and ANSI color codes (e.g., `\e[32m` for green).
4. Make the script executable and verify it runs:

   ```bash
   chmod +x solutions/print.sh
   ./solutions/print.sh
   ```
5. Modify your **`~/.bashrc`** on your local machine to:

   * Change the `PS1` prompt to include your username and current directory (e.g., `export PS1="[\u@\h \W]\$ "`).
   * Display a **welcome** message on login (e.g., `echo "Welcome, $(whoami)!"`).
   * Display a **goodbye** message on logout (add a `trap` for `EXIT` to echo `Goodbye!`).
6. Reload your shell (`source ~/.bashrc`) and demonstrate the prompt, greeting, and exit message.

**Template for `solutions/print.sh`**

```bash
#!/usr/bin/env bash

print_greeting() {
    # TODO: echo "Hello from Bash!"
}

print_vars() {
    local name="Bash"
    local version=5.1
    # TODO: printf "Using %s version %.1f\n" "$name" "$version"
}

print_escape() {
    # TODO: printf "This is a newline:\nThis is a tab:\tDone!\n"
    # TODO: printf "\e[32mGreen text\e[0m and normal text\n"
}

# Call your functions:
print_greeting
print_vars
print_escape
```

**Solution Reference**
Place your completed `print.sh` in `solutions/` and commit. Then link it here:

```
[print.sh](https://github.com/User-2812/PP6/tree/master/solutions)
```

#### Reflection Questions

1. **What is the difference between `printf` and `echo` in Bash?**
    Wird echo verwendet, btaucht man \n nicht. Bei printf hingegend schon.
2. **What is the role of `~/.bashrc` in your shell environment?**
    ~/bashrc ist der "Boot-Ordner" es wird beim starten des Terminals ausgeführt.
3. **Explain the difference between sourcing (`source ~/.bashrc`) and executing (`./print.sh`).**
    Source ~/.bashrc führt die Datei in der Aktuellen shell aus, wohingegend ./print.sh einen eigenen "Bereich" öffnet.     


---

### Task 2: GAS Printing (32‑bit Linux)

**Objective:** Use the Linux `sys_write` and `sys_exit` system calls in GAS to write text, while ensuring your repo only contains source files.

1. At the repository root, create a file named `.gitignore` that ignores:

   * Object files (`*.o`)
   * Binaries/executables (e.g., `print`, `print_c`)
   * Any editor or OS-specific files
     Commit this `.gitignore` file.
     **Explain:** Why should compiled artifacts and binaries not be committed to a Git repository?
2. In `./solutions/`, create a file named `print.s` using the template below.
3. Define a message in the `.data` section (e.g., `msg: .ascii "Hello from GAS!\n"`, `len = . - msg`).
4. In the `.text` section’s `_start` symbol, invoke `sys_write` (syscall 4) and then `sys_exit` (syscall 1) via `int $0x80`.
5. Assemble and link in 32‑bit mode:

   ```bash
   as --32 -o print.o solutions/print.s
   ld -m elf_i386 -o print print.o
   ```
6. Run `./print` and verify it outputs your message.

**Template for `solutions/print.s`**

```asm
    .section .data
msg:    .ascii "Hello from GAS!\n"
len = . - msg

    .section .text
    .global _start
_start:
    movl $4, %eax        # sys_write
    movl $1, %ebx        # stdout
    movl $msg, %ecx
    movl $len, %edx
    int $0x80

    movl $1, %eax        # sys_exit
    movl $0, %ebx        # status 0
    int $0x80
```

**Solution Reference**

```
[print.s](https://github.com/User-2812/PP6/blob/master/solutions/print.s)
```

#### Reflection Questions

1. **What is a file descriptor and how does the OS use it?**
2. **How can you obtain or duplicate a file descriptor for another resource (e.g., a file or socket)?**
3. **What might happen if you use an invalid file descriptor in a syscall?**

---

### Task 3: C Printing

**Objective:** Use `printf` and `puts` from `<stdio.h>` to display formatted data.

1. In `./solutions/`, create `print.c` based on the template below.
2. Implement `main()` to print a greeting, an integer, a float, and a string via `printf`, then use `puts`.
3. Compile and run:

   ```bash
   gcc -std=c11 -Wall -o print_c solutions/print.c
   ./print_c
   ```

**Template for `solutions/print.c`**

```c
#include <stdio.h>

int main(void) {
    printf("Hello from C!\n");
    printf("Integer: %d, Float: %.2f, String: %s\n", 42, 3.14, "test");
    puts("This is puts output");
    return 0;
}
```

**Solution Reference**

```
[print.c](https://github.com/User-2812/PP6/blob/master/solutions/print.c)
```

#### Reflection Questions

1. **Use `objdump -d` on `print_c` to find the assembly instructions corresponding to your `printf` calls.**
user-2812@Desktop:~/PP6$ objdump -d print_c

print_c:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:       f3 0f 1e fa             endbr64
    1004:       48 83 ec 08             sub    $0x8,%rsp
    1008:       48 8b 05 d9 2f 00 00    mov    0x2fd9(%rip),%rax        # 3fe8 <__gmon_start__@Base>
    100f:       48 85 c0                test   %rax,%rax
    1012:       74 02                   je     1016 <_init+0x16>
    1014:       ff d0                   call   *%rax
    1016:       48 83 c4 08             add    $0x8,%rsp
    101a:       c3                      ret

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:       ff 35 92 2f 00 00       push   0x2f92(%rip)        # 3fb8 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:       ff 25 94 2f 00 00       jmp    *0x2f94(%rip)        # 3fc0 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:       0f 1f 40 00             nopl   0x0(%rax)
    1030:       f3 0f 1e fa             endbr64
    1034:       68 00 00 00 00          push   $0x0
    1039:       e9 e2 ff ff ff          jmp    1020 <_init+0x20>
    103e:       66 90                   xchg   %ax,%ax
    1040:       f3 0f 1e fa             endbr64
    1044:       68 01 00 00 00          push   $0x1
    1049:       e9 d2 ff ff ff          jmp    1020 <_init+0x20>
    104e:       66 90                   xchg   %ax,%ax

Disassembly of section .plt.got:

0000000000001050 <__cxa_finalize@plt>:
    1050:       f3 0f 1e fa             endbr64
    1054:       ff 25 9e 2f 00 00       jmp    *0x2f9e(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    105a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

Disassembly of section .plt.sec:

0000000000001060 <puts@plt>:
    1060:       f3 0f 1e fa             endbr64
    1064:       ff 25 5e 2f 00 00       jmp    *0x2f5e(%rip)        # 3fc8 <puts@GLIBC_2.2.5>
    106a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

0000000000001070 <printf@plt>:
    1070:       f3 0f 1e fa             endbr64
    1074:       ff 25 56 2f 00 00       jmp    *0x2f56(%rip)        # 3fd0 <printf@GLIBC_2.2.5>
    107a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

Disassembly of section .text:

0000000000001080 <_start>:
    1080:       f3 0f 1e fa             endbr64
    1084:       31 ed                   xor    %ebp,%ebp
    1086:       49 89 d1                mov    %rdx,%r9
    1089:       5e                      pop    %rsi
    108a:       48 89 e2                mov    %rsp,%rdx
    108d:       48 83 e4 f0             and    $0xfffffffffffffff0,%rsp
    1091:       50                      push   %rax
    1092:       54                      push   %rsp
    1093:       45 31 c0                xor    %r8d,%r8d
    1096:       31 c9                   xor    %ecx,%ecx
    1098:       48 8d 3d ca 00 00 00    lea    0xca(%rip),%rdi        # 1169 <main>
    109f:       ff 15 33 2f 00 00       call   *0x2f33(%rip)        # 3fd8 <__libc_start_main@GLIBC_2.34>
    10a5:       f4                      hlt
    10a6:       66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
    10ad:       00 00 00

00000000000010b0 <deregister_tm_clones>:
    10b0:       48 8d 3d 59 2f 00 00    lea    0x2f59(%rip),%rdi        # 4010 <__TMC_END__>
    10b7:       48 8d 05 52 2f 00 00    lea    0x2f52(%rip),%rax        # 4010 <__TMC_END__>
    10be:       48 39 f8                cmp    %rdi,%rax
    10c1:       74 15                   je     10d8 <deregister_tm_clones+0x28>
    10c3:       48 8b 05 16 2f 00 00    mov    0x2f16(%rip),%rax        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    10ca:       48 85 c0                test   %rax,%rax
    10cd:       74 09                   je     10d8 <deregister_tm_clones+0x28>
    10cf:       ff e0                   jmp    *%rax
    10d1:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)
    10d8:       c3                      ret
    10d9:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)

00000000000010e0 <register_tm_clones>:
    10e0:       48 8d 3d 29 2f 00 00    lea    0x2f29(%rip),%rdi        # 4010 <__TMC_END__>
    10e7:       48 8d 35 22 2f 00 00    lea    0x2f22(%rip),%rsi        # 4010 <__TMC_END__>
    10ee:       48 29 fe                sub    %rdi,%rsi
    10f1:       48 89 f0                mov    %rsi,%rax
    10f4:       48 c1 ee 3f             shr    $0x3f,%rsi
    10f8:       48 c1 f8 03             sar    $0x3,%rax
    10fc:       48 01 c6                add    %rax,%rsi
    10ff:       48 d1 fe                sar    $1,%rsi
    1102:       74 14                   je     1118 <register_tm_clones+0x38>
    1104:       48 8b 05 e5 2e 00 00    mov    0x2ee5(%rip),%rax        # 3ff0 <_ITM_registerTMCloneTable@Base>
    110b:       48 85 c0                test   %rax,%rax
    110e:       74 08                   je     1118 <register_tm_clones+0x38>
    1110:       ff e0                   jmp    *%rax
    1112:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
    1118:       c3                      ret
    1119:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)

0000000000001120 <__do_global_dtors_aux>:
    1120:       f3 0f 1e fa             endbr64
    1124:       80 3d e5 2e 00 00 00    cmpb   $0x0,0x2ee5(%rip)        # 4010 <__TMC_END__>
    112b:       75 2b                   jne    1158 <__do_global_dtors_aux+0x38>
    112d:       55                      push   %rbp
    112e:       48 83 3d c2 2e 00 00    cmpq   $0x0,0x2ec2(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1135:       00
    1136:       48 89 e5                mov    %rsp,%rbp
    1139:       74 0c                   je     1147 <__do_global_dtors_aux+0x27>
    113b:       48 8b 3d c6 2e 00 00    mov    0x2ec6(%rip),%rdi        # 4008 <__dso_handle>
    1142:       e8 09 ff ff ff          call   1050 <__cxa_finalize@plt>
    1147:       e8 64 ff ff ff          call   10b0 <deregister_tm_clones>
    114c:       c6 05 bd 2e 00 00 01    movb   $0x1,0x2ebd(%rip)        # 4010 <__TMC_END__>
    1153:       5d                      pop    %rbp
    1154:       c3                      ret
    1155:       0f 1f 00                nopl   (%rax)
    1158:       c3                      ret
    1159:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)

0000000000001160 <frame_dummy>:
    1160:       f3 0f 1e fa             endbr64
    1164:       e9 77 ff ff ff          jmp    10e0 <register_tm_clones>

0000000000001169 <main>:
    1169:       f3 0f 1e fa             endbr64
    116d:       55                      push   %rbp
    116e:       48 89 e5                mov    %rsp,%rbp
    1171:       48 8d 05 90 0e 00 00    lea    0xe90(%rip),%rax        # 2008 <_IO_stdin_used+0x8>
    1178:       48 89 c7                mov    %rax,%rdi
    117b:       e8 e0 fe ff ff          call   1060 <puts@plt>
    1180:       48 8b 05 d9 0e 00 00    mov    0xed9(%rip),%rax        # 2060 <_IO_stdin_used+0x60>
    1187:       48 8d 15 8b 0e 00 00    lea    0xe8b(%rip),%rdx        # 2019 <_IO_stdin_used+0x19>
    118e:       66 48 0f 6e c0          movq   %rax,%xmm0
    1193:       be fc 0a 00 00          mov    $0xafc,%esi
    1198:       48 8d 05 81 0e 00 00    lea    0xe81(%rip),%rax        # 2020 <_IO_stdin_used+0x20>
    119f:       48 89 c7                mov    %rax,%rdi
    11a2:       b8 01 00 00 00          mov    $0x1,%eax
    11a7:       e8 c4 fe ff ff          call   1070 <printf@plt>
    11ac:       48 8d 05 93 0e 00 00    lea    0xe93(%rip),%rax        # 2046 <_IO_stdin_used+0x46>
    11b3:       48 89 c7                mov    %rax,%rdi
    11b6:       e8 a5 fe ff ff          call   1060 <puts@plt>
    11bb:       b8 00 00 00 00          mov    $0x0,%eax
    11c0:       5d                      pop    %rbp
    11c1:       c3                      ret

Disassembly of section .fini:

00000000000011c4 <_fini>:
    11c4:       f3 0f 1e fa             endbr64
    11c8:       48 83 ec 08             sub    $0x8,%rsp
    11cc:       48 83 c4 08             add    $0x8,%rsp
    11d0:       c3                      ret
2. **Why is the syntax written differently from GAS assembly? Compare NASM vs. GAS notation.**


3. **How could you use `fprintf` to write output both to `stdout` and to a file instead? Provide example code.**



---

### Task 4: Python 3 Printing

**Objective:** Use Python’s `print()` function with various parameters and f‑strings.

1. In `./solutions/`, create `print.py` using the template below.
2. Implement `main()` to print a greeting, multiple values with custom `sep`/`end`, and an f‑string expression.
3. Make it executable and run:

   ```bash
   chmod +x solutions/print.py
   ./solutions/print.py
   ```

**Template for `solutions/print.py`**

```python
#!/usr/bin/env python3

def main():
    print("Hello from Python3!")
    print("A", "B", "C", sep="-", end=".\n")
    value = 2 + 2
    print(f"Two plus two equals {value}")

if __name__ == "__main__":
    main()
```

**Solution Reference**

```
[print.py](https://github.com/User-2812/PP6/blob/master/solutions/print.py)
```

#### Reflection Questions

1. **Is Python’s print behavior closer to Bash, Assembly, or C? Explain.**
Ich finde Python´s print ähnelt mehr C als Bash. Am wenigsten ähnelt es aber Assambly.  
2. **Can you inspect a Python script’s binary with `objdump`? Why or why not?**
Das Python script lässt sich nicht mit Objdump anschauen. 

---

**Remember:** Stop working after **90 minutes** and document where you stopped.
