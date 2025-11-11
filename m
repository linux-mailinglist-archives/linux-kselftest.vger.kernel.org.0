Return-Path: <linux-kselftest+bounces-45302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0889C4D3CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2D4FE2FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C453355045;
	Tue, 11 Nov 2025 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yCds3eaT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VnBd3g6s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5452F5A11;
	Tue, 11 Nov 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858207; cv=none; b=cLkdbLd+l5mXLXpv1RUy/Gf9T9dWkCYSUQO8Mc3TPzlFxh0RFeGJNAgcrku292kiGZwAMSoFgIYEmuUWJSl/uDvprG+A1Oc7rOKXOwzrpAlmojqQc8e1+G8FAEn2omHtbJcHy2zVMlortyMWyPa43/P0ZJnY9c6adNlBtVfElSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858207; c=relaxed/simple;
	bh=Oro3PElE1z2+SwLbrs9IOy1Jl54HgbslXfaifTttu+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qog37O/BklcQ8Jk74/GYcJ39QN2jMT3Qpe+Ke9aogboqkVmbyoFx7r5J1K39oNe8g1ewkRUv59HrTGF4wX/MlhPi0RAGoy4gUFMncscNLdUfi1tB2KLIRq65gBXHVcHCeeCdjTMuTmBmbsiVohiOwXqmz9y1Xur2/MgoDTqlD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yCds3eaT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VnBd3g6s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLMf3I4wnol8bvAcGZiyRNvvSI5dCyPel/HOEhBu/kM=;
	b=yCds3eaTxYu9ZVDZnCM+ccl8eo7YZqZ639SnYK/tLLbWyHm9yWoaU5P+ym8YVaGfDuHBW1
	R6abi62I6QA5/5M4TDdxDxMNrJVCA9P1YBHtpLTaOkgttUR9PUwVqRo6oTUg1UFv2Ys9R3
	TDng1iaYnPdXJzq0yjPHT20Tq5DsnyfzU/ug9qWZ1N9Rk3PzKTpVTGyBnAdupdF7GYvKFB
	cHGjGPfFBLofGk8kitue6MDWba99VFJdTdIxjxiI2v5RbZeZvqeoqx/bwBIZl8/qgV1iYk
	Vscg2wzZcOZK89a+rWAteXVSm4IvpEUOGf8pMnws0VAsr0sVftvj9cOXvNCqVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLMf3I4wnol8bvAcGZiyRNvvSI5dCyPel/HOEhBu/kM=;
	b=VnBd3g6sX7LF2fW413kcjSwmcgiXv3OTysHxJTCWt+3+HfCoLnW/W9mi0bMMA/9O6ixnRR
	+a24OyIYQrZQFLCA==
Date: Tue, 11 Nov 2025 11:49:54 +0100
Subject: [PATCH 08/10] selftests: vDSO: vdso_test_correctness: Use types
 from vdso_types.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-8-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=4811;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Oro3PElE1z2+SwLbrs9IOy1Jl54HgbslXfaifTttu+w=;
 b=YUPkhREmKAHa9gHF4q/tsAvb6oPs0uFxbOArhSydzE2AFmUK81W+lriuzCTMFteWPOiBgyIiX
 rgOqgdzziu2AtCb7I9gwtzX/krq3C2/8dp+rG1WUHT2QV888h22EBsG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The libc types are not necessarily compatible with the vDSO functions.

Use the dedicated types from vdso_types.h instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 .../testing/selftests/vDSO/vdso_test_correctness.c | 45 ++++++++--------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 66cd1d4c19872e78c0e608f5e0fb5215cf902b50..77bd77c32456617fc1ee240aebce57cf5b1cf89d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -7,7 +7,6 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
-#include <sys/time.h>
 #include <time.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -21,6 +20,7 @@
 
 #include "vdso_config.h"
 #include "vdso_call.h"
+#include "vdso_types.h"
 #include "../kselftest.h"
 
 static const char **name;
@@ -29,29 +29,14 @@ static const char **name;
 #define __NR_clock_gettime64	403
 #endif
 
-#ifndef __kernel_timespec
-struct __kernel_timespec {
-	long long	tv_sec;
-	long long	tv_nsec;
-};
-#endif
-
 /* max length of lines in /proc/self/maps - anything longer is skipped here */
 #define MAPS_LINE_LEN 128
 
 int nerrs = 0;
 
-typedef int (*vgettime_t)(clockid_t, struct timespec *);
-
-vgettime_t vdso_clock_gettime;
-
-typedef int (*vgettime64_t)(clockid_t, struct __kernel_timespec *);
-
-vgettime64_t vdso_clock_gettime64;
-
-typedef long (*vgtod_t)(struct timeval *tv, struct timezone *tz);
-
-vgtod_t vdso_gettimeofday;
+vdso_clock_gettime_t vdso_clock_gettime;
+vdso_clock_gettime64_t vdso_clock_gettime64;
+vdso_gettimeofday_t vdso_gettimeofday;
 
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
 
@@ -124,17 +109,17 @@ static void fill_function_pointers(void)
 
 	vgetcpu = (getcpu_t) vsyscall_getcpu();
 
-	vdso_clock_gettime = (vgettime_t)dlsym(vdso, name[1]);
+	vdso_clock_gettime = (vdso_clock_gettime_t)dlsym(vdso, name[1]);
 	if (!vdso_clock_gettime)
 		printf("Warning: failed to find clock_gettime in vDSO\n");
 
 #if defined(VDSO_32BIT)
-	vdso_clock_gettime64 = (vgettime64_t)dlsym(vdso, name[5]);
+	vdso_clock_gettime64 = (vdso_clock_gettime64_t)dlsym(vdso, name[5]);
 	if (!vdso_clock_gettime64)
 		printf("Warning: failed to find clock_gettime64 in vDSO\n");
 #endif
 
-	vdso_gettimeofday = (vgtod_t)dlsym(vdso, name[0]);
+	vdso_gettimeofday = (vdso_gettimeofday_t)dlsym(vdso, name[0]);
 	if (!vdso_gettimeofday)
 		printf("Warning: failed to find gettimeofday in vDSO\n");
 
@@ -146,17 +131,17 @@ static long sys_getcpu(unsigned * cpu, unsigned * node,
 	return syscall(__NR_getcpu, cpu, node, cache);
 }
 
-static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
+static inline int sys_clock_gettime(__kernel_clockid_t id, struct __kernel_old_timespec *ts)
 {
 	return syscall(__NR_clock_gettime, id, ts);
 }
 
-static inline int sys_clock_gettime64(clockid_t id, struct __kernel_timespec *ts)
+static inline int sys_clock_gettime64(__kernel_clockid_t id, struct __kernel_timespec *ts)
 {
 	return syscall(__NR_clock_gettime64, id, ts);
 }
 
-static inline int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
+static inline int sys_gettimeofday(struct __kernel_old_timeval *tv, struct kernel_timezone *tz)
 {
 	return syscall(__NR_gettimeofday, tv, tz);
 }
@@ -213,7 +198,7 @@ static void test_getcpu(void)
 	}
 }
 
-static bool ts_leq(const struct timespec *a, const struct timespec *b)
+static bool ts_leq(const struct __kernel_old_timespec *a, const struct __kernel_old_timespec *b)
 {
 	if (a->tv_sec != b->tv_sec)
 		return a->tv_sec < b->tv_sec;
@@ -230,7 +215,7 @@ static bool ts64_leq(const struct __kernel_timespec *a,
 		return a->tv_nsec <= b->tv_nsec;
 }
 
-static bool tv_leq(const struct timeval *a, const struct timeval *b)
+static bool tv_leq(const struct __kernel_old_timeval *a, const struct __kernel_old_timeval *b)
 {
 	if (a->tv_sec != b->tv_sec)
 		return a->tv_sec < b->tv_sec;
@@ -255,7 +240,7 @@ static char const * const clocknames[] = {
 
 static void test_one_clock_gettime(int clock, const char *name)
 {
-	struct timespec start, vdso, end;
+	struct __kernel_old_timespec start, vdso, end;
 	int vdso_ret, end_ret;
 
 	printf("[RUN]\tTesting clock_gettime for clock %s (%d)...\n", name, clock);
@@ -379,8 +364,8 @@ static void test_clock_gettime64(void)
 
 static void test_gettimeofday(void)
 {
-	struct timeval start, vdso, end;
-	struct timezone sys_tz, vdso_tz;
+	struct __kernel_old_timeval start, vdso, end;
+	struct kernel_timezone sys_tz, vdso_tz;
 	int vdso_ret, end_ret;
 
 	if (!vdso_gettimeofday)

-- 
2.51.0


