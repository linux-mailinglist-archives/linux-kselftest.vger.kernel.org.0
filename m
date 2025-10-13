Return-Path: <linux-kselftest+bounces-42989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2958CBD23F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3982B3A5E7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A092FD7A5;
	Mon, 13 Oct 2025 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mk8V5jjm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vUXxKwrE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5822FD1C6;
	Mon, 13 Oct 2025 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347244; cv=none; b=FCL2AXv0xwQmOeJX/mzOm/0GGwZa6fHyO3+GJO7AzKxSG4UxovIfie7vlwVcYmuZASeTFhBvtm6xEyv4mUSJk/QLL9H0BwbUzi7aWwdTGtzPnz8tPd8IbouPw6WPJSyCEVbt56sr/REb8BfUNcR/ODiLerLCaPFs7Idd2GLfyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347244; c=relaxed/simple;
	bh=bsnyaBeSRCe8wdPqrrv1bwhb+qpEBLlt2hQJjqswvoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iaIbUZRKImAXH1DUVMZM/jWAmQEg0TWCYuUqBhwyeSaRPq03QAxIiADm4R42jyipI8mhCO50lXPpLJ4/nAm2HF/5i908pICeCvq9FjpRur6EMhvWOvFw1QmfOzEAzKSmzoSW5Wa1r5+su79P/rVUvvD9hnLotaDWj0ngXVett5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mk8V5jjm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vUXxKwrE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760347238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YnHubzJu3Fgrg1zOT2N2oDqGxJhZGnOAfIAFA8L12bY=;
	b=mk8V5jjm9bjj/lAkYcJXLhq9kWnFEMuMqKTt5xMAfvc6r7I25XQWZiI0Gyrj9LJ6UEuFsS
	WhyEkJvj/FRcpITMyC7oMcXIR4ekUB5ijreDbz62kiwTawP9JM7Tj22HxuCx1mXTaFvY7a
	dJL/8r4ERZrH9ey8Op9ZqdRWXYXMDEkKsaxFX9HoLqMccXMC6j0eWD+WJ2NwEfCoDpJE8P
	8T1ris271l+Ix9eZhFht6y7mcsl/ho4Ml7ldcbDCz5XNTsOhbJD1ICYW6d/g3ueeDqwiG/
	cd53pLgexzGqbabCZMBGVrx4VmiH28i/cR9DYoqhPh20YYqDLV3mtIbK75ANaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760347238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YnHubzJu3Fgrg1zOT2N2oDqGxJhZGnOAfIAFA8L12bY=;
	b=vUXxKwrEAA6590TvF2FstxFKP8ixkPKIzOBbz2gBqmCDoZtEpCWNq87GBUWg8/VXdy20Hc
	iSOeNa9IIfXcJ5Bg==
Date: Mon, 13 Oct 2025 11:20:37 +0200
Subject: [PATCH v2] vdso: Remove struct getcpu_cache
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGTE7GgC/1XMywqDMBCF4VeRWTfFibfQle9RpNg4moESJYlik
 bx7U6GLLv8D5zvAk2PycMsOcLSx59mmkJcMtOntRIKH1CBzWeVKVmKioJf1oXttSBT9Uw+S6qo
 sGkiXxdHI+8ndu9SGfZjd+9Q3/K4/qP6HNhQoVFOqAtVYY4nti+0a3Gx5vw4EXYzxAyTRuUCsA
 AAA
X-Change-ID: 20250825-getcpu_cache-3abcd2e65437
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760347238; l=10000;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bsnyaBeSRCe8wdPqrrv1bwhb+qpEBLlt2hQJjqswvoc=;
 b=htz+rIY3Hjtp1zl5kTi7ZVfgPQIb5MdOf2GL1NX2IOZxp5tyYiW4lMozgo3f4yL2dBq1J66kz
 lbkSRPPmIm/DtfVUa1j6yjutkcRFu8uuar9HdPD+gYKPvsRzxupRV/P
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The cache parameter of getcpu() is not used by the kernel and no user
ever passes it in anyways.

Remove the struct and its header.

As a side-effect we get rid of an unwanted inclusion of the linux/
header namespace from vDSO code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase on v6.18-rc1
- Link to v1: https://lore.kernel.org/r/20250826-getcpu_cache-v1-1-8748318f6141@linutronix.de
---
We could also completely remove the parameter, but I am not sure if
that is a good idea for syscalls and vDSO entrypoints.
---
 arch/loongarch/vdso/vgetcpu.c                   |  5 ++---
 arch/s390/kernel/vdso64/getcpu.c                |  3 +--
 arch/s390/kernel/vdso64/vdso.h                  |  4 +---
 arch/x86/entry/vdso/vgetcpu.c                   |  5 ++---
 arch/x86/include/asm/vdso/processor.h           |  4 +---
 arch/x86/um/vdso/um_vdso.c                      |  7 +++----
 include/linux/getcpu.h                          | 19 -------------------
 include/linux/syscalls.h                        |  3 +--
 kernel/sys.c                                    |  4 +---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c |  4 +---
 10 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 5301cd9d0f839eb0fd7b73a1d36e80aaa75d5e76..aefba899873ed035d70766a95b0b6fea881e94df 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -4,7 +4,6 @@
  */
 
 #include <asm/vdso.h>
-#include <linux/getcpu.h>
 
 static __always_inline int read_cpu_id(void)
 {
@@ -20,8 +19,8 @@ static __always_inline int read_cpu_id(void)
 }
 
 extern
-int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
-int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused);
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
 {
 	int cpu_id;
 
diff --git a/arch/s390/kernel/vdso64/getcpu.c b/arch/s390/kernel/vdso64/getcpu.c
index 5c5d4a848b7669436e73df8e3b711e5b876eb3db..1e17665616c5fa766ca66c8de276b212528934bd 100644
--- a/arch/s390/kernel/vdso64/getcpu.c
+++ b/arch/s390/kernel/vdso64/getcpu.c
@@ -2,11 +2,10 @@
 /* Copyright IBM Corp. 2020 */
 
 #include <linux/compiler.h>
-#include <linux/getcpu.h>
 #include <asm/timex.h>
 #include "vdso.h"
 
-int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
+int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, void *unused)
 {
 	union tod_clock clk;
 
diff --git a/arch/s390/kernel/vdso64/vdso.h b/arch/s390/kernel/vdso64/vdso.h
index 9e5397e7b590a23c149ccc6043d0c0b0d5ea8457..cadd307d7a365cabf53f5c8d313be3718625533d 100644
--- a/arch/s390/kernel/vdso64/vdso.h
+++ b/arch/s390/kernel/vdso64/vdso.h
@@ -4,9 +4,7 @@
 
 #include <vdso/datapage.h>
 
-struct getcpu_cache;
-
-int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);
+int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, void *unused);
 int __s390_vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 int __s390_vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 int __s390_vdso_clock_getres(clockid_t clock, struct __kernel_timespec *ts);
diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index e4640306b2e3c95d74d73037ab6b09294b8e1d6c..6381b472b7c52487bccf3cbf0664c3d7a0e59699 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -6,17 +6,16 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/getcpu.h>
 #include <asm/segment.h>
 #include <vdso/processor.h>
 
 notrace long
-__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned *cpu, unsigned *node, void *unused)
 {
 	vdso_read_cpunode(cpu, node);
 
 	return 0;
 }
 
-long getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+long getcpu(unsigned *cpu, unsigned *node, void *tcache)
 	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vdso/processor.h
index 7000aeb59aa287e2119c3d43ab3eaf82befb59c4..93e0e24e5cb47f7b0056c13f2a7f2304ed4a0595 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -18,9 +18,7 @@ static __always_inline void cpu_relax(void)
 	native_pause();
 }
 
-struct getcpu_cache;
-
-notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);
+notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused);
 
 #endif /* __ASSEMBLER__ */
 
diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124fd0ff0f9d240c33fefb8d213c84cd..9aa2c62cce6b7a07bbaf8441014d347162d1950d 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -10,14 +10,13 @@
 #define DISABLE_BRANCH_PROFILING
 
 #include <linux/time.h>
-#include <linux/getcpu.h>
 #include <asm/unistd.h>
 
 /* workaround for -Wmissing-prototypes warnings */
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
-long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
+long __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
@@ -60,7 +59,7 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
-__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
 {
 	/*
 	 * UML does not support SMP, we can cheat here. :)
@@ -74,5 +73,5 @@ __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused
 	return 0;
 }
 
-long getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
+long getcpu(unsigned int *cpu, unsigned int *node, void *tcache)
 	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/include/linux/getcpu.h b/include/linux/getcpu.h
deleted file mode 100644
index c304dcdb4eac2a9117080e6a14f4e3f28d07fd56..0000000000000000000000000000000000000000
--- a/include/linux/getcpu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_GETCPU_H
-#define _LINUX_GETCPU_H 1
-
-/* Cache for getcpu() to speed it up. Results might be a short time
-   out of date, but will be faster.
-
-   User programs should not refer to the contents of this structure.
-   I repeat they should not refer to it. If they do they will break
-   in future kernels.
-
-   It is only a private cache for vgetcpu(). It will change in future kernels.
-   The user program must store this information per thread (__thread)
-   If you want 100% accurate information pass NULL instead. */
-struct getcpu_cache {
-	unsigned long blob[128 / sizeof(long)];
-};
-
-#endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 66c06fcdfe19e27b99eb9a187c22e022e260802f..403488e5eba906ecf40975fc3cb29ed0402491f2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -59,7 +59,6 @@ struct compat_stat;
 struct old_timeval32;
 struct robust_list_head;
 struct futex_waitv;
-struct getcpu_cache;
 struct old_linux_dirent;
 struct perf_event_attr;
 struct file_handle;
@@ -714,7 +713,7 @@ asmlinkage long sys_getrusage(int who, struct rusage __user *ru);
 asmlinkage long sys_umask(int mask);
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
-asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
+asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, void __user *cache);
 asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
diff --git a/kernel/sys.c b/kernel/sys.c
index 8b58eece4e580b883d19bb1336aff627ae783a4d..f1780ab132a3fbce6aac937ade5b9a35d9837f13 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -31,7 +31,6 @@
 #include <linux/tty.h>
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
-#include <linux/getcpu.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/seccomp.h>
 #include <linux/cpu.h>
@@ -2876,8 +2875,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	return error;
 }
 
-SYSCALL_DEFINE3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep,
-		struct getcpu_cache __user *, unused)
+SYSCALL_DEFINE3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep, void __user *, unused)
 {
 	int err = 0;
 	int cpu = raw_smp_processor_id();
diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index cdeaed45fb26c61f6314c58fe1b71fa0be3c0108..994ce569dc37c6689b1a3c79156e3dfc8bf27f22 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -16,9 +16,7 @@
 #include "vdso_config.h"
 #include "vdso_call.h"
 
-struct getcpu_cache;
-typedef long (*getcpu_t)(unsigned int *, unsigned int *,
-			 struct getcpu_cache *);
+typedef long (*getcpu_t)(unsigned int *, unsigned int *, void *);
 
 int main(int argc, char **argv)
 {

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250825-getcpu_cache-3abcd2e65437

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


