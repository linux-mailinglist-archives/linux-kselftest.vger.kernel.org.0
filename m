Return-Path: <linux-kselftest+bounces-31417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C098A98FAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4329C1B83DBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747D28BAA9;
	Wed, 23 Apr 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3rxtct5T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nup0TkJh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117BB28A1FB;
	Wed, 23 Apr 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420509; cv=none; b=OG5GA6SIT+N1LzN2LnqHXmY/np/ckIAqwc7OHzfpyywSuFUWDgeICYcb1DaVHamtpZ/q6hVQDln+SiRlhNogidYFSHA/npvaMh+cvZe08nPzCwBOuZZ8FdF3yaGySX25eJqxZkxLyjetJRtiOHV+CkRr1kwqhl89/p/mxTRza3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420509; c=relaxed/simple;
	bh=FNILqJREiWU391TWm5ngVTlKSf5kcHUg4Mk9H+r2gLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1SpXXG6bBQUVtRcyFVELV3AHcaqCZTf3NoFTSWq+M6eHTcQwyYZ3Y8q2b9aRms9NpjswluVNug7xqDPsUp5eBoRKKmjkvRBRk6S4taCHWDkfOZ2T3hSFHdREhquDomQA8edpJWZVB4x5s/GDYuifkKlscAe3tb7dC+Ih2aL5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3rxtct5T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nup0TkJh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qj5rd4/9gTpDNF7r8PvlINanGlwadZfZJ4R7QvPABYE=;
	b=3rxtct5TcgZB3Z3xfm4luWIOQkis65uATg8LF+oVatrVaS8HNxkTkiq3fppQE/6C4Nv5vu
	Oa7z3Wz1SDwcZ5DsumWEaNFszPr84dv9wT4pH0A+wi8q71M8V7aNMmm9Bzd+lvjQxnaWbp
	Z3WdbErfLSwO0S0vtwkjx+cFWH7IbZm6ojuaWDoumDT6kTELi2h2+DSzPZxr5he9Dv0iyZ
	/6iLaq3Ei7AguP4LI7RTsFqC9ND9ZopRx5YydeuYJzQSrfq1ROZ/8aY2P69XOT6FfDxh4e
	0W0ym59Tiqu+ZsY4VILbSxlYNsiAqXur3jN+WYpjnp8dNzdBRZslqGVQIS/YHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qj5rd4/9gTpDNF7r8PvlINanGlwadZfZJ4R7QvPABYE=;
	b=Nup0TkJhnvbzuvNBnPJiFNsc3Qn1vWABvjKlKxZHEtDrh66nT9zMdYQsMWvq8zHRsRmo9K
	49UAFhXASzUrF5BQ==
Date: Wed, 23 Apr 2025 17:01:42 +0200
Subject: [PATCH 12/15] tools/nolibc: add namespace functionality
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-12-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=5288;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=FNILqJREiWU391TWm5ngVTlKSf5kcHUg4Mk9H+r2gLg=;
 b=oQgZiX49EZdYEU3Mi3ktQ5Sso6l6EV1vv5HVvPYVEyUbPpAP3W7KH9yncurUfZYe1l+duxEC2
 5oggR6ywSiHBOm4bORvGfRa8nrVgUazF+u9lSzPqeRIkPoAmJ/b1Qt6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sched.h                 | 50 +++++++++++++++++++++
 tools/testing/selftests/nolibc/Makefile      |  2 +
 tools/testing/selftests/nolibc/nolibc-test.c | 67 ++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index e3aeb247c74e88af5d769efe64965c5bcbb40611..5fed167f26aa3475eebc7a56bd97820932e97ff9 100644
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
index 0000000000000000000000000000000000000000..19108d33c5c6063d41916bbf46ef1f7b1b49595c
--- /dev/null
+++ b/tools/include/nolibc/sched.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * sched function definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ */
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
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#endif /* _NOLIBC_SCHED_H */
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 94f3e8be7a68f63ecd639c4f283b3cd10764ce74..37526891af8de338d1d55315d7d6a7179e695cd0 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -106,6 +106,8 @@ DEFCONFIG_sparc64    = sparc64_defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
+EXTRACONFIG_arm       = -e CONFIG_NAMESPACES
+EXTRACONFIG_armthumb  = -e CONFIG_NAMESPACES
 
 # optional tests to run (default = all)
 TEST =
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index fd8bab42e75157967658690005bc9142360fc135..ab9c3bcffd9750981d68c6d16245d285ce0657c8 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1169,6 +1169,72 @@ int test_openat(void)
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
@@ -1293,6 +1359,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
+		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

-- 
2.49.0


