Return-Path: <linux-kselftest+bounces-6728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CB988EE78
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 19:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F562A310A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F4114F9C2;
	Wed, 27 Mar 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Sj231z6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAD12E1ED;
	Wed, 27 Mar 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565180; cv=none; b=ccOVaWbKgpYGiVEjWhzW7rSAySMtMSuR0BGynINR8F+bcCUcgFQzf/tloPiSOO1iZvKWVyqBxuk66Jm3Q97dMyfd9yqpao0nZHNdlc6Wz4I2vOlcmhIapG2L8rJC3slzrTEciLNUgmNP6gGRhtHEKJ3q4UfCYlFqxAIIvjLqowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565180; c=relaxed/simple;
	bh=hA8bnZwmtW9gQsBN2ACnuDeOZ+pP/IpACBBf0FApIvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JI3L/xRJeMa85JXzJQhNLJyOtdG6OHJ5w9+8+7QMM2HAMibR9Wp9YHmtQ3pcHyS2tugny+KjErhsfLtABX5V5r4opLme1IqV6cvn5UQHqkYDefMat8fQul2FBkYzxJuLm4+MdSaAQ+OI4XKoagpMkXwST/dU0Sy3mMQlpFo8ASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Sj231z6C; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711565176;
	bh=hA8bnZwmtW9gQsBN2ACnuDeOZ+pP/IpACBBf0FApIvY=;
	h=From:To:Cc:Subject:Date:From;
	b=Sj231z6CcvtfEm5GQZYfgtKr6usPFO2VL8J8nIuqZWbbqu9SlwGmc8YHHqjhP44td
	 EBxitbHCy7VZ3oDA2eD85cCbAvUzTh3Z51BjssVTUlVHZUefweWR5vKAoCx2v3Q5Ww
	 FwkXApKTwTrpPkRYm8cjtoSAOqRstafUtiLF1JLKVbudReIe+Jo6dzv42S7NPFkY0I
	 Yf+4L4OJaco00ekJ2gvemj2j/Ie6FU96RyRg8hErQPPndSHw1KEsrLsYMDFv1JzEzx
	 kz+kA2F2ytjv/JFSAzO78quGHr5XyQ/9BBJeP7z1Svn6ivbsGG+kIegxcEQKjK0Tk/
	 RdlSvsFC1aaqQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A97EB3782112;
	Wed, 27 Mar 2024 18:46:13 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] selftests: x86: test_vsyscall: reorder code to reduce #ifdef blocks
Date: Wed, 27 Mar 2024 23:46:34 +0500
Message-Id: <20240327184637.3915969-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple #ifdef blocks inside functions where they return just
0 if #ifdef is false. This makes number of tests counting difficult.
Move those functions inside one #ifdef block and move all of them
together. This is preparatory patch for next patch to convert this into
TAP format. So in this patch, we are just moving functions around
without any changes.

With and without this patch, the output of this patch is same.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/test_vsyscall.c | 176 +++++++++-----------
 1 file changed, 83 insertions(+), 93 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 47cab972807c4..c78b0648aa524 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -21,6 +21,7 @@
 #include <sys/uio.h>
 
 #include "helpers.h"
+#include "../kselftest.h"
 
 #ifdef __x86_64__
 # define VSYS(x) (x)
@@ -39,18 +40,6 @@
 /* max length of lines in /proc/self/maps - anything longer is skipped here */
 #define MAPS_LINE_LEN 128
 
-static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-		       int flags)
-{
-	struct sigaction sa;
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_sigaction = handler;
-	sa.sa_flags = SA_SIGINFO | flags;
-	sigemptyset(&sa.sa_mask);
-	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
-}
-
 /* vsyscalls and vDSO */
 bool vsyscall_map_r = false, vsyscall_map_x = false;
 
@@ -96,64 +85,6 @@ static void init_vdso(void)
 		printf("[WARN]\tfailed to find getcpu in vDSO\n");
 }
 
-static int init_vsys(void)
-{
-#ifdef __x86_64__
-	int nerrs = 0;
-	FILE *maps;
-	char line[MAPS_LINE_LEN];
-	bool found = false;
-
-	maps = fopen("/proc/self/maps", "r");
-	if (!maps) {
-		printf("[WARN]\tCould not open /proc/self/maps -- assuming vsyscall is r-x\n");
-		vsyscall_map_r = true;
-		return 0;
-	}
-
-	while (fgets(line, MAPS_LINE_LEN, maps)) {
-		char r, x;
-		void *start, *end;
-		char name[MAPS_LINE_LEN];
-
-		/* sscanf() is safe here as strlen(name) >= strlen(line) */
-		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
-			   &start, &end, &r, &x, name) != 5)
-			continue;
-
-		if (strcmp(name, "[vsyscall]"))
-			continue;
-
-		printf("\tvsyscall map: %s", line);
-
-		if (start != (void *)0xffffffffff600000 ||
-		    end != (void *)0xffffffffff601000) {
-			printf("[FAIL]\taddress range is nonsense\n");
-			nerrs++;
-		}
-
-		printf("\tvsyscall permissions are %c-%c\n", r, x);
-		vsyscall_map_r = (r == 'r');
-		vsyscall_map_x = (x == 'x');
-
-		found = true;
-		break;
-	}
-
-	fclose(maps);
-
-	if (!found) {
-		printf("\tno vsyscall map in /proc/self/maps\n");
-		vsyscall_map_r = false;
-		vsyscall_map_x = false;
-	}
-
-	return nerrs;
-#else
-	return 0;
-#endif
-}
-
 /* syscalls */
 static inline long sys_gtod(struct timeval *tv, struct timezone *tz)
 {
@@ -176,17 +107,6 @@ static inline long sys_getcpu(unsigned * cpu, unsigned * node,
 	return syscall(SYS_getcpu, cpu, node, cache);
 }
 
-static jmp_buf jmpbuf;
-static volatile unsigned long segv_err;
-
-static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
-{
-	ucontext_t *ctx = (ucontext_t *)ctx_void;
-
-	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
-	siglongjmp(jmpbuf, 1);
-}
-
 static double tv_diff(const struct timeval *a, const struct timeval *b)
 {
 	return (double)(a->tv_sec - b->tv_sec) +
@@ -396,9 +316,33 @@ static int test_getcpu(int cpu)
 	return nerrs;
 }
 
+#ifdef __x86_64__
+
+static jmp_buf jmpbuf;
+static volatile unsigned long segv_err;
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+
+	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
+	siglongjmp(jmpbuf, 1);
+}
+
 static int test_vsys_r(void)
 {
-#ifdef __x86_64__
 	printf("[RUN]\tChecking read access to the vsyscall page\n");
 	bool can_read;
 	if (sigsetjmp(jmpbuf, 1) == 0) {
@@ -420,14 +364,12 @@ static int test_vsys_r(void)
 		printf("[OK]\tWe do not have read access: #PF(0x%lx)\n",
 		       segv_err);
 	}
-#endif
 
 	return 0;
 }
 
 static int test_vsys_x(void)
 {
-#ifdef __x86_64__
 	if (vsyscall_map_x) {
 		/* We already tested this adequately. */
 		return 0;
@@ -454,8 +396,6 @@ static int test_vsys_x(void)
 		       segv_err);
 		return 1;
 	}
-#endif
-
 	return 0;
 }
 
@@ -472,7 +412,6 @@ static int test_vsys_x(void)
  */
 static int test_process_vm_readv(void)
 {
-#ifdef __x86_64__
 	char buf[4096];
 	struct iovec local, remote;
 	int ret;
@@ -504,12 +443,63 @@ static int test_process_vm_readv(void)
 		printf("[FAIL]\tprocess_rm_readv() succeeded, but it should have failed in this configuration\n");
 		return 1;
 	}
-#endif
-
 	return 0;
 }
 
-#ifdef __x86_64__
+static int init_vsys(void)
+{
+	int nerrs = 0;
+	FILE *maps;
+	char line[MAPS_LINE_LEN];
+	bool found = false;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) {
+		printf("[WARN]\tCould not open /proc/self/maps -- assuming vsyscall is r-x\n");
+		vsyscall_map_r = true;
+		return 0;
+	}
+
+	while (fgets(line, MAPS_LINE_LEN, maps)) {
+		char r, x;
+		void *start, *end;
+		char name[MAPS_LINE_LEN];
+
+		/* sscanf() is safe here as strlen(name) >= strlen(line) */
+		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
+			   &start, &end, &r, &x, name) != 5)
+			continue;
+
+		if (strcmp(name, "[vsyscall]"))
+			continue;
+
+		printf("\tvsyscall map: %s", line);
+
+		if (start != (void *)0xffffffffff600000 ||
+		    end != (void *)0xffffffffff601000) {
+			printf("[FAIL]\taddress range is nonsense\n");
+			nerrs++;
+		}
+
+		printf("\tvsyscall permissions are %c-%c\n", r, x);
+		vsyscall_map_r = (r == 'r');
+		vsyscall_map_x = (x == 'x');
+
+		found = true;
+		break;
+	}
+
+	fclose(maps);
+
+	if (!found) {
+		printf("\tno vsyscall map in /proc/self/maps\n");
+		vsyscall_map_r = false;
+		vsyscall_map_x = false;
+	}
+
+	return nerrs;
+}
+
 static volatile sig_atomic_t num_vsyscall_traps;
 
 static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
@@ -559,20 +549,20 @@ int main(int argc, char **argv)
 	int nerrs = 0;
 
 	init_vdso();
+#ifdef __x86_64__
 	nerrs += init_vsys();
+#endif
 
 	nerrs += test_gtod();
 	nerrs += test_time();
 	nerrs += test_getcpu(0);
 	nerrs += test_getcpu(1);
 
+#ifdef __x86_64__
 	sethandler(SIGSEGV, sigsegv, 0);
 	nerrs += test_vsys_r();
 	nerrs += test_vsys_x();
-
 	nerrs += test_process_vm_readv();
-
-#ifdef __x86_64__
 	nerrs += test_emulation();
 #endif
 
-- 
2.39.2


