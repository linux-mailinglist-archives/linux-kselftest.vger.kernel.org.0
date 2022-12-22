Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D349654218
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 14:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiLVNqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 08:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVNqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 08:46:38 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16891F9E2;
        Thu, 22 Dec 2022 05:46:35 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id 2D9008198C;
        Thu, 22 Dec 2022 13:46:30 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671716795;
        bh=LDvvlYG5c3kSYFfaFM3BhTe68E9j08MA7aHXPWHcB34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REmOUL+Gt9v9/UcyoayCxyiTm2KQnM0KqX0U+jR1jkbTKzODCcnGrQtTInpD40gNz
         byu6y1C/Ws3HTo7Yh943Gux36O0JQUj8kZ7dql0Ty0hszdATJj79bBUv8NFSfjvc31
         0Vwhsc+L7NdGKBFkZikGU4TiSRu7jQ850wsVeluamCKmQKhaW4/gACkhwfWPE1z3Rj
         6IDdP8e2bN2EnKneho2pQoxZWR23Juj5Mz4/GFyDeG395Dpkg78CvmsCnJTLovAjvr
         tMJaChh895nhLGuAEh+ykUP8exFamhox/dRqebm6OKJrd5DqIXHjShwCqYeZ62YE+L
         JKUT4Nv+8tN7A==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
Date:   Thu, 22 Dec 2022 20:46:15 +0700
Message-Id: <20221222134615.3535422-1-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222043452.GB29086@1wt.eu>
References: <20221222035134.3467659-1-ammar.faizi@intel.com> <20221222043452.GB29086@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 22 Dec 2022 05:34:52 +0100, Willy Tarreau wrote:
> This one relies on /proc/self/auxv, but we'll quickly run into a
> chicken-and-egg situation given that nolibc is used by init programs
> that mount /proc. Instead I think that we should modify the _start
> code to retrieve the auxv at startup and store it somewhere. This
> "somewhere" is not yet defined, but I'm thinking that it could
> deserve reserving some room in the stack to store some nolibc-defined
> information (possibly even a copy of a pointer to environ and/or errno)
> and figure a reliable and simple way to access this. Note that one way
> could also be to know that it's after the NULL that follows envp, and
> to start from environ. In fact there are plenty of ways and we just
> need to decide what's the least ugly. But once we have access to the
> auxv from the process, then we could implement a getauxval() function
> to retrieve the information you need for getpagesize().

Thanks for the great feedback!

I agree with following the @envp pointer to get the auxv. I was
trying to wire up a new function '__start' (with double underscores)
written in C that accepts @argc, @argv and @envp. Then it calls 'main'.
Then we call '__start' instead of 'main' from '_start'. This way, we
can arrange nolibc-defined data without touching Assembly much in
'__start' (before main).

But then I noticed that it wouldn't work because we may have users
who define the 'main' function differently, e.g.:

    int main(void);
    int main(int argc, char **argv);
    int main(int argc, char **argv, char **envp);

So '__start' can't call main. We still need to call the main from the
inline Assembly (from '_start').

Just a quick dirty patch to get getauxval() works on x86-64 below.
This needs more work, but at least something like this for starting:

  $ ./nolibc-test
  Running test 'syscall'
  AT_SYSINFO_EHDR = 140737354125312
  AT_HWCAP = 3219913727
  AT_PAGESZ = 4096
  AT_CLKTCK = 100
  AT_PHDR = 4194368
  AT_PHENT = 56
  AT_PHNUM = 9
  AT_BASE = 0
  AT_FLAGS = 0
  AT_ENTRY = 4199128
  AT_UID = 0
  AT_EUID = 0
  AT_GID = 0
  AT_EGID = 0
  AT_SECURE = 0
  AT_RANDOM = 140737488349065
  AT_EXECFN = 140737488351210
  AT_PLATFORM = 140737488349081

I'll probably only spare more intensive time on this after the holiday
season ends. I still check in email, but the activity will be sparse.

Signed-off-by: [Do not commit]
---

base-commit: caf5c36025ec9395c8d7c78957b016a284812d23 ("srcu: Update comment after the index flip")
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 0e1e9eb8545d..5ee945370ff5 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -199,17 +199,49 @@ struct sys_stat_struct {
  */
 __asm__ (".section .text\n"
     ".weak _start\n"
     "_start:\n"
     "pop %rdi\n"                // argc   (first arg, %rdi)
     "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
     "lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
     "xor %ebp, %ebp\n"          // zero the stack frame
     "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
+    "push %rdi\n"               // Save argc
+    "push %rsi\n"               // Save arg
+    "push %rdx\n"               // Save envp.
+    "push %rcx\n"               // Keep the 16-byte alignment
+    "call __start\n"            // Save environ and auxv
+    "pop  %rcx\n"               // Restore alignment
+    "pop  %rdx\n"               // Restore envp
+    "pop  %rsi\n"               // Restore argv
+    "pop  %rdi\n"               // Restore argc
     "call main\n"               // main() returns the status code, we'll exit with it.
     "mov %eax, %edi\n"          // retrieve exit code (32 bit)
     "mov $60, %eax\n"           // NR_exit == 60
     "syscall\n"                 // really exit
     "hlt\n"                     // ensure it does not return
     "");
 
+struct __nolibc_internal {
+	char		**envp;
+	unsigned long	*auxv;
+};
+
+static struct __nolibc_internal __nolibc_internal;
+
+/*
+ * Mark this __used__ to avoid being optimized away.
+ * Reason: Called from inline Assembly.
+ */
+static __attribute__((__used__))
+void __start(int argc, char **argv, char **envp)
+{
+	char **p = envp;
+
+	while (*p)
+		p++;
+
+	__nolibc_internal.auxv = (unsigned long *)++p;
+	__nolibc_internal.envp = envp;
+}
+
 #endif // _NOLIBC_ARCH_X86_64_H
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 3db1dd8c74ee..04bff724e056 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -12,18 +12,19 @@
 
 /* system includes */
 #include <asm/unistd.h>
 #include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
 #include <asm/mman.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
+#include <linux/auxvec.h>
 
 #include "arch.h"
 #include "errno.h"
 #include "types.h"
 
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
  * to pass a pointer to one of their instances. Each syscall exists in two
@@ -379,18 +380,49 @@ int fsync(int fd)
 
 	if (ret < 0) {
 		SET_ERRNO(-ret);
 		ret = -1;
 	}
 	return ret;
 }
 
 
+/*
+ * On success, getauxval() returns the value corresponding to type.
+ * If type is not found, 0 is returned.
+ *
+ * unsigned long getauxval(unsigned long type);
+ */
+
+static __attribute__((unused))
+unsigned long getauxval(unsigned long type)
+{
+	unsigned long *auxv = __nolibc_internal.auxv;
+
+	if (__builtin_expect(!auxv, 0))
+		return 0;
+
+	while (1) {
+		if (!auxv[0] && !auxv[1])
+			/*
+			 * We've reached the end of auxv.
+			 */
+			return 0;
+
+		if (auxv[0] == type)
+			return auxv[1];
+
+		auxv += 2;
+	}
+	__builtin_unreachable();
+}
+
+
 /*
  * int getdents64(int fd, struct linux_dirent64 *dirp, int count);
  */
 
 static __attribute__((unused))
 int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
 {
 	return my_syscall3(__NR_getdents64, fd, dirp, count);
 }
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f14f5076fb6d..bca29a952c69 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -436,30 +436,60 @@ int test_getdents64(const char *dir)
 
 	ret = getdents64(fd, (void *)buffer, sizeof(buffer));
 	err = errno;
 	close(fd);
 
 	errno = err;
 	return ret;
 }
 
+static void test_getauxval(void)
+{
+	#define PRINT_AUXVAL(KEY)				\
+	do {							\
+		printf(#KEY " = %lu\n", getauxval(KEY));	\
+	} while (0)
+
+	PRINT_AUXVAL(AT_SYSINFO_EHDR);
+	PRINT_AUXVAL(AT_HWCAP);
+	PRINT_AUXVAL(AT_PAGESZ);
+	PRINT_AUXVAL(AT_CLKTCK);
+	PRINT_AUXVAL(AT_PHDR);
+	PRINT_AUXVAL(AT_PHENT);
+	PRINT_AUXVAL(AT_PHNUM);
+	PRINT_AUXVAL(AT_BASE);
+	PRINT_AUXVAL(AT_FLAGS);
+	PRINT_AUXVAL(AT_ENTRY);
+	PRINT_AUXVAL(AT_UID);
+	PRINT_AUXVAL(AT_EUID);
+	PRINT_AUXVAL(AT_GID);
+	PRINT_AUXVAL(AT_EGID);
+	PRINT_AUXVAL(AT_SECURE);
+	PRINT_AUXVAL(AT_RANDOM);
+	PRINT_AUXVAL(AT_EXECFN);
+	PRINT_AUXVAL(AT_PLATFORM);
+	exit(0);
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
 int run_syscall(int min, int max)
 {
 	struct stat stat_buf;
 	int proc;
 	int test;
 	int tmp;
 	int ret = 0;
 	void *p1, *p2;
 
+	test_getauxval();
+
 	/* <proc> indicates whether or not /proc is mounted */
 	proc = stat("/proc", &stat_buf) == 0;
 
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; // line length
 
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
 		 */

-- 
Ammar Faizi
