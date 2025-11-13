Return-Path: <linux-kselftest+bounces-45554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAADC588E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B71D4F4E6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E12355053;
	Thu, 13 Nov 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKm2mfaE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbaSfjo5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B432F39D1;
	Thu, 13 Nov 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047871; cv=none; b=sfqndBS70+Y+F3wt4WXKA6wnMdlaXMA5/IN/OybhHOZH3+xcse7vEsml6FfaXU+a7FsnGZ/6bV2RtAOyb/tx47jUyuW3olNWR9ZL7KRNTgYffwUxcGB/rF/l/bZ4aEVmbHiNxt61FMIFNj+569pZTqpqYHGwezInjepXzLZgcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047871; c=relaxed/simple;
	bh=XprfE5GVbG+1C0TRWP/OMuxspwruH8TFVSisi/13+5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sr8jFHrL+qf9gRKSeMG+lzd3ufYx9BFqacgkY8HY7xuhtP0F1vj0EWnSSu7cRA4G4gKLZChaXmN0IKvddwrFVPWRnKXKY3oGVWQDtpsKIanKpesF0DlYVt3dpUIqehlIRestdJNPhsQ0lH4sZcGg0QeG12J8txQKQYp8jWPiFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKm2mfaE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbaSfjo5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rk4H2rJzsJKwW6HjwCB/Dmy11K36eNhIBQuW6DahpyQ=;
	b=bKm2mfaEDX6yIFx4tJOrmBGPUEfuq1VgV/0fIUEr/xtjccrN32ta3iiYa90Ow4uIGlib68
	icnSXwjG3fqueYKlcrVwwxPI0m1kUiceI86ti0t0fyhnTk63FdjvEAVYSTFOafh58FT7Ua
	uqpG1zONLgPYULmCkGmHqWHL+KOyymuGXdsA4iTcsc/uM805HbmW4HMo/yU1Xi4y2TEzEO
	6s2SX++0f7MwtA0RYLvuvK2t7Ntw8VqXg79OXmOuw/HZO/aAzmlzqrM87VyVgK8Za67yh4
	McgekwyRu1Rm6rypdkXyKF72Yuu9W+wzHcYhA0Pof28IkdR8oPJSCYdTrsuhUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rk4H2rJzsJKwW6HjwCB/Dmy11K36eNhIBQuW6DahpyQ=;
	b=vbaSfjo5bb9btVBVIiWbGjb9I884nB9gRX6yK16OgmHY+9GgoS5TG/XCokRyRHnThFFZZx
	endJnLMrDbRiJ8Aw==
Date: Thu, 13 Nov 2025 16:30:19 +0100
Subject: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=4307;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XprfE5GVbG+1C0TRWP/OMuxspwruH8TFVSisi/13+5A=;
 b=FCtQS+LIqCLv/nrQU5QH23RgGGUcob9f/SSyfGFJ7hEQiH6GwyWrf0ppsMk5wvmBadVrNV4b1
 /qSMMDozJ+fAMi8XFOhcnncUaTRMTXxVk3mTr+ngccziiZZJbg+ri6K
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vDSO selftests use raw system call wrapper to validate the
correctness of the vDSO implementation. The exactly available system
calls differ between architectures and kernel configurations.
Raw system calls should not use libc types as these are not necessarily
compatible.

Introduce a helper header which uses the correct types and fallbacks.

Link: https://lore.kernel.org/lkml/29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_syscalls.h | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_syscalls.h b/tools/testing/selftests/vDSO/vdso_syscalls.h
new file mode 100644
index 0000000000000000000000000000000000000000..1419f8dd3ea831beaf582c47f6acf2ce5d5d12f8
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_syscalls.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>, Linutronix GmbH
+ *
+ * System call wrappers to use for vDSO testing.
+ *
+ * vDSO calls are expected to return the same data as the equivalent system call.
+ * To ensure this the tests need to trigger system calls. Calling into libc may
+ * silently use the vDSO, so explicit system calls are necessary.
+ * Not all system calls are available on all platforms, so some fallback logic
+ * is needed. Use __NR_ constants from the kernel's UAPI headers over SYS_ from
+ * ones from libc to avoid any potential interference from libc.
+ * Always prefer the 64-bit time variants of the system calls as 32-bit ones
+ * may not be present on the platform or disabled in the kernel configuration.
+ */
+#ifndef __VDSO_SYSCALLS_H__
+#define __VDSO_SYSCALLS_H__
+
+#include "vdso_types.h"
+
+#include <stddef.h>
+#include <sys/syscall.h>
+#include <linux/unistd.h>
+
+#define typeof_member(T, m)	typeof(((T*)0)->m)
+#define sizeof_member(T, m)	sizeof(typeof_member(T, m))
+
+/*
+ * To keep the fallback logic simple we assume that although the types between
+ * the wrapper and the system call are different they are compatible.
+ * Validate that assumption.
+ * On x32 tv_nsec of __kernel_old_timespec is smaller than the one from
+ * __kernel_timespec. This is fine, as only the lower 4 bytes are relevant and
+ * it is a little-endian architecture.
+ */
+#define ASSERT_TIMESPEC_COMPATIBLE(T1, T2)							\
+	do {											\
+		_Static_assert(sizeof(T2) == sizeof(T2));					\
+		_Static_assert(offsetof(T1, tv_sec) == offsetof(T2, tv_sec));			\
+		_Static_assert(sizeof_member(T1, tv_sec) == sizeof_member(T2, tv_sec));		\
+		_Static_assert(offsetof(T1, tv_nsec) == offsetof(T2, tv_nsec));			\
+		_Static_assert(sizeof_member(T1, tv_nsec) == sizeof_member(T2, tv_nsec) ||	\
+			       (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__ && 			\
+			       sizeof_member(T1, tv_nsec) > sizeof_member(T2, tv_nsec)));	\
+	} while(0)
+
+static inline
+int sys_clock_getres(__kernel_clockid_t clock, struct __kernel_timespec *ts)
+{
+#ifdef __NR_clock_getres_time64
+	return syscall(__NR_clock_getres_time64, clock, ts);
+#else
+	ASSERT_TIMESPEC_COMPATIBLE(typeof(*ts), struct __kernel_old_timespec);
+	return syscall(__NR_clock_getres, clock, ts);
+#endif
+}
+
+static inline
+int sys_clock_gettime(__kernel_clockid_t clock, struct __kernel_timespec *ts)
+{
+#ifdef __NR_clock_gettime64
+	return syscall(__NR_clock_gettime64, clock, ts);
+#else
+	ASSERT_TIMESPEC_COMPATIBLE(typeof(*ts), struct __kernel_old_timespec);
+	return syscall(__NR_clock_gettime, clock, ts);
+#endif
+}
+
+static inline
+int sys_gettimeofday(struct __kernel_old_timeval *tv, struct kernel_timezone *tz)
+{
+#ifdef __NR_gettimeofday
+	return syscall(__NR_gettimeofday, tv, tz);
+#else
+	/* Architectures with vdso_gettimeofday() also have __NR_gettimeofday */
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
+static inline
+__kernel_old_time_t sys_time(__kernel_old_time_t *tloc)
+{
+#ifdef __NR_time
+	return syscall(__NR_time, tloc);
+#else
+	/* Architectures with vdso_time() also have __NR_time */
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
+#endif /* __VDSO_SYSCALLS_H__ */

-- 
2.51.0


