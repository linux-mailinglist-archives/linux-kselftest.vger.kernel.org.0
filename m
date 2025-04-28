Return-Path: <linux-kselftest+bounces-31772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26CA9F102
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063103A1BC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB526D4F9;
	Mon, 28 Apr 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q8B4CDMZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bB3L6gSJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B126B09F;
	Mon, 28 Apr 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844016; cv=none; b=nM/wCu2yRgpjyilQpBuaK1skuBu3a9jW1KhI/iUk+8QeMBQvpFgyXLsfQfvx8j0/2667aRoLchcJq6pCPorOd9ZcK98IqJ6ObLk2roLlRrxD+wErphUfdCUIKwZi7G8wF04EHVr4dr5zQrzW51PrUoB24E3okKHTkSCTv3nHVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844016; c=relaxed/simple;
	bh=DzFtg3UDqBFeItEsUzo9Ww6n9EDXJhOOJUAQyvCiWL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCeio32V+HJT3xha3EgMsbjZOmn5KGoUaeqpmKeuepPQU3LcEg3Sg4tLeOGeLn1PVJRNfkUoGaDioJHLFB01FOrR9PX3BAB0sG2+XHD/OR2fXsvUOwnYAhROT/6KsRie0UOjSqBpZLqbrROMlecuTuaM+a19R6hajaS88zTLMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q8B4CDMZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bB3L6gSJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+nyq/bw7RYw7/i1fLMy0Z8JgRIiodFsEkUIDTIZCgU=;
	b=q8B4CDMZcYAc3rYuNJXxMI3+0PWICpzgZIGiXCz6YmpzT31nIs1CytcoI6+gt0DWEssRM1
	1BWuhOmB1pX1FhxRupw2uikPtQ7IxRrEWJvV6AcsjQFgVdWItaz4WrkjeB0FsjU1snQp0q
	1DT4rnc7dmOOTetPjz1alwX35fEtbrxEcX7W79SqSGkGBuHvO03gwG6BA8GPTbRbBk7zJU
	OHDEAmwnnC4ODBjJo93Gh7KkRt1FDGS7CTwt+YgeoVKUWz6uvGd4u7a/znkResUiODCewe
	NYmeVjdo8CauUuoODcmYV1eG0NP8EX1jOKfdk+1CXjzUKzZld7+lKypEoFinnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+nyq/bw7RYw7/i1fLMy0Z8JgRIiodFsEkUIDTIZCgU=;
	b=bB3L6gSJ/BBTWuyGvLGaOGIhnpvlUz59x3Ti6kwKnyTVYOipXM5Its/Bb/a2tFf3GR8C5S
	Xn88QGzaR77toeDA==
Date: Mon, 28 Apr 2025 14:40:06 +0200
Subject: [PATCH v2 05/15] tools/nolibc: add getrandom()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-5-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=4087;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DzFtg3UDqBFeItEsUzo9Ww6n9EDXJhOOJUAQyvCiWL0=;
 b=drp+gnpMUFga268e6kUY4Sjn8nSqU/lBPNW1lOgtTLZY+1FIsw/KeoW9uW54CoFoPqBX35Xly
 Tp4quOyDrx8DEJvtyDo+AfTRx1HvVagGLV04AID8S+h5UfYAIGcSTjU
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/random.h            | 34 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 22 ++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 41ef18872a7e9435a5efec9c0b32b9e29fcd4ce8..4bbe3b7fa2805f356d9a5cc1e4a8ee55b05af746 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -47,6 +47,7 @@ all_files := \
 		sys.h \
 		sys/auxv.h \
 		sys/mman.h \
+		sys/random.h \
 		sys/stat.h \
 		sys/syscall.h \
 		sys/time.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index d1b949e094eeb7cc0fe875deeafa4c972ecf35b2..3f329feb379c4c808d2e56fbb2b7a6c4b08a7c0d 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -98,6 +98,7 @@
 #include "sys.h"
 #include "sys/auxv.h"
 #include "sys/mman.h"
+#include "sys/random.h"
 #include "sys/stat.h"
 #include "sys/syscall.h"
 #include "sys/time.h"
diff --git a/tools/include/nolibc/sys/random.h b/tools/include/nolibc/sys/random.h
new file mode 100644
index 0000000000000000000000000000000000000000..8d9749f1c84572ab07c6dc70f331583063266eaf
--- /dev/null
+++ b/tools/include/nolibc/sys/random.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * random definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
+#ifndef _NOLIBC_SYS_RANDOM_H
+#define _NOLIBC_SYS_RANDOM_H
+
+#include "../arch.h"
+#include "../sys.h"
+
+#include <linux/random.h>
+
+/*
+ * ssize_t getrandom(void *buf, size_t buflen, unsigned int flags);
+ */
+
+static __attribute__((unused))
+ssize_t sys_getrandom(void *buf, size_t buflen, unsigned int flags)
+{
+       return my_syscall3(__NR_getrandom, buf, buflen, flags);
+}
+
+static __attribute__((unused))
+ssize_t getrandom(void *buf, size_t buflen, unsigned int flags)
+{
+       return __sysret(sys_getrandom(buf, buflen, flags));
+}
+
+#endif /* _NOLIBC_SYS_RANDOM_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index abe0ae794208762f6d91ad81e902fbf77253a1c1..df1cb3e62564f1fa78c55740f7c2403b8390168f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -20,6 +20,7 @@
 #include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
+#include <sys/random.h>
 #include <sys/reboot.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
@@ -807,6 +808,26 @@ static int test_dirent(void)
 	return 0;
 }
 
+int test_getrandom(void)
+{
+	uint64_t rng = 0;
+	ssize_t ret;
+
+	ret = getrandom(&rng, sizeof(rng), GRND_NONBLOCK);
+	if (ret == -1 && errno == EAGAIN)
+		return 0; /* No entropy available yet */
+
+	if (ret != sizeof(rng))
+		return ret;
+
+	if (!rng) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	return 0;
+}
+
 int test_getpagesize(void)
 {
 	int x = getpagesize();
@@ -1124,6 +1145,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(directories);       EXPECT_SYSZR(proc, test_dirent()); break;
+		CASE_TEST(getrandom);         EXPECT_SYSZR(1, test_getrandom()); break;
 		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
 		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;

-- 
2.49.0


