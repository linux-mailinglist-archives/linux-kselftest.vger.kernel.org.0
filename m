Return-Path: <linux-kselftest+bounces-38758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854EBB21D01
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B259A682F97
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D12E4265;
	Tue, 12 Aug 2025 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19LHLuI6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzX/yQmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359692E2835;
	Tue, 12 Aug 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977162; cv=none; b=UH1ddt3Mhqthm298CV3dFbIcP+he2dls91gNke5v6Zr1i9QSVj2J2lPZ+HUSYpDe4xKYmqHXJdG0kF3CT45T8gc9nJhrCSnpHhyUVrfIEY3sxK+OdTYv9TRZZjtuJcdsWLD2ousCw0SanpDI6+iZOoA79OQEHOXLTl4K8VZXjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977162; c=relaxed/simple;
	bh=02daXCIbkRjNKoy/vay068lu47laZjYbudY0loa/xcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uud8h5tXazocJXjMgrS9xpxwoze6vTZd+mrTpSfPin7Qbge1+Pr5FptjqEzSAS9G6SyPxLaih8cxmzZ64WES5VDJxQztTq+C6RiWX89yV2hAMPAkX2/NORW1uc/oEOV0Cxk1IdwaICySI0emeT53tHaDaS3F6hJlaA3sKQfcm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=19LHLuI6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzX/yQmT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoV3x/XJg/ANc0lHinJVW2aC441y0iz7f+A5Ef+AT6Q=;
	b=19LHLuI6tVonRzXepH1HJoekuFoQ2pUv7xdk+UeMQ+IUWxe0Q1RHQiPZPnPxh7RekdxT6L
	7xChZISs5PoaJfDrUXX/xyGi4LUS7IW4giJ6gozkJXZsImFU67C57ycgTn8broAia8wA3r
	SjBWRvOC6d8YDG/KlGaPeLgQM0z4u8EWomg4xoJAqrH0ku6dLd6fCF7RjtrVkMktWsjiZs
	XsDXCwQCWweq/yTjNTdqqASgJLwA2mQbbRX0UT/+1vt8ZJ2sHpAq5saLCwz0AACm6HwiVR
	fmu/FwwbSPB8hZZfCNeTd8Mo/WESjwSUqDrvqZCKXB2Dxm8gGps2QOezEwzmCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoV3x/XJg/ANc0lHinJVW2aC441y0iz7f+A5Ef+AT6Q=;
	b=bzX/yQmTGgcj7BYfGJJqCJo1Xh2OAJVyxJ5gjsJ6m4kUa7fXmrbzkadySm8CniqOBtZp9a
	EnLmUhD++kdHDkBQ==
Date: Tue, 12 Aug 2025 07:39:09 +0200
Subject: [PATCH v2 8/8] selftests: vDSO: Drop vdso_test_clock_getres
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-tests-fixes-v2-8-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
In-Reply-To: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=5188;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=02daXCIbkRjNKoy/vay068lu47laZjYbudY0loa/xcc=;
 b=r7ieb+PVA8N9MszaJgXwJQj2Si1r3jimKm+R3hw8TlT82AZpsq/nx10e6uUqW3++1ihCS8/oy
 NS+KZ7MKu/9A3DIdaeuv2bJ4K/maWONWHEqj2S5rc/V4asG2vnBfLR3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vdso_test_abi provides the exact same functionality, properly uses
kselftest.h and explicitly calls into the vDSO without relying on the libc.

Drop the pointless testcase.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/.gitignore            |   1 -
 tools/testing/selftests/vDSO/Makefile              |   2 -
 .../selftests/vDSO/vdso_test_clock_getres.c        | 123 ---------------------
 3 files changed, 126 deletions(-)

diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index 30d5c8f0e5c7dfe9a330e440801aeac7e19faea9..ba322a353aff14eb3e951294e3604378eec2b14c 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vdso_test
 vdso_test_abi
-vdso_test_clock_getres
 vdso_test_correctness
 vdso_test_gettimeofday
 vdso_test_getcpu
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
2.50.1


