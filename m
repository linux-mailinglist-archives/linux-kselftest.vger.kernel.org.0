Return-Path: <linux-kselftest+bounces-36695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD092AFB623
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99A27B062F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207682DFA32;
	Mon,  7 Jul 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mpRJDZPO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cPt4+3lu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CAC2D97B0;
	Mon,  7 Jul 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898231; cv=none; b=RgfZyG5P0dbvoSKDwY5uqwgDaNRhQbmBG8ct/qQHKOthYssFynD8O20UNt3Bob+/HEAlvZpXxcYrGAc0ipiFw2AVeda88MIEBQnrgP290GrM4ZJBsBvVg2lcScl6yT5mS+C3RyDov23oFou0eZFAju7nlvog5AYqss8vIt0rmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898231; c=relaxed/simple;
	bh=s4skLLJfopoH2TWuLw68jE7DlOUR1hAhAHbxjOf1rD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tM330s0PSn8nSDt5KMZqaD08XkbYjF8qYMnKBdHLRgkaBZiupGkvifEPpC2aXZx7WQxu32dIOKPV6cQ0N2i65n6tc5L+xseXalv+tGP4r7tkqJNSLTa/8xPMJ4ZYM+ZyIke+5KOvkUIM8ljyR1RrwLXhkYIjtKMxrN7vehD2FXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mpRJDZPO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cPt4+3lu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751898226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pq7ctUq5bHh87KWv51A0aETgmBc6Ve8Sl/O21M03X6U=;
	b=mpRJDZPO50o4vLQGEJyB0M8/8hdc6gStYxDq1KdA04K6AQHDrLHTnnQKVppcDr2koFm9b8
	4BUf04l313w1JWbKQSi+QHn6p3V84rkJu7yBaf7aAWJa2OMcLgCK+o78ginBdrcuN4sMCa
	+m2Qluu1Se+KsaRz0Oh1QmazSi6n4lySVYstE+u9r4jRYcbxTJi4mRHzPulmiVFC1baksn
	i1Ljq95JE3+di26R1TmYMee30QZBvtXnBQ38GBe7JvlNUyu34bMYCiNE1Ly4NkR3h82uXH
	FIslPyJfrvbM/zWwPc4f0jq2Bu8kVQvffuX5xyM5snwM+l8UqYYrjg6+GvVTvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751898226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pq7ctUq5bHh87KWv51A0aETgmBc6Ve8Sl/O21M03X6U=;
	b=cPt4+3luq/Srfd+rPwnvWKZEYrbFquBBeM2BftCIaCESBpai6SNgXxZQxKTMpCdo5jouLx
	MJ4ev5xiGTJYUZDA==
Date: Mon, 07 Jul 2025 16:23:43 +0200
Subject: [PATCH 5/5] selftests: vDSO: Drop vdso_test_clock_getres
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-vdso-tests-fixes-v1-5-545be9781b0c@linutronix.de>
References: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
In-Reply-To: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751898221; l=4660;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=s4skLLJfopoH2TWuLw68jE7DlOUR1hAhAHbxjOf1rD4=;
 b=BdSEX7GiS3a04xCqvPsN2BEpFMTb2uoea9+n6lt+PyQCcqFtumBOIJrIZh7r1fqniCZ5KyXij
 4BbEnAPPc6xDkmGGN+F17nyHXQERyHu02GVXCnQpCCipzklH9DgWs1z
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vdso_test_abi provides the exact same functionality, properly uses
kselftest.h and explicitly calls into the vDSO without relying on the libc.

Drop the pointless testcase.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile              |   2 -
 .../selftests/vDSO/vdso_test_clock_getres.c        | 123 ---------------------
 2 files changed, 125 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 918a2caa070ebc681a9525f0518afffcf10f5ae3..e361aca22a74dc5c279ab1aa16f308b7e6e85bf1 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -4,7 +4,6 @@ include ../../../scripts/Makefile.arch
 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
 TEST_GEN_PROGS += vdso_test_abi
-TEST_GEN_PROGS += vdso_test_clock_getres
 ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
@@ -29,7 +28,6 @@ CFLAGS_NOLIBC := -nostdlib -nostdinc -ffreestanding -fno-asynchronous-unwind-tab
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
-$(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
 
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c | headers
 $(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=$(CFLAGS_NOLIBC) $(CFLAGS)
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
deleted file mode 100644
index b5d5f59f725a703c357dfca91bfe170aaaeb42fa..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ /dev/null
@@ -1,123 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
-/*
- * vdso_clock_getres.c: Sample code to test clock_getres.
- * Copyright (c) 2019 Arm Ltd.
- *
- * Compile with:
- * gcc -std=gnu99 vdso_clock_getres.c
- *
- * Tested on ARM, ARM64, MIPS32, x86 (32-bit and 64-bit),
- * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
- * Might work on other architectures.
- */
-
-#define _GNU_SOURCE
-#include <elf.h>
-#include <fcntl.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <time.h>
-#include <sys/auxv.h>
-#include <sys/mman.h>
-#include <sys/time.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-
-#include "../kselftest.h"
-
-static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
-{
-	long ret;
-
-	ret = syscall(SYS_clock_getres, _clkid, _ts);
-
-	return ret;
-}
-
-const char *vdso_clock_name[12] = {
-	"CLOCK_REALTIME",
-	"CLOCK_MONOTONIC",
-	"CLOCK_PROCESS_CPUTIME_ID",
-	"CLOCK_THREAD_CPUTIME_ID",
-	"CLOCK_MONOTONIC_RAW",
-	"CLOCK_REALTIME_COARSE",
-	"CLOCK_MONOTONIC_COARSE",
-	"CLOCK_BOOTTIME",
-	"CLOCK_REALTIME_ALARM",
-	"CLOCK_BOOTTIME_ALARM",
-	"CLOCK_SGI_CYCLE",
-	"CLOCK_TAI",
-};
-
-/*
- * This function calls clock_getres in vdso and by system call
- * with different values for clock_id.
- *
- * Example of output:
- *
- * clock_id: CLOCK_REALTIME [PASS]
- * clock_id: CLOCK_BOOTTIME [PASS]
- * clock_id: CLOCK_TAI [PASS]
- * clock_id: CLOCK_REALTIME_COARSE [PASS]
- * clock_id: CLOCK_MONOTONIC [PASS]
- * clock_id: CLOCK_MONOTONIC_RAW [PASS]
- * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
- */
-static inline int vdso_test_clock(unsigned int clock_id)
-{
-	struct timespec x, y;
-
-	printf("clock_id: %s", vdso_clock_name[clock_id]);
-	clock_getres(clock_id, &x);
-	syscall_clock_getres(clock_id, &y);
-
-	if ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)) {
-		printf(" [FAIL]\n");
-		return KSFT_FAIL;
-	}
-
-	printf(" [PASS]\n");
-	return KSFT_PASS;
-}
-
-int main(int argc, char **argv)
-{
-	int ret = 0;
-
-#if _POSIX_TIMERS > 0
-
-#ifdef CLOCK_REALTIME
-	ret += vdso_test_clock(CLOCK_REALTIME);
-#endif
-
-#ifdef CLOCK_BOOTTIME
-	ret += vdso_test_clock(CLOCK_BOOTTIME);
-#endif
-
-#ifdef CLOCK_TAI
-	ret += vdso_test_clock(CLOCK_TAI);
-#endif
-
-#ifdef CLOCK_REALTIME_COARSE
-	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
-#endif
-
-#ifdef CLOCK_MONOTONIC
-	ret += vdso_test_clock(CLOCK_MONOTONIC);
-#endif
-
-#ifdef CLOCK_MONOTONIC_RAW
-	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
-#endif
-
-#ifdef CLOCK_MONOTONIC_COARSE
-	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
-#endif
-
-#endif
-	if (ret > 0)
-		return KSFT_FAIL;
-
-	return KSFT_PASS;
-}

-- 
2.50.0


