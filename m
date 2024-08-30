Return-Path: <linux-kselftest+bounces-16791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041CA9661B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2994B1C2384D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E291A4AB5;
	Fri, 30 Aug 2024 12:29:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A319ABCB;
	Fri, 30 Aug 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020949; cv=none; b=a6J1K8t9dRw+L2+CqBk93rMf1amKGaPiLDMYEx4CNdiZn+hDa7l8xQuQ4xHPQvs8JQ7+ob/bIZOelHt5lWWvcIFGXKDskpcQAbilBhQ4D16xkEfZSC0HUNLgu15/PETn/0SCmNlUx1/NUrRzLWF3g9eFP3nb8GBPCGjRctW1n/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020949; c=relaxed/simple;
	bh=xrGlbINGVBvgJM/LDcEw2kkqwOIJtDFCfIAAI2RVjdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/649saGe+KE3SduF/KZK5wHICq3TKoDx3ED8Y5u85J9cqS+NtwMBe5g971ld+DMOh1OZd1reTuPoELsNqyeN2Dxmgo8qEZbEyEKvu8Cc7NBlJUkW9OcsWpDhNrybqstwOOx3Xm1gDN+FkYUIRwk8kPtTkGOzosJag0fXbstW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwHWV15R8z9sSS;
	Fri, 30 Aug 2024 14:28:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQOArxBRyI0Q; Fri, 30 Aug 2024 14:28:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwHWS6MKTz9sS8;
	Fri, 30 Aug 2024 14:28:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C90588B799;
	Fri, 30 Aug 2024 14:28:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id mW29znrhoPi1; Fri, 30 Aug 2024 14:28:52 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3326E8B764;
	Fri, 30 Aug 2024 14:28:52 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@mit.edu>,
	"H. Peter Anvin" <hpa@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] selftests: vdso: Fix the way vDSO functions are called for powerpc
Date: Fri, 30 Aug 2024 14:28:38 +0200
Message-ID: <c3d4e529d69bea63961587550d9bee2224b46312.1725020674.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>
References: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725020918; l=12297; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=xrGlbINGVBvgJM/LDcEw2kkqwOIJtDFCfIAAI2RVjdA=; b=p1QQl2VqaKQJ2U8iouv1zBmnvQJldjiFfo8vcqh3vXxgXhDUakjbojE3nt6FC97KLs5P7D2R9 crsCBLxi6KFDg6EeKNMQ8oYDw1q3hBQneRlRUIxIXDaBGz6czLyy086
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

vdso_test_correctness test fails on powerpc:

~ # ./vdso_test_correctness
...
[RUN]	Testing clock_gettime for clock CLOCK_REALTIME_ALARM (8)...
[FAIL]	No such clock, but __vdso_clock_gettime returned 22
[RUN]	Testing clock_gettime for clock CLOCK_BOOTTIME_ALARM (9)...
[FAIL]	No such clock, but __vdso_clock_gettime returned 22
[RUN]	Testing clock_gettime for clock CLOCK_SGI_CYCLE (10)...
[FAIL]	No such clock, but __vdso_clock_gettime returned 22
...
[RUN]	Testing clock_gettime for clock invalid (-1)...
[FAIL]	No such clock, but __vdso_clock_gettime returned 22
[RUN]	Testing clock_gettime for clock invalid (-2147483648)...
[FAIL]	No such clock, but __vdso_clock_gettime returned 22
[RUN]	Testing clock_gettime for clock invalid (2147483647)...
[FAIL]	No such clock, but __vdso_clock_gettime returned 22

On powerpc, a call to a VDSO function is not an ordinary C function
call. Unlike several architectures which returns a negative error code
in case of an error, powerpc sets CR[SO] and returns the error code
as a positive value.

Define and use a macro called VDSO_CALL() which takes a pointer
to the function to call, the number of arguments and the arguments.

Also update ABI vdso documentation to reflect this subtlety.

Provide a specific version of VDSO_CALL() for powerpc that negates
the error code on return when CR[SO] is set.

Fixes: c7e5789b24d3 ("kselftest: Move test_vdso to the vDSO test suite")
Fixes: 2e9a97256616 ("selftests: vdso: Add a selftest for vDSO getcpu()")
Fixes: 693f5ca08ca0 ("kselftest: Extend vDSO selftest")
Fixes: b2f1c3db2887 ("kselftest: Extend vdso correctness test to clock_gettime64")
Fixes: 4920a2590e91 ("selftests/vDSO: add tests for vgetrandom")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/ABI/stable/vdso                 |  8 ++-
 tools/testing/selftests/vDSO/vdso_call.h      | 70 +++++++++++++++++++
 tools/testing/selftests/vDSO/vdso_test_abi.c  |  9 +--
 .../selftests/vDSO/vdso_test_correctness.c    | 15 ++--
 .../testing/selftests/vDSO/vdso_test_getcpu.c |  3 +-
 .../selftests/vDSO/vdso_test_getrandom.c      |  5 +-
 .../selftests/vDSO/vdso_test_gettimeofday.c   |  3 +-
 7 files changed, 95 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/vDSO/vdso_call.h

diff --git a/Documentation/ABI/stable/vdso b/Documentation/ABI/stable/vdso
index 951838d42781..85dbb6a160df 100644
--- a/Documentation/ABI/stable/vdso
+++ b/Documentation/ABI/stable/vdso
@@ -9,9 +9,11 @@ maps an ELF DSO into that program's address space.  This DSO is called
 the vDSO and it often contains useful and highly-optimized alternatives
 to real syscalls.
 
-These functions are called just like ordinary C function according to
-your platform's ABI.  Call them from a sensible context.  (For example,
-if you set CS on x86 to something strange, the vDSO functions are
+These functions are called according to your platform's ABI. On many
+platforms they are called just like ordinary C function. On other platforms
+(ex: powerpc) they are called with the same convention as system calls which
+is different from ordinary C functions. Call them from a sensible context.
+(For example, if you set CS on x86 to something strange, the vDSO functions are
 within their rights to crash.)  In addition, if you pass a bad
 pointer to a vDSO function, you might get SIGSEGV instead of -EFAULT.
 
diff --git a/tools/testing/selftests/vDSO/vdso_call.h b/tools/testing/selftests/vDSO/vdso_call.h
new file mode 100644
index 000000000000..bb237d771051
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_call.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macro to call vDSO functions
+ *
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+#ifndef __VDSO_CALL_H__
+#define __VDSO_CALL_H__
+
+#ifdef __powerpc__
+
+#define LOADARGS_1(fn, __arg1) do {					\
+	_r0 = fn;							\
+	_r3 = (long)__arg1;						\
+} while (0)
+
+#define LOADARGS_2(fn, __arg1, __arg2) do {				\
+	_r0 = fn;							\
+	_r3 = (long)__arg1;						\
+	_r4 = (long)__arg2;						\
+} while (0)
+
+#define LOADARGS_3(fn, __arg1, __arg2, __arg3) do {			\
+	_r0 = fn;							\
+	_r3 = (long)__arg1;						\
+	_r4 = (long)__arg2;						\
+	_r5 = (long)__arg3;						\
+} while (0)
+
+#define LOADARGS_5(fn, __arg1, __arg2, __arg3, __arg4, __arg5) do {	\
+	_r0 = fn;							\
+	_r3 = (long)__arg1;						\
+	_r4 = (long)__arg2;						\
+	_r5 = (long)__arg3;						\
+	_r6 = (long)__arg4;						\
+	_r7 = (long)__arg5;						\
+} while (0)
+
+#define VDSO_CALL(fn, nr, args...) ({					\
+	register void *_r0 asm ("r0");					\
+	register long _r3 asm ("r3");					\
+	register long _r4 asm ("r4");					\
+	register long _r5 asm ("r5");					\
+	register long _r6 asm ("r6");					\
+	register long _r7 asm ("r7");					\
+	register long _r8 asm ("r8");					\
+	register long _rval asm ("r3");					\
+									\
+	LOADARGS_##nr(fn, args);					\
+									\
+	asm volatile(							\
+		"	mtctr %0\n"					\
+		"	bctrl\n"					\
+		"	bns+	1f\n"					\
+		"	neg	3, 3\n"					\
+		"1:"							\
+		: "+r" (_r0), "=r" (_r3), "+r" (_r4), "+r" (_r5),	\
+		  "+r" (_r6), "+r" (_r7), "+r" (_r8)			\
+		: "r" (_rval)						\
+		: "r9", "r10", "r11", "r12", "cr0", "cr1", "cr5",	\
+		  "cr6", "cr7", "xer", "lr", "ctr", "memory"		\
+	);								\
+	_rval;								\
+})
+
+#else
+#define VDSO_CALL(fn, nr, args...)	fn(args)
+#endif
+
+#endif
diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 96d32fd65b42..00034208c4c6 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -20,6 +20,7 @@
 
 #include "../kselftest.h"
 #include "vdso_config.h"
+#include "vdso_call.h"
 
 extern void *vdso_sym(const char *version, const char *name);
 extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
@@ -61,7 +62,7 @@ static void vdso_test_gettimeofday(void)
 	}
 
 	struct timeval tv;
-	long ret = vdso_gettimeofday(&tv, 0);
+	long ret = VDSO_CALL(vdso_gettimeofday, 2, &tv, 0);
 
 	if (ret == 0) {
 		ksft_print_msg("The time is %lld.%06lld\n",
@@ -86,7 +87,7 @@ static void vdso_test_clock_gettime(clockid_t clk_id)
 	}
 
 	struct timespec ts;
-	long ret = vdso_clock_gettime(clk_id, &ts);
+	long ret = VDSO_CALL(vdso_clock_gettime, 2, clk_id, &ts);
 
 	if (ret == 0) {
 		ksft_print_msg("The time is %lld.%06lld\n",
@@ -111,7 +112,7 @@ static void vdso_test_time(void)
 		return;
 	}
 
-	long ret = vdso_time(NULL);
+	long ret = VDSO_CALL(vdso_time, 1, NULL);
 
 	if (ret > 0) {
 		ksft_print_msg("The time in hours since January 1, 1970 is %lld\n",
@@ -138,7 +139,7 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 	}
 
 	struct timespec ts, sys_ts;
-	long ret = vdso_clock_getres(clk_id, &ts);
+	long ret = VDSO_CALL(vdso_clock_getres, 2, clk_id, &ts);
 
 	if (ret == 0) {
 		ksft_print_msg("The vdso resolution is %lld %lld\n",
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index cdb697ae8343..5fb97ad67eea 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -20,6 +20,7 @@
 #include <limits.h>
 
 #include "vdso_config.h"
+#include "vdso_call.h"
 #include "../kselftest.h"
 
 static const char **name;
@@ -186,7 +187,7 @@ static void test_getcpu(void)
 
 		ret_sys = sys_getcpu(&cpu_sys, &node_sys, 0);
 		if (vdso_getcpu)
-			ret_vdso = vdso_getcpu(&cpu_vdso, &node_vdso, 0);
+			ret_vdso = VDSO_CALL(vdso_getcpu, 3, &cpu_vdso, &node_vdso, 0);
 		if (vgetcpu)
 			ret_vsys = vgetcpu(&cpu_vsys, &node_vsys, 0);
 
@@ -269,7 +270,7 @@ static void test_one_clock_gettime(int clock, const char *name)
 
 	if (sys_clock_gettime(clock, &start) < 0) {
 		if (errno == EINVAL) {
-			vdso_ret = vdso_clock_gettime(clock, &vdso);
+			vdso_ret = VDSO_CALL(vdso_clock_gettime, 2, clock, &vdso);
 			if (vdso_ret == -EINVAL) {
 				printf("[OK]\tNo such clock.\n");
 			} else {
@@ -282,7 +283,7 @@ static void test_one_clock_gettime(int clock, const char *name)
 		return;
 	}
 
-	vdso_ret = vdso_clock_gettime(clock, &vdso);
+	vdso_ret = VDSO_CALL(vdso_clock_gettime, 2, clock, &vdso);
 	end_ret = sys_clock_gettime(clock, &end);
 
 	if (vdso_ret != 0 || end_ret != 0) {
@@ -331,7 +332,7 @@ static void test_one_clock_gettime64(int clock, const char *name)
 
 	if (sys_clock_gettime64(clock, &start) < 0) {
 		if (errno == EINVAL) {
-			vdso_ret = vdso_clock_gettime64(clock, &vdso);
+			vdso_ret = VDSO_CALL(vdso_clock_gettime64, 2, clock, &vdso);
 			if (vdso_ret == -EINVAL) {
 				printf("[OK]\tNo such clock.\n");
 			} else {
@@ -344,7 +345,7 @@ static void test_one_clock_gettime64(int clock, const char *name)
 		return;
 	}
 
-	vdso_ret = vdso_clock_gettime64(clock, &vdso);
+	vdso_ret = VDSO_CALL(vdso_clock_gettime64, 2, clock, &vdso);
 	end_ret = sys_clock_gettime64(clock, &end);
 
 	if (vdso_ret != 0 || end_ret != 0) {
@@ -401,7 +402,7 @@ static void test_gettimeofday(void)
 		return;
 	}
 
-	vdso_ret = vdso_gettimeofday(&vdso, &vdso_tz);
+	vdso_ret = VDSO_CALL(vdso_gettimeofday, 2, &vdso, &vdso_tz);
 	end_ret = sys_gettimeofday(&end, NULL);
 
 	if (vdso_ret != 0 || end_ret != 0) {
@@ -431,7 +432,7 @@ static void test_gettimeofday(void)
 	}
 
 	/* And make sure that passing NULL for tz doesn't crash. */
-	vdso_gettimeofday(&vdso, NULL);
+	VDSO_CALL(vdso_gettimeofday, 2, &vdso, NULL);
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index b758f68c6c9c..cdeaed45fb26 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -14,6 +14,7 @@
 #include "../kselftest.h"
 #include "parse_vdso.h"
 #include "vdso_config.h"
+#include "vdso_call.h"
 
 struct getcpu_cache;
 typedef long (*getcpu_t)(unsigned int *, unsigned int *,
@@ -42,7 +43,7 @@ int main(int argc, char **argv)
 		return KSFT_SKIP;
 	}
 
-	ret = get_cpu(&cpu, &node, 0);
+	ret = VDSO_CALL(get_cpu, 3, &cpu, &node, 0);
 	if (ret == 0) {
 		printf("Running on CPU %u node %u\n", cpu, node);
 	} else {
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 05122425a873..94aa1cffde52 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -21,6 +21,7 @@
 
 #include "../kselftest.h"
 #include "parse_vdso.h"
+#include "vdso_call.h"
 
 #ifndef timespecsub
 #define	timespecsub(tsp, usp, vsp)					\
@@ -120,7 +121,7 @@ static void vgetrandom_init(void)
 		printf("__vdso_getrandom is missing!\n");
 		exit(KSFT_FAIL);
 	}
-	if (grnd_ctx.fn(NULL, 0, 0, &grnd_ctx.params, ~0UL) != 0) {
+	if (VDSO_CALL(grnd_ctx.fn, 5, NULL, 0, 0, &grnd_ctx.params, ~0UL) != 0) {
 		printf("failed to fetch vgetrandom params!\n");
 		exit(KSFT_FAIL);
 	}
@@ -143,7 +144,7 @@ static ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
 			exit(KSFT_FAIL);
 		}
 	}
-	return grnd_ctx.fn(buf, len, flags, state, grnd_ctx.params.size_of_opaque_state);
+	return VDSO_CALL(grnd_ctx.fn, 5, buf, len, flags, state, grnd_ctx.params.size_of_opaque_state);
 }
 
 enum { TRIALS = 25000000, THREADS = 256 };
diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index ee4f1ca56a71..e31b18ffae33 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -19,6 +19,7 @@
 #include "../kselftest.h"
 #include "parse_vdso.h"
 #include "vdso_config.h"
+#include "vdso_call.h"
 
 int main(int argc, char **argv)
 {
@@ -43,7 +44,7 @@ int main(int argc, char **argv)
 	}
 
 	struct timeval tv;
-	long ret = gtod(&tv, 0);
+	long ret = VDSO_CALL(gtod, 2, &tv, 0);
 
 	if (ret == 0) {
 		printf("The time is %lld.%06lld\n",
-- 
2.44.0


