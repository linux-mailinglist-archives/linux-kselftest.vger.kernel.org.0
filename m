Return-Path: <linux-kselftest+bounces-45552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6BC588F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 905624F84B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A435502E;
	Thu, 13 Nov 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wimaF+9/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+4ogWPra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8892F363B;
	Thu, 13 Nov 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047870; cv=none; b=iBQeYd5hkmTgHmqyrMl+wOoBrU2nr1TAMBHobkZrPFhOhMc+rIN8PR8JpDoO4ydd5fKFGnihYNutpg9oNsBrZwUFwh94zQZvGrGbxdVM8XuMSbXvE8YbgEYF06AfmrjvuVWFuugnU3kLHyVPqnod53d4nCi/707+FQEC3vfYmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047870; c=relaxed/simple;
	bh=vMHQb2pZU8YuJZrhWcCiLCwjhvrbfECZZuvDEJ5pZYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BY+fvyYv990VMXcOAFAovYyoKR8SgyB9M54ITx4Bu2PLjMBxxNaNNvzzojWgbpl119lXCtSeynsW7ACoScv3bmwXHlUGlmAmZMkAmUMf96fdAWja/Q2tYMSBhmkZ4a3F4UgyuKKh4OsYcc9Nv9+6LtjN5/Nq7dkuu8Cpsexqngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wimaF+9/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+4ogWPra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgafkdasB43CZMgeqQ/jKhsmZopqp31FwuK/XeQH0zA=;
	b=wimaF+9/1sELlqjQnOnNc3XCpnD0K6Xzpzmsf89i1/dzZpjLYruTGuRtoDEE7qYYM6oU6L
	llZC7aGXmMddRNeqQuHyV7Fj6FivgpklIN6VlBxZZ5fv9GgHCmdM3rR+d3jiT3WjUU48+n
	LJXMc9dMpx770BDY6MhgH5q78s18GJ717vZIWpwU8SY/b9HFzx3q7zaD1SGVHILjCmWF1J
	/FLLAxjlQ/pYXJDXiwnUpxCuA7DNxbbtR0Zh3P/G3CYDE2oxrdPr6rvp39SPVPWwcTv7gn
	eu+tXKLNEfAh0NLDGlW5yC/X/EHRH5PNKa4McCUaIjWFm3JCOOKWBruK6RSl4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgafkdasB43CZMgeqQ/jKhsmZopqp31FwuK/XeQH0zA=;
	b=+4ogWPraL9yWDZk3RBzk6PTOEK5CXILqI18hq1iBQT+p8i4xL/aZXPGbJBreImZV6X8gSl
	Fe7J20S8S9Us97Bg==
Date: Thu, 13 Nov 2025 16:30:18 +0100
Subject: [PATCH v2 02/14] selftests: vDSO: Introduce vdso_types.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-2-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=3191;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vMHQb2pZU8YuJZrhWcCiLCwjhvrbfECZZuvDEJ5pZYc=;
 b=kv+NJvr34fUn58aJcSqjyw9lRiORxlaU3HTkrNFePvcUKSqf9MMgw66sY1LBEXdz3kELrgWoG
 P45wL87CD2bAoOVe0FJED/uFawh44/+uEVRx6Fd9FJFzLWUeK3e3cvX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently the vDSO selftests use the time-related types from libc.
This works on glibc by chance today but will break with other libc
implementations or on distributions which switch to 64-bit times
everywhere.

The kernel's UAPI headers provide the proper types to use with the vDSO
(and raw syscalls) but are not necessarily compatible with libc types.
Introduce a new header which makes the UAPI headers compatible with the
libc.

Tested with glibc, musl and nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_types.h | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_types.h b/tools/testing/selftests/vDSO/vdso_types.h
new file mode 100644
index 0000000000000000000000000000000000000000..75f2b108ed0fb6956d05e2498879658608aa2f51
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_types.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>, Linutronix GmbH
+ *
+ * Types to use with vDSO functions.
+ *
+ * The types used by the vDSO functions do not necessarily match the ones used
+ * by libc. The kernel's UAPI headers do provide definitions for those types
+ * but are often not compatible with libc which applications need to use.
+ * As the types differ between platforms listing them manually is a lot of work
+ * and error prone. Instead hack around the incompatibilities of the libc and
+ * UAPI headers and use the UAPI types.
+ */
+#ifndef __VDSO_TYPES_H__
+#define __VDSO_TYPES_H__
+
+/*
+ * Include the headers from libc first to not override any of its types later.
+ */
+#include <time.h>
+#include <sys/time.h>
+
+/*
+ * Avoid collisions.
+ */
+#define timeval kernel_timeval_moved
+#define itimerspec kernel_itimerspec_moved
+#define itimerval kernel_itimerval_moved
+#define timezone kernel_timezone_moved
+
+/*
+ * Get the UAPI types.
+ */
+#include <linux/time.h>
+
+#undef timeval
+#undef itimerspec
+#undef itimerval
+#undef timezone
+
+/*
+ * The UAPI headers do not provide their own 'struct __kernel_timezone'.
+ * 'struct timezone' is the one from libc.
+ */
+struct kernel_timezone {
+	int	tz_minuteswest;
+	int	tz_dsttime;
+};
+
+#include <linux/version.h>
+
+/*
+ * UAPI headers from the libc may be older and not provide these.
+ */
+#if KERNEL_VERSION(5, 5, 0) > LINUX_VERSION_CODE
+typedef __kernel_long_t		__kernel_old_time_t;
+
+struct __kernel_old_timespec {
+	__kernel_old_time_t	tv_sec;
+	long			tv_nsec;
+};
+#endif
+
+typedef long (*vdso_gettimeofday_t)(struct __kernel_old_timeval *tv, struct kernel_timezone *tz);
+typedef long (*vdso_clock_gettime_t)(__kernel_clockid_t clk_id, struct __kernel_old_timespec *ts);
+typedef long (*vdso_clock_gettime64_t)(__kernel_clockid_t clk_id, struct __kernel_timespec *ts);
+typedef long (*vdso_clock_getres_t)(__kernel_clockid_t clk_id, struct __kernel_old_timespec *ts);
+typedef __kernel_old_time_t (*vdso_time_t)(__kernel_old_time_t *t);
+
+#endif /* __VDSO_TYPES_H__ */

-- 
2.51.0


