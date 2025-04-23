Return-Path: <linux-kselftest+bounces-31415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB3A98F9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C87D1B83B29
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44328B4FD;
	Wed, 23 Apr 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kFsIgXmA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySb6Q6SL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C996289368;
	Wed, 23 Apr 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420508; cv=none; b=UqQC/Ko7wjk6GaemT7sDwSyJj1M9nbKGkDRH0jnVLF+xAfEZxJBmRoepYWZKK9Dfl+Gpra8zcnSiY+jnXl+qGHeGPopIG4owVxeCtnp/1C5QyCn07ElojxqxU8K7timzys8d8bwnENV2Rkpwj9r1LxtB3imnP8islayZxsY6J8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420508; c=relaxed/simple;
	bh=mL7BMOt2Dm2hWpLZpunY/sGwlAtb+TWJVi/FfVODcRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQMhZmNkGUY3tBBlqWMXPiHEMJIliZ0TWLTqYBW85eshkTU2NbVDmfAA+Up7hHS4KmfwXDtHBK6ttvaxq9rczC8zP8Vin0nJQtMHOQJN7lvheAN+4Sq1WIJshl0mPRPIndo0QzWDhTD4sTzyHO78XLOcN5v1hA0znikPvpX/0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kFsIgXmA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySb6Q6SL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h5AdN/9Qv0rdqSTBWh0yx7GylopoI7RA2AVXxDG3K0=;
	b=kFsIgXmADoiLQb5rfePzJtQAw4pHN6yTbzn+UOSqjOqmy70yDCA7FxoAVrVaLI6uZnua9t
	rlo1sQvfHxzIqD6X6s4Fsj7Ehn6tduf4XEybBYN+MxZJvd9dhYUoZ/UmjB4H4/gVrRzdIA
	7E35c6l9PB1T6PRruUnT3hl7WdmqmDgVDV6CWWFSkjIrUZ+koqQF1g162TsjPKNgzOtNmc
	jpjdCmNjQSHlBhtvCBO9+cXtKNHNX62Yb4EwadUHb2sapTSwM3t9eDH4HwGizvJaSoM1BJ
	a/rqdg2taI9JIBBCz/5rXnMR/dx2mkTYHpWnl9M4ds6iz3JPz7YU3SZbpSMn8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h5AdN/9Qv0rdqSTBWh0yx7GylopoI7RA2AVXxDG3K0=;
	b=ySb6Q6SLvwn9crlZw+Sk/y4PRZBpAe+ymiBildeQ91hLDDGkg3XUWu3p0ZGqDVmZkgSao1
	GSPp8mgYIl9MdWBg==
Date: Wed, 23 Apr 2025 17:01:40 +0200
Subject: [PATCH 10/15] tools/nolibc: add timerfd functionality
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-10-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=6373;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mL7BMOt2Dm2hWpLZpunY/sGwlAtb+TWJVi/FfVODcRY=;
 b=7ksIL9Rwv+gVsw6d3gqEua/DlLtOrJHnFw6ATfnUWo8nlzHbLYOFaZ940WncZkH1BVWpC5zdu
 v3lwPArQTAVDxXWXwk0feZMRRpvCp9eu7E18LeUDa0M+Rzh3SH1dBaG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/timerfd.h           | 87 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 48 +++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 3a82e036a2c1762da5c3916ff9f4e158fb6106ff..e3aeb247c74e88af5d769efe64965c5bcbb40611 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -52,6 +52,7 @@ all_files := \
 		sys/stat.h \
 		sys/syscall.h \
 		sys/time.h \
+		sys/timerfd.h \
 		sys/types.h \
 		sys/wait.h \
 		time.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 2207f3d3c5cf92b96150149050f0bde0ed7e7147..13628261b9cc92d545745acc9ebef541b185f2bd 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -102,6 +102,7 @@
 #include "sys/stat.h"
 #include "sys/syscall.h"
 #include "sys/time.h"
+#include "sys/timerfd.h"
 #include "sys/wait.h"
 #include "ctype.h"
 #include "elf.h"
diff --git a/tools/include/nolibc/sys/timerfd.h b/tools/include/nolibc/sys/timerfd.h
new file mode 100644
index 0000000000000000000000000000000000000000..2d61fc76fe9a9ba7571f52ff157a8a4807d7d9c9
--- /dev/null
+++ b/tools/include/nolibc/sys/timerfd.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * timerfd definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#ifndef _NOLIBC_SYS_TIMERFD_H
+#define _NOLIBC_SYS_TIMERFD_H
+
+#include "../sys.h"
+#include "../time.h"
+
+#include <linux/timerfd.h>
+
+
+static __attribute__((unused))
+int sys_timerfd_create(int clockid, int flags)
+{
+	return my_syscall2(__NR_timerfd_create, clockid, flags);
+}
+
+static __attribute__((unused))
+int timerfd_create(int clockid, int flags)
+{
+	return __sysret(sys_timerfd_create(clockid, flags));
+}
+
+
+static __attribute__((unused))
+int sys_timerfd_gettime(int fd, struct itimerspec *curr_value)
+{
+#if defined(__NR_timerfd_gettime)
+	return my_syscall2(__NR_timerfd_gettime, fd, curr_value);
+#elif defined(__NR_timerfd_gettime64)
+	struct __kernel_itimerspec kcurr_value;
+	int ret;
+
+	ret = my_syscall2(__NR_timerfd_gettime64, fd, &kcurr_value);
+	__nolibc_timespec_kernel_to_user(&kcurr_value.it_interval, &curr_value->it_interval);
+	__nolibc_timespec_kernel_to_user(&kcurr_value.it_value, &curr_value->it_value);
+	return ret;
+#else
+	return __nolibc_enosys(__func__, fd, curr_value);
+#endif
+}
+
+static __attribute__((unused))
+int timerfd_gettime(int fd, struct itimerspec *curr_value)
+{
+	return __sysret(sys_timerfd_gettime(fd, curr_value));
+}
+
+
+static __attribute__((unused))
+int sys_timerfd_settime(int fd, int flags,
+			const struct itimerspec *new_value, struct itimerspec *old_value)
+{
+#if defined(__NR_timerfd_settime)
+	return my_syscall4(__NR_timerfd_settime, fd, flags, new_value, old_value);
+#elif defined(__NR_timerfd_settime64)
+	struct __kernel_itimerspec knew_value, kold_value;
+	int ret;
+
+	__nolibc_timespec_user_to_kernel(&new_value->it_value, &knew_value.it_value);
+	__nolibc_timespec_user_to_kernel(&new_value->it_interval, &knew_value.it_interval);
+	ret = my_syscall4(__NR_timerfd_settime64, fd, flags, &knew_value, &kold_value);
+	if (old_value) {
+		__nolibc_timespec_kernel_to_user(&kold_value.it_interval, &old_value->it_interval);
+		__nolibc_timespec_kernel_to_user(&kold_value.it_value, &old_value->it_value);
+	}
+	return ret;
+#else
+	return __nolibc_enosys(__func__, fd, flags, new_value, old_value);
+#endif
+}
+
+static __attribute__((unused))
+int timerfd_settime(int fd, int flags,
+		    const struct itimerspec *new_value, struct itimerspec *old_value)
+{
+	return __sysret(sys_timerfd_settime(fd, flags, new_value, old_value));
+}
+
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
+#endif /* _NOLIBC_SYS_TIMERFD_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6af55a04e3c6bcea4e09c941778ffd1f3b186690..aed71de4b4f3dd1f183c7fc25e5a5cee466600ed 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -27,6 +27,7 @@
 #include <sys/syscall.h>
 #include <sys/sysmacros.h>
 #include <sys/time.h>
+#include <sys/timerfd.h>
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
@@ -952,6 +953,52 @@ int test_timer(void)
 	return ret;
 }
 
+int test_timerfd(void)
+{
+	struct itimerspec timerspec;
+	int timer, ret;
+
+	timer = timerfd_create(CLOCK_MONOTONIC, 0);
+	if (timer == -1)
+		return -1;
+
+	timerspec = (struct itimerspec) {
+		.it_value.tv_sec = 1000000,
+	};
+	ret = timerfd_settime(timer, 0, &timerspec, NULL);
+	if (ret)
+		goto err;
+
+	timerspec = (struct itimerspec) {
+		.it_value.tv_sec = -1,
+		.it_value.tv_nsec = -1,
+		.it_interval.tv_sec = -1,
+		.it_interval.tv_nsec = -1,
+	};
+	ret = timerfd_gettime(timer, &timerspec);
+	if (ret)
+		goto err;
+
+	errno = EINVAL;
+	ret = -1;
+
+	if (timerspec.it_interval.tv_sec || timerspec.it_interval.tv_nsec)
+		goto err;
+
+	if (timerspec.it_value.tv_sec > 1000000)
+		goto err;
+
+	ret = close(timer);
+	if (ret)
+		return ret;
+
+	return 0;
+
+err:
+	close(timer);
+	return ret;
+}
+
 int test_uname(void)
 {
 	struct utsname buf;
@@ -1234,6 +1281,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
 		CASE_TEST(timer);             EXPECT_SYSZR(1, test_timer()); break;
+		CASE_TEST(timerfd);           EXPECT_SYSZR(1, test_timerfd()); break;
 		CASE_TEST(uname);             EXPECT_SYSZR(proc, test_uname()); break;
 		CASE_TEST(uname_fault);       EXPECT_SYSER(1, uname(NULL), -1, EFAULT); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;

-- 
2.49.0


