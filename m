Return-Path: <linux-kselftest+bounces-45561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED45DC58947
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB0E54F05A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC93357A4A;
	Thu, 13 Nov 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhCKUchz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gkOaMGeZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7235505C;
	Thu, 13 Nov 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047878; cv=none; b=Yqzf+LrDXYT6yNmFBWICiJy9yMs/FnTR8XvWXNCx+xJWSD7n0iakPl5LdglQiSxMbjjyYxIczPh2FqoLQQAtNktYLZy4nw/N3v5JY7qLCEdYy9MwHq+alBZ9zk3/QHLQYyH+Lzi0rhfOY7HR7Zqc2oY8YeHOVdK1tizT1129UGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047878; c=relaxed/simple;
	bh=uJOJhxejWK+Gv4jZ7aDxLph4kD0E0+67toIKhnu+YDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5e+9vb0WN6ENgb7/aMOj0RN+NmCvjXXRK5+alniwg8Qryzy/ZQR3voNhMtJ4KFGjj6Fv/XUiN4QBmsxRkRhmZWddH5z5+3Nma7ehduULxRSZetk6hTK1RxqnOVC5U9c29QJfN8uMqPJ0GrCMVCV9hhJ5P9OQwm1Y2VTmFO7mKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhCKUchz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gkOaMGeZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P30dBWA1MyC64IghHW8goqGFaOreNlbVUgKkpBmt6C8=;
	b=VhCKUchzW2jkYo2IElLPHEuGXMGqfgUNjhOn3H4j8jhZ1KDk6vcNLPaGEn2QLu+4mXphek
	AZWIszH8/X4p+wLYqngBQTLsp3+EfLq0YHPAOdKC7FBYIgYP3myBLoDpnB0HNwTKnZ5aou
	7NTQT1+5sSrnz3YVVjetjhSq0a1fgmF/3xnCDwJkzJAAf9HKaMTsbxt3YnDJ1GvkZ/O+SJ
	8nC6NPlM7xriJWGOIZTZvUYxzx3sbfEzEGcnqyk0Pluv2U8KS/G4kbouop58a5ufKvVKQs
	pCyznRBD/bkfr5zDS7RMBkAti9Z3J0NqNcZ0xZw+AoN8aizOrm+M6EDQPG8abA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P30dBWA1MyC64IghHW8goqGFaOreNlbVUgKkpBmt6C8=;
	b=gkOaMGeZxPabUKW71HBAwLSgJpm6Hso1r5Hq+2/X5gyICgFP82Ubzmv4DoHBC/HugS09E2
	0K8fFIoTmlnKsaCQ==
Date: Thu, 13 Nov 2025 16:30:27 +0100
Subject: [PATCH v2 11/14] selftests: vDSO: vdso_test_correctness: Use types
 from vdso_types.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-11-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=3377;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uJOJhxejWK+Gv4jZ7aDxLph4kD0E0+67toIKhnu+YDw=;
 b=pANw5TIVGG8yGHh7JW3+43+Pphgf/H1YSMHKMeY5iLFIjrPLmRuZydx8LEmB8gs+mTH0Q6uBT
 k+Frb1vKJxRDLbC/nizllijtqAKGpSao8VCZJ5iVE80BFQOoA+GjExf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The libc types are not necessarily compatible with the vDSO functions.

Use the dedicated types from vdso_types.h instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 .../testing/selftests/vDSO/vdso_test_correctness.c | 38 ++++++++--------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 5a127fc93e7368cbe8d9fb4a4482a6a735ffd46c..276446d24f55d6b28910320e3d601bac501c2ca1 100644
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
 
@@ -252,7 +237,8 @@ static char const * const clocknames[] = {
 
 static void test_one_clock_gettime(int clock, const char *name)
 {
-	struct timespec start, vdso, end;
+	struct __kernel_old_timespec vdso;
+	struct timespec start, end;
 	int vdso_ret, end_ret;
 
 	printf("[RUN]\tTesting clock_gettime for clock %s (%d)...\n", name, clock);
@@ -376,8 +362,10 @@ static void test_clock_gettime64(void)
 
 static void test_gettimeofday(void)
 {
-	struct timeval start, vdso, end;
-	struct timezone sys_tz, vdso_tz;
+	struct __kernel_old_timeval vdso;
+	struct kernel_timezone vdso_tz;
+	struct timeval start, end;
+	struct timezone sys_tz;
 	int vdso_ret, end_ret;
 
 	if (!vdso_gettimeofday)

-- 
2.51.0


