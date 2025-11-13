Return-Path: <linux-kselftest+bounces-45562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FBDC587F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28EE8360636
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F7A357A53;
	Thu, 13 Nov 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="skwbFSod";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fU+7sjRf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539CC3570B0;
	Thu, 13 Nov 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047878; cv=none; b=ggsdx0oACMrqe1hRRWhP5PW32HWUOEoNqDV4A4V1GDMNzZxl1wIAtALgXpN95+oUIIlPTkpOwOdOovrCWTsFM3su+TyuT40AGelO0II6+GmXU6f2GnpHDZDzE8qo3N4sDJnbjPiQjyEIL1aWJ1imU07d7yLK8i/EzdXIBRvWo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047878; c=relaxed/simple;
	bh=tY9DN2SUv82NrViCPQmv/VBRBqsvVDFw04Mj21smQY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jm2KR41bfySLYo+jrNJdhIBD9e+TYf9jssDXM8u9wWjX77T7Bbe7hYGdYnUNGHia3lyPk/25lQi4yrkqvkDcxl98R1oUaw4e80jKJ+pdo+5g14Va/C2oXeOJGeZCx2R6cyoMxwcNzuzhaLdbIBE+gOPAeXK65rDFrXvc+SX1/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=skwbFSod; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fU+7sjRf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWkuvyexKAL9zkJaKecsm5/FPgL2CY5qnocQcUmqwFY=;
	b=skwbFSod4+08MuuyFUU8zqJGu8iReJ9NUnNN7I2tgX1X9q0N5+SRu7uISlmOUxV1eJQLa/
	ExvPxEcvqxLUP2TqJ0AZQ9SQDjdeSCHZYpUEWxs9jccpQTIzzkARj7GZ4THl4XGLEnDMua
	qZ43+1Dx1xsSMZOLgPSTKqTyeAI+UwBgpkg0F2BeFUaxGGAQbtztd4oSaEtmyjH+HJ1vdv
	BTnebr4fzrV8rRS+bECua3LnZWdJrLYjAkGWuqL64L7Ckeqil4L6HA8ztHj7nMSnuD5cfk
	9kq2qyZruJ7uNrnT/iIGeWKQul1oDO1NqNR5P1T3LJmvon1StnIC015pYymYHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWkuvyexKAL9zkJaKecsm5/FPgL2CY5qnocQcUmqwFY=;
	b=fU+7sjRffHOxHjxw9YTkQ6EYRu5d7fxex/VTTdBVaRXwU0wvZ8fjT5kPNeMYdRshq9T3ws
	hwBmtK1+ci8Me9Ag==
Date: Thu, 13 Nov 2025 16:30:28 +0100
Subject: [PATCH v2 12/14] selftests: vDSO: vdso_test_correctness: Use
 system call wrappers from vdso_syscalls.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-12-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=3603;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tY9DN2SUv82NrViCPQmv/VBRBqsvVDFw04Mj21smQY8=;
 b=EZVSO9ciO4fY5Kaz2/z11hM1t1srBYjU5Lq/azx43ptEbWWSQHzcd/SOYdJtjgRcIF4gA7e+j
 Ps4E5LIg0ymCv6WPstfezMf8Gj/nokF4ZUK4SbFH+hNvMnWiu3P/hu8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Using syscall() is problematic for the reasons outlined in vdso_syscalls.h.

Use the wrappers from the utility header instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 .../testing/selftests/vDSO/vdso_test_correctness.c | 34 ++++++----------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 276446d24f55d6b28910320e3d601bac501c2ca1..ac5fa3e906806c28d3238e6f4e767e370932c5d1 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -20,6 +20,7 @@
 
 #include "vdso_config.h"
 #include "vdso_call.h"
+#include "vdso_syscalls.h"
 #include "vdso_types.h"
 #include "../kselftest.h"
 
@@ -131,21 +132,6 @@ static long sys_getcpu(unsigned * cpu, unsigned * node,
 	return syscall(__NR_getcpu, cpu, node, cache);
 }
 
-static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
-{
-	return syscall(__NR_clock_gettime, id, ts);
-}
-
-static inline int sys_clock_gettime64(clockid_t id, struct __kernel_timespec *ts)
-{
-	return syscall(__NR_clock_gettime64, id, ts);
-}
-
-static inline int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
-{
-	return syscall(__NR_gettimeofday, tv, tz);
-}
-
 static void test_getcpu(void)
 {
 	printf("[RUN]\tTesting getcpu...\n");
@@ -237,8 +223,8 @@ static char const * const clocknames[] = {
 
 static void test_one_clock_gettime(int clock, const char *name)
 {
+	struct __kernel_timespec start, end;
 	struct __kernel_old_timespec vdso;
-	struct timespec start, end;
 	int vdso_ret, end_ret;
 
 	printf("[RUN]\tTesting clock_gettime for clock %s (%d)...\n", name, clock);
@@ -269,9 +255,9 @@ static void test_one_clock_gettime(int clock, const char *name)
 	}
 
 	printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
-	       (unsigned long long)start.tv_sec, start.tv_nsec,
-	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
-	       (unsigned long long)end.tv_sec, end.tv_nsec);
+	       (unsigned long long)start.tv_sec, (unsigned long)start.tv_nsec,
+	       (unsigned long long)vdso.tv_sec, (unsigned long)vdso.tv_nsec,
+	       (unsigned long long)end.tv_sec, (unsigned long)end.tv_nsec);
 
 	if (!ts_leq(&start, &vdso) || !ts_leq(&vdso, &end)) {
 		printf("[FAIL]\tTimes are out of sequence\n");
@@ -305,7 +291,7 @@ static void test_one_clock_gettime64(int clock, const char *name)
 
 	printf("[RUN]\tTesting clock_gettime64 for clock %s (%d)...\n", name, clock);
 
-	if (sys_clock_gettime64(clock, &start) < 0) {
+	if (sys_clock_gettime(clock, &start) < 0) {
 		if (errno == EINVAL) {
 			vdso_ret = VDSO_CALL(vdso_clock_gettime64, 2, clock, &vdso);
 			if (vdso_ret == -EINVAL) {
@@ -321,7 +307,7 @@ static void test_one_clock_gettime64(int clock, const char *name)
 	}
 
 	vdso_ret = VDSO_CALL(vdso_clock_gettime64, 2, clock, &vdso);
-	end_ret = sys_clock_gettime64(clock, &end);
+	end_ret = sys_clock_gettime(clock, &end);
 
 	if (vdso_ret != 0 || end_ret != 0) {
 		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
@@ -362,10 +348,8 @@ static void test_clock_gettime64(void)
 
 static void test_gettimeofday(void)
 {
-	struct __kernel_old_timeval vdso;
-	struct kernel_timezone vdso_tz;
-	struct timeval start, end;
-	struct timezone sys_tz;
+	struct __kernel_old_timeval start, vdso, end;
+	struct kernel_timezone vdso_tz, sys_tz;
 	int vdso_ret, end_ret;
 
 	if (!vdso_gettimeofday)

-- 
2.51.0


