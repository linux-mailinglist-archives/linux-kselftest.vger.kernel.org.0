Return-Path: <linux-kselftest+bounces-45297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E688C4D3AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAFAE4F6361
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535F35471D;
	Tue, 11 Nov 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P5e54xKS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n33Hzt/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352E350D5A;
	Tue, 11 Nov 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858203; cv=none; b=Ahw+N3q7Lzi64Ozakf1FkHFQBQDFLAIRAKIbmBq08gWor8UiNn8DDvWZWPhfrnvJbYdjCDKx11dJzqQfczft6amSv9Wu8UEjHhB51lgTgTbhXd8SI/29FTFL8SZIjzSV9GKTkiVlIDVAucqnINSzGDAeR/EiNLFIPrdz2mJSdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858203; c=relaxed/simple;
	bh=EeRfykXVankngUAY1jUwatWYcaIYufS5aUaNTFHkrCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVug6U2tzgc5X6NbT9qtTAEl9GDRrZcE+H9Yh5SEZdX1mrS9o+tvCmQlpJ9NDCFRw7z5k+syB1b73dwbbtPkrusOKYt179OOfCR+JlgM2D9JOer8XeuS32ncDQfFAA2E2oHkyEZUqaLe4ZdmcXF9rgnI802pjmGoXpedFQBncuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P5e54xKS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n33Hzt/9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ds70ShsrdVFkzMZTRTLjKAoAYskQWlHPQmsTM1PrMXA=;
	b=P5e54xKSriztzJLgGI7sJN/mdzGBk5PmMEMo6Ek/3oa+fl21nSDZdTPTV4y17hLPBR2R7P
	AtKxnS0/C3O/sp2XTQGaGm6BUDduHys3fOWJnl3MFA4rSrKgsnN/0zIdM2vbJFg0sz3xPo
	njc2b08Pz96ky6GtG+K6Yqh76LEHnP9qFLsT+eekieI43QzIfHhU7gHtt2GN/0rdGSqDS4
	98/wFmjgv7jNNGbJq7GXG8UY4lFpg05jB5zRLDJAcqNAi6rYk36yjKTyeFAsiDhfpt3xII
	cdotFsHZ/vyGyrWLT9Ynbq7IsbgXdorfqen1I2re77o0dMNr1Qowf6uvOSLeSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ds70ShsrdVFkzMZTRTLjKAoAYskQWlHPQmsTM1PrMXA=;
	b=n33Hzt/9DvaTv1I/f6y/aiGikjPjU2MQLQUK1Ty4iT7YCDwcj0VHu22SxYyHr9k+9NLgod
	reL2M9PX9/lHeJAQ==
Date: Tue, 11 Nov 2025 11:49:48 +0100
Subject: [PATCH 02/10] selftests: vDSO: Introduce vdso_types.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-2-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=3183;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=EeRfykXVankngUAY1jUwatWYcaIYufS5aUaNTFHkrCg=;
 b=rKRYcnJzwEO9AKks9K4hWcrKlP7AwyskDHYBDIhzj2Ri7n8VosOQ245VtxBldIJwgz6lzivCf
 nZ2MTPvF22mCql9+FvMZMJ0mjelBHHvBl7in7WdXJ9HYiA9wylUzBI8
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
index 0000000000000000000000000000000000000000..a1f2f5412e813d5ba6e57a87e28b9eacc68cccac
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
+typedef __kernel_time_t (*vdso_time_t)(__kernel_time_t *t);
+
+#endif /* __VDSO_TYPES_H__ */

-- 
2.51.0


