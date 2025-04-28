Return-Path: <linux-kselftest+bounces-31778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89CA9F107
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837474612D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28AB270540;
	Mon, 28 Apr 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3LBVdia/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErMAX1nb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54E262FD9;
	Mon, 28 Apr 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844018; cv=none; b=UqOCEhgAK9XXftXYnGbgazDR8x7iaZSjGFw7TUrZuOdoP+zA3q9xvTaV2PdRNuUpHJZYbVI2+qUzzaeYPScmNgDAH6iJsv177adBelHTT7O3251OjioJkIjfux0hL6p4VLSFnI+aj851x4JwGWRQ0PgVIwZ2Nf/uTnnh6nwnkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844018; c=relaxed/simple;
	bh=WeAGTV8OHPTjzwgW5Egi8+ev06i97jWnUOaoMHGLjlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2/b9qT/O+r6wAhs1BIuoQEpqgqeargVGCZJz60W775KkSTZuFQY0xkynyYz55ttbiaNHqiTmAOHdtXFRpTwgJVFCJugUAxZ92XgYDQteGF1ky4330+LTOTWIfN6rOdvCMKfEKvOBXT6D2AWi43jzN+yUR3VKIVoK7eLrZVzCdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3LBVdia/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErMAX1nb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1W3Lr5AUZYiINJIhhoTZvtHq8tC9SgHLl8tJzDEjFCk=;
	b=3LBVdia/77zU7LcKjFXtipuCPnGOuLprEtH+W1UK+RScX6Jkk+G2QvCfcjjk/z2OEHpD+A
	rNoBRY9nuETsYnuUP470fpeUkH3nKRJYPeUuHJMqVsRWOHkWxhAC+g05b95fTmRfLaca/Y
	lbUs7p1kNjCaAwmwSLcjNld30dwobPJEGL7Y+BLzvLxKx/OYEDZMGzunSpTYyJFOa8OFpZ
	4OT8Ov37mpO7KTJ4GBw0g61iWDM/3lIoC7QMCCweP61EsC2o4s5Nh9gJDDknQ7UQJta7yp
	w+xSTLuxPrKNnA4x9bVLnQ32a7sRxWLZF9p/lMb1eBeDU9FUbJ3aWwPN5OUZAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1W3Lr5AUZYiINJIhhoTZvtHq8tC9SgHLl8tJzDEjFCk=;
	b=ErMAX1nbPPRBtGD+ZvWtOYvL/DGElGYtCPbnl3WC3pg0sVv7Bz9TuhAI+Vxoeh2CqeW8Xp
	QiS/Iaad1nGQLVCQ==
Date: Mon, 28 Apr 2025 14:40:13 +0200
Subject: [PATCH v2 12/15] tools/nolibc: add namespace functionality
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-12-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=5562;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WeAGTV8OHPTjzwgW5Egi8+ev06i97jWnUOaoMHGLjlI=;
 b=BC195df7JZ9wXBc5jXhYZA6p59GNibkX5bah29hCq4cHWDH5BchDVBHy7ZQQXtUZZwLFecd9J
 E+SKxz2dvEtD9/9P14vFlFaW2ASCUpJN+7ou/d3QnPMWD5uXD19Fv8E
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Not all configurations support namespaces, so skip the tests where
necessary.  Also if the tests are running without privileges.
Enable the namespace configuration for those architectures where it is not
enabled by default.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sched.h                 | 50 +++++++++++++++++++++
 tools/testing/selftests/nolibc/Makefile      |  2 +
 tools/testing/selftests/nolibc/nolibc-test.c | 67 ++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index d54646387872d3b0d0158a35c4122f4713c435ce..48f89567c03fb3cbcbe1d20accb9d293056d4142 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -37,6 +37,7 @@ all_files := \
 		limits.h \
 		math.h \
 		nolibc.h \
+		sched.h \
 		signal.h \
 		stackprotector.h \
 		std.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 13628261b9cc92d545745acc9ebef541b185f2bd..d6722e22f441956e70340dcab004aa73a3125691 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -106,6 +106,7 @@
 #include "sys/wait.h"
 #include "ctype.h"
 #include "elf.h"
+#include "sched.h"
 #include "signal.h"
 #include "unistd.h"
 #include "stdio.h"
diff --git a/tools/include/nolibc/sched.h b/tools/include/nolibc/sched.h
new file mode 100644
index 0000000000000000000000000000000000000000..32221562c1663f6d1d78fab82bb6e8d05ad68da9
--- /dev/null
+++ b/tools/include/nolibc/sched.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * sched function definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_SCHED_H
+#define _NOLIBC_SCHED_H
+
+#include "sys.h"
+
+#include <linux/sched.h>
+
+/*
+ * int setns(int fd, int nstype);
+ */
+
+static __attribute__((unused))
+int sys_setns(int fd, int nstype)
+{
+	return my_syscall2(__NR_setns, fd, nstype);
+}
+
+static __attribute__((unused))
+int setns(int fd, int nstype)
+{
+	return __sysret(sys_setns(fd, nstype));
+}
+
+
+/*
+ * int unshare(int flags);
+ */
+
+static __attribute__((unused))
+int sys_unshare(int flags)
+{
+	return my_syscall1(__NR_unshare, flags);
+}
+
+static __attribute__((unused))
+int unshare(int flags)
+{
+	return __sysret(sys_unshare(flags));
+}
+
+#endif /* _NOLIBC_SCHED_H */
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 2671383045dbb51682fd62ac8c8df9c317157317..94176ffe46463548cc9bc787933b6cefa83d6502 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -109,6 +109,8 @@ DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
 EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
+EXTRACONFIG_arm       = -e CONFIG_NAMESPACES
+EXTRACONFIG_armthumb  = -e CONFIG_NAMESPACES
 
 # optional tests to run (default = all)
 TEST =
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 665d7631fbc6e9ecae469a4b143440ec0a43d4aa..d1157319b5d715dbc94ff9203b1d2a2e932aabcf 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1172,6 +1172,72 @@ int test_openat(void)
 	return 0;
 }
 
+int test_namespace(void)
+{
+	int original_ns, new_ns, ret;
+	ino_t original_ns_ino;
+	struct stat stat_buf;
+
+	original_ns = open("/proc/self/ns/uts", O_RDONLY);
+	if (original_ns == -1)
+		return -1;
+
+	ret = fstat(original_ns, &stat_buf);
+	if (ret)
+		goto out;
+
+	original_ns_ino = stat_buf.st_ino;
+
+	ret = unshare(CLONE_NEWUTS);
+	if (ret)
+		goto out;
+
+	new_ns = open("/proc/self/ns/uts", O_RDONLY);
+	if (new_ns == -1) {
+		ret = new_ns;
+		goto out;
+	}
+
+	ret = fstat(new_ns, &stat_buf);
+	close(new_ns);
+	if (ret)
+		goto out;
+
+	if (stat_buf.st_ino == original_ns_ino) {
+		errno = EINVAL;
+		ret = -1;
+		goto out;
+	}
+
+	ret = setns(original_ns, CLONE_NEWUTS);
+	if (ret)
+		goto out;
+
+	new_ns = open("/proc/self/ns/uts", O_RDONLY);
+	if (new_ns == -1) {
+		ret = new_ns;
+		goto out;
+	}
+
+	ret = fstat(new_ns, &stat_buf);
+	if (ret)
+		goto out;
+
+	close(new_ns);
+
+	if (stat_buf.st_ino != original_ns_ino) {
+		errno = EINVAL;
+		ret = -1;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	close(original_ns);
+	return ret;
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -1296,6 +1362,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
+		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

-- 
2.49.0


