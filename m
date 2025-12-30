Return-Path: <linux-kselftest+bounces-48004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC91ECE8D9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 08:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A95300E17E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72312DCF70;
	Tue, 30 Dec 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hbSXx+ct";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpa+StPU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9B13957E;
	Tue, 30 Dec 2025 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767078529; cv=none; b=kBQ50h8FyxdWwaYAHlBuhARR7WMCAWXLH5HGZvuz/S/rDif+LEaKmE45y4KPn+pNiUgAi7UMr4cn6j94wHCOMQyVTIFdJHarcFpUTdJ0BvuK14zLrwl+SBs3L9Q9SNABe1cJfi5HfTVil4Escd7y18dGbZAE4fPX54Ypb1BhJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767078529; c=relaxed/simple;
	bh=psbRv4/BzsjXAHvYF9kNmUhvkyV7GOIlg/7MADMvZOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rtqK1chgzmCw/rBMpG56pc8MNDxFVHFPk44qdJT4SoKMWdl2u0ne97AC+b1h369/+xcB3QjTp9oSTqLLDifLAKMwzeZmdgikURlhh4e/gcg3rPMvFIxP+ZGoG1XTIsMui2GOyJnLT9Guthri+m0BuLzBEyfSU8na/u766Y09LSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hbSXx+ct; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpa+StPU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767078526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vXA8bfIazvy8HGJCSAI6zsjcs5XRieIDjOVpIGo8jXI=;
	b=hbSXx+cty+AYz08PzNOpdbthvKGmek2wj+rvU2FPNz0UksNiy16xoOzAPVOhMyQ2eXhl4R
	7XFL5nkeXQxO6MkObpRF0msNlejUAAsYvSiZ+SxCVUzNwmnzztvSsGMbjs6wKXJc2S9907
	KmC5VQneO1+BLYztjXAujoToAu1i95KzmbJ33TGn+OyQDrTbbk/+cSco8Ac7WMC0T2QFkk
	Ahv3Ly9hD8qVtlssPufaDKmjjiXLTfn4mkFsneHPpbRrCT/wZyPv6tW2h62qlCHwF81gNV
	OpiNpKrfQXqFUsxUdZ9YhTgY5DDFkGTbRPlSe+kKqBDk3cXUqPc0uPLUvOm6fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767078526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vXA8bfIazvy8HGJCSAI6zsjcs5XRieIDjOVpIGo8jXI=;
	b=cpa+StPUh28SS7vTDty5NACA5hWraBr7JfqdWwV+rwHtEON+5p8YgBIy1mxcaCxqQYMr6Q
	cadVyCAsw43+iUCA==
Date: Tue, 30 Dec 2025 08:08:44 +0100
Subject: [PATCH v3] vdso: Remove struct getcpu_cache
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251230-getcpu_cache-v3-1-fb9c5f880ebe@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHt6U2kC/13MywqDMBCF4VcpWTclk3gJXfU9SikxTnSgqCQaL
 OK7Nwot1OV/4HwLC+gJA7ueFuYxUqC+S6HOJ2Zb0zXIqU7NpJC50DLnDY52mJ7W2Ba5MpWtJRZ
 5pkqWLoNHR/PO3R+pWwpj79+7HmFbv1DxD0XgwHWZaQXaFZDB7UXdNPq+o/lSI9uwKH8ACFAHQ
 G6AFq5yRlWltUdgXdcP9BrP5e0AAAA=
X-Change-ID: 20250825-getcpu_cache-3abcd2e65437
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767078525; l=8287;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=psbRv4/BzsjXAHvYF9kNmUhvkyV7GOIlg/7MADMvZOg=;
 b=BVKcoXP2BGcToxxDIO9G6B/hNSvzMKXWiDvCE3tm0ubOfZnXnVRbVrmyRdwM1XBNC7X9GBXtV
 eumqqBww/XbCIWh15mdA3R5StG4o0qU/+ZVcE3b7OxxuqTxHQyiPZo2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The cache parameter of getcpu() is useless nowadays for various reasons.
* It is never passed by userspace for either the vDSO or syscalls.
* It is never used by the kernel.
* It could not be made to work on the current vDSO architecture.
* The structure definition is not part of the UAPI headers.
* vdso_getcpu() is superseded by restartable sequences in any case.

Remove the struct and its header.

As a side-effect we get rid of an unwanted inclusion of the linux/
header namespace from vDSO code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Rebase on v6.19-rc1
  - Fix conflict with UML vdso_getcpu() removal
- Flesh out commit message
- Link to v2: https://lore.kernel.org/r/20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de

Changes in v2:
- Rebase on v6.18-rc1
- Link to v1: https://lore.kernel.org/r/20250826-getcpu_cache-v1-1-8748318f6141@linutronix.de
---
We could also completely remove the parameter, but I am not sure if
that is a good idea for syscalls and vDSO entrypoints.
---
 arch/loongarch/vdso/vgetcpu.c                   |  5 ++---
 arch/s390/kernel/vdso/getcpu.c                  |  3 +--
 arch/s390/kernel/vdso/vdso.h                    |  4 +---
 arch/x86/entry/vdso/vgetcpu.c                   |  5 ++---
 arch/x86/include/asm/vdso/processor.h           |  4 +---
 include/linux/getcpu.h                          | 19 -------------------
 include/linux/syscalls.h                        |  3 +--
 kernel/sys.c                                    |  4 +---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c |  4 +---
 9 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 73af49242ecd..6f054ec898c7 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -4,7 +4,6 @@
  */
 
 #include <asm/vdso.h>
-#include <linux/getcpu.h>
 
 static __always_inline int read_cpu_id(void)
 {
@@ -28,8 +27,8 @@ static __always_inline int read_cpu_id(void)
 }
 
 extern
-int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
-int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused);
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
 {
 	int cpu_id;
 
diff --git a/arch/s390/kernel/vdso/getcpu.c b/arch/s390/kernel/vdso/getcpu.c
index 5c5d4a848b76..1e17665616c5 100644
--- a/arch/s390/kernel/vdso/getcpu.c
+++ b/arch/s390/kernel/vdso/getcpu.c
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
 
diff --git a/arch/s390/kernel/vdso/vdso.h b/arch/s390/kernel/vdso/vdso.h
index 8cff033dd854..1fe52a6f5a56 100644
--- a/arch/s390/kernel/vdso/vdso.h
+++ b/arch/s390/kernel/vdso/vdso.h
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
index e4640306b2e3..6381b472b7c5 100644
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
index 7000aeb59aa2..93e0e24e5cb4 100644
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
 
diff --git a/include/linux/getcpu.h b/include/linux/getcpu.h
deleted file mode 100644
index c304dcdb4eac..000000000000
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
index cf84d98964b2..23704e006afd 100644
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
@@ -718,7 +717,7 @@ asmlinkage long sys_getrusage(int who, struct rusage __user *ru);
 asmlinkage long sys_umask(int mask);
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
-asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
+asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, void __user *cache);
 asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
diff --git a/kernel/sys.c b/kernel/sys.c
index 8b58eece4e58..f1780ab132a3 100644
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
index bea8ad54da11..3fe49cbdae98 100644
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
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250825-getcpu_cache-3abcd2e65437

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


