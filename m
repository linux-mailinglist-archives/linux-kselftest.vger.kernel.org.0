Return-Path: <linux-kselftest+bounces-33136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4017FAB9057
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FFB1BC0995
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001529C342;
	Thu, 15 May 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XUjZbDsz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBB29B770;
	Thu, 15 May 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339108; cv=none; b=dtAsz7daNvk641KdVUk/eJSbepusRbUEjk83h3Scbcy4qiu7emzKeC36TVVtZZGm3Ef/5xoJR8kMXbabs0Sdorx1uM3cZwK9nKJjnphtdIxpujkYtW5seCxCkD5iFtyTgIKoSeWEzhwQhJ/32f8wO5QHOyZpjiPEp5C2uq3bbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339108; c=relaxed/simple;
	bh=Hx9XqnN1Ky1xnifC3f1mE3KSfmKRJqKgcc7ImwIV7lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBNsXsNwXX9DJjEhN4cupYo4CoGLaiSqHpIUbzpM4BnkOu75jVsuPKyWXCvT0ixlAcuvklyRbDp+uUC5iF7oNia0OQTi8m4KNThjs/OJjgoFwgDb5QEa6x0CTdKfw+9LE5IpHDJ4N8CNpaLf6F45Sieo/p0Ke56ybZxigBbmzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XUjZbDsz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339094;
	bh=Hx9XqnN1Ky1xnifC3f1mE3KSfmKRJqKgcc7ImwIV7lQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XUjZbDszCyK+gupu3DAzStjhd8f+wFojL4CdOCEUWMODoQ9YaGWksT19PPOaRUvQ+
	 QcGgP9NGkm4lyPcyo3cgNUlXWvnsxIRKUI1QM/pUEXc2Qo6Hd+tHwypXQq6r/3uMZd
	 EybG514TlZU52ueKWwdIuOgShdFngCccoDiNDwfE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:51 +0200
Subject: [PATCH 5/9] tools/nolibc: move getrlimit() and friends to
 sys/resource.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-5-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=4891;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Hx9XqnN1Ky1xnifC3f1mE3KSfmKRJqKgcc7ImwIV7lQ=;
 b=Q/rEXNf3m5peBPfud3+Idc+spcsnW4d0d2TDGQCL5DQGnaYKPoT5qUjF3T64ZgFUhgZoLKq9Z
 16m6uxEJ/ouC/qIbS+p3wbjdcemc1Ki3OP3VsTCd6vDTrGL5iLxO6As
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the location regular userspace expects these definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile       |  1 +
 tools/include/nolibc/nolibc.h       |  1 +
 tools/include/nolibc/sys.h          | 38 --------------------------
 tools/include/nolibc/sys/resource.h | 53 +++++++++++++++++++++++++++++++++++++
 tools/include/nolibc/types.h        |  1 -
 5 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 4850501b8d53be6b603ecbb04d6f952cd5370cf0..cc82399e940e53940061b60588566db51f2e191a 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -55,6 +55,7 @@ all_files := \
 		sys/prctl.h \
 		sys/random.h \
 		sys/reboot.h \
+		sys/resource.h \
 		sys/stat.h \
 		sys/syscall.h \
 		sys/time.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 36ea7a02c7434cc006a7b12d413add04a2f85565..7d151776e47a30080dc3d961bcdeacd6ab558629 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -103,6 +103,7 @@
 #include "sys/prctl.h"
 #include "sys/random.h"
 #include "sys/reboot.h"
+#include "sys/resource.h"
 #include "sys/stat.h"
 #include "sys/syscall.h"
 #include "sys/time.h"
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 6c89dd0316dd0ebf03ebde6fa5c14273df6a0c62..282909b1992d17d5292917fbabb0bd2a2dbfce88 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -23,7 +23,6 @@
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
-#include <linux/resource.h>
 #include <linux/utsname.h>
 
 #include "errno.h"
@@ -730,43 +729,6 @@ ssize_t read(int fd, void *buf, size_t count)
 }
 
 
-/*
- * int getrlimit(int resource, struct rlimit *rlim);
- * int setrlimit(int resource, const struct rlimit *rlim);
- */
-
-static __attribute__((unused))
-int sys_prlimit64(pid_t pid, int resource,
-		  const struct rlimit64 *new_limit, struct rlimit64 *old_limit)
-{
-	return my_syscall4(__NR_prlimit64, pid, resource, new_limit, old_limit);
-}
-
-static __attribute__((unused))
-int getrlimit(int resource, struct rlimit *rlim)
-{
-	struct rlimit64 rlim64;
-	int ret;
-
-	ret = __sysret(sys_prlimit64(0, resource, NULL, &rlim64));
-	rlim->rlim_cur = rlim64.rlim_cur;
-	rlim->rlim_max = rlim64.rlim_max;
-
-	return ret;
-}
-
-static __attribute__((unused))
-int setrlimit(int resource, const struct rlimit *rlim)
-{
-	struct rlimit64 rlim64 = {
-		.rlim_cur = rlim->rlim_cur,
-		.rlim_max = rlim->rlim_max,
-	};
-
-	return __sysret(sys_prlimit64(0, resource, &rlim64, NULL));
-}
-
-
 /*
  * int sched_yield(void);
  */
diff --git a/tools/include/nolibc/sys/resource.h b/tools/include/nolibc/sys/resource.h
new file mode 100644
index 0000000000000000000000000000000000000000..ac2705a67e8b3abacffa57f097095b98afa1469c
--- /dev/null
+++ b/tools/include/nolibc/sys/resource.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Resource definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_SYS_RESOURCE_H
+#define _NOLIBC_SYS_RESOURCE_H
+
+#include "../sys.h"
+
+#include <linux/resource.h>
+
+/*
+ * int getrlimit(int resource, struct rlimit *rlim);
+ * int setrlimit(int resource, const struct rlimit *rlim);
+ */
+
+static __attribute__((unused))
+int sys_prlimit64(pid_t pid, int resource,
+		  const struct rlimit64 *new_limit, struct rlimit64 *old_limit)
+{
+	return my_syscall4(__NR_prlimit64, pid, resource, new_limit, old_limit);
+}
+
+static __attribute__((unused))
+int getrlimit(int resource, struct rlimit *rlim)
+{
+	struct rlimit64 rlim64;
+	int ret;
+
+	ret = __sysret(sys_prlimit64(0, resource, NULL, &rlim64));
+	rlim->rlim_cur = rlim64.rlim_cur;
+	rlim->rlim_max = rlim64.rlim_max;
+
+	return ret;
+}
+
+static __attribute__((unused))
+int setrlimit(int resource, const struct rlimit *rlim)
+{
+	struct rlimit64 rlim64 = {
+		.rlim_cur = rlim->rlim_cur,
+		.rlim_max = rlim->rlim_max,
+	};
+
+	return __sysret(sys_prlimit64(0, resource, &rlim64, NULL));
+}
+
+#endif /* _NOLIBC_SYS_RESOURCE_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 74c7694b2d5e54f7a86854697ac32a2ea2b62e86..2225c9388a46480a18e9ce603b08d846e5276bab 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -15,7 +15,6 @@
 #include <linux/stat.h>
 #include <linux/time.h>
 #include <linux/wait.h>
-#include <linux/resource.h>
 
 
 /* Only the generic macros and types may be defined here. The arch-specific

-- 
2.49.0


