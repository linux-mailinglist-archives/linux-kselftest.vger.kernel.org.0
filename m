Return-Path: <linux-kselftest+bounces-31776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC15FA9F10C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EE13A3128
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84D26FD8C;
	Mon, 28 Apr 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KeMRdeDx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ikgXC93c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D126C384;
	Mon, 28 Apr 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844017; cv=none; b=SOLlA3qCqaSv8YyOlGzXP6J9U0+uiZPCU/aUb8gNV78s5jyzkQbkDanLWlFk90leI+ms9ugmnigy0z4R8hAx2EdxsdNf6/KIb1tXT34RU5SLs+HAR9LF8i6pfKockvGKvy/tPxx+irLhoPje8Ojpm/Cmwm8aaCM6sBJY5/ap7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844017; c=relaxed/simple;
	bh=p8Qfp5jbr7ezRzEZ5mBSvKLM+B+sEy8yhzPaaJe2Xa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHMELqY0ZQqJC1Qv+AXX64NIr3RaaB7K8VqThE1+jids2++FXmJy8UBmzPRsdR+GRRmEx8uGKFeRoKrKeOxl1XSfaT8hBq/w8OTdD0j/8JvTeZC4nwiotZrE/Q79TN96ZVf77Nyo+AMdCC6hHh6aT37lQFZWX5XZioqfHINaHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KeMRdeDx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ikgXC93c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PbjA91xQab2W4IEoeudlT3ft1JpgJ5knx/HDjiMC8s=;
	b=KeMRdeDxH5Z+1nLXGHsaTgYTWN1e0IOxcw9Xel4QCFSvcbT1520de9U/1EL2qnzflGRs50
	GI5pzZdnAuXjsmCWCVKbSJFjwBVXGE9FaV/Mudce//DiBchvE0rkyDEYg2esNQOa94ZDym
	WiFOoT8fl6DIrdu31A7RBBhTfcCF+CxklmOgjdhQcnRU9DQVRNIKQTFxf9wdQIVWoKn9Ca
	6Jc84r3yzjnGLHy2urq8jwiKQOTGfe9zUe/e8TGafwpimTv6QxtmaJQssP21Lkjkns84/i
	m0z+VVrF6bOYFzcxaIbCn3BFGzMl+6Y5lgCLXz6z2A6RMntItooiLbtOBsPgzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PbjA91xQab2W4IEoeudlT3ft1JpgJ5knx/HDjiMC8s=;
	b=ikgXC93cqak0X7ueXB4JaGe0EbSbtoeovMEaiz6rqalRY6OnS6EguXqDD2crOlReMO6fH7
	Texa8tNS+4Hl15BA==
Date: Mon, 28 Apr 2025 14:40:11 +0200
Subject: [PATCH v2 10/15] tools/nolibc: add timerfd functionality
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-10-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=6409;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=p8Qfp5jbr7ezRzEZ5mBSvKLM+B+sEy8yhzPaaJe2Xa8=;
 b=J1yqlEnNYPKNo0mrKz1V3O7h2geZdm3QbuatE+LnXS8dBB6cf1TBqMPYLVtMMsyvGTp5sBOEe
 BN2bXuR0lKhAT6J/1yYVPVmZirEWrfEptJY5tBIeSIhp1/RxGIKxvcP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/timerfd.h           | 87 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 48 +++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 552e44f5a48211f81c68068b9b99c1dd6e44e9d8..d54646387872d3b0d0158a35c4122f4713c435ce 100644
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
index 0000000000000000000000000000000000000000..4375d546ba58f849b3ba48e7b221e6ec3c15fcf6
--- /dev/null
+++ b/tools/include/nolibc/sys/timerfd.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * timerfd definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+/* make sure to include all global symbols */
+#include "../nolibc.h"
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
+#endif /* _NOLIBC_SYS_TIMERFD_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7530b442941f5538cd1d54974e7c8aa435513653..d73125c41096fd208b7b8719e61efa2da9865673 100644
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
@@ -955,6 +956,52 @@ int test_timer(void)
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
@@ -1237,6 +1284,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
 		CASE_TEST(timer);             EXPECT_SYSZR(1, test_timer()); break;
+		CASE_TEST(timerfd);           EXPECT_SYSZR(1, test_timerfd()); break;
 		CASE_TEST(uname);             EXPECT_SYSZR(proc, test_uname()); break;
 		CASE_TEST(uname_fault);       EXPECT_SYSER(1, uname(NULL), -1, EFAULT); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;

-- 
2.49.0


