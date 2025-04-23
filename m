Return-Path: <linux-kselftest+bounces-31411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702BCA98F89
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E46C8E0CCF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DD828A1CF;
	Wed, 23 Apr 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kF7MEDhP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b5BJvqys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D02857EB;
	Wed, 23 Apr 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420506; cv=none; b=CI/UNGRDwm+wqYJ3lI4TN3pXctCGD+lkTAhmazRD2oTDRCMWaSv8wWvHf/AmFfKUiqCYt5h9IYM7/RR3ONyHVnMGmYGOLBPqS3UOC3Q9i772mgPxhBrHqF8VKHfcKyHVTjoTLBc3nUGX9z4VdY5oNOTPFIqAbLTQqalg66ZxgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420506; c=relaxed/simple;
	bh=3nwM0JHeNoU0v891mo4FQH2ynggcOB+InZcti6LaMCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaZt8R84lu7FKeWTeZj2/2V3KF9a602J5FC2iupb0UomUch4Cyg1mh72CdQgLvlkvFEvRj6RbA+BdstNgipGrIDWF2F+Ne0dJvC+u0hXYYU9XdXcOKAJd44FSVZXrXHpHKd+tWLLbMq0PpFSDrIprEv82vN8blPCGEmSm0Su3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kF7MEDhP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b5BJvqys; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlgB8Ut5fBCGPHTtZnYDvvE4LxvOqgGbRbKmjz3WVBI=;
	b=kF7MEDhPnDV2JB4y+nHurIJqtj4J/mVhzN/aCUMc2YHdOtO9tSkG+xfGvhldx83W7Nxk5w
	32KGxcH0DaAXY4ru+jTTMX2WhLC6Ry1TCVapQW7m19HAB4Xjx1xCCfJ9ZOOMgv3ILyPYo4
	11sfiFP6647BKeRK+fl8kCYhoxXcI598Fqt4DeRUWVp4++6suiCvcN8hIzzM4SXHTMLupi
	U57U889lBc+PQUGxA52FX+VdIbfh+SQacXGESn9kgXqMg12lZ2eQ7RrBn8ScmAUos1vQfd
	t3dMocEFqavKsMC9lSFZ6x9Rx6lVKWFAaJ+C8198uvfoENCISfWTHwZdapaHdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlgB8Ut5fBCGPHTtZnYDvvE4LxvOqgGbRbKmjz3WVBI=;
	b=b5BJvqysUA+2cqCvGL+GfL/ddkiEXuvRtcjsurvh/kzUZTUucraEQcsQ+ecuQ2PJ0CP3tU
	mxuW2eBFhWqVoyDQ==
Date: Wed, 23 Apr 2025 17:01:35 +0200
Subject: [PATCH 05/15] tools/nolibc: add getrandom()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-5-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=3922;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3nwM0JHeNoU0v891mo4FQH2ynggcOB+InZcti6LaMCs=;
 b=fIrdYrOUHNVpNztAKovT/6sdqK6zjRK+7sqQby8f5sL16nf3uB9bHgbb8HW7nwcEP4jjOme7K
 68gO3SgJh/YAPjwAhfMfuNzn/BmHAD/D9q/sGlYhMK571VM5SZ0JuUX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/random.h            | 32 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 19 +++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index e05862cd08051685112f067d6eb45716613dd43c..b22ff1e268b2e4bd788e974d6d8f2e1ef96dfc5f 100644
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
index 0000000000000000000000000000000000000000..b5a904dffbfb5039ca8f9efb9eaf68e7bb1716b5
--- /dev/null
+++ b/tools/include/nolibc/sys/random.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * random definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#ifndef _NOLIBC_SYS_RANDOM_H
+#define _NOLIBC_SYS_RANDOM_H
+
+#include "../arch.h"
+#include "../sys.h"
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
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
+#endif /* _NOLIBC_SYS_RANDOM_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index abe0ae794208762f6d91ad81e902fbf77253a1c1..95d08e9ccf5b3be924548100e9621cd47f39e8c2 100644
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
@@ -807,6 +808,23 @@ static int test_dirent(void)
 	return 0;
 }
 
+int test_getrandom(void)
+{
+	uint64_t rng = 0;
+	ssize_t ret;
+
+	ret = getrandom(&rng, sizeof(rng), 0);
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
@@ -1124,6 +1142,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(directories);       EXPECT_SYSZR(proc, test_dirent()); break;
+		CASE_TEST(getrandom);         EXPECT_SYSZR(1, test_getrandom()); break;
 		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
 		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;

-- 
2.49.0


