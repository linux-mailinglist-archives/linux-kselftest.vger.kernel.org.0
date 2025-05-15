Return-Path: <linux-kselftest+bounces-33128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07282AB904B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024DE9E58B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066DE28D8E6;
	Thu, 15 May 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="seytGuxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802D22A7F8;
	Thu, 15 May 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339103; cv=none; b=naKQYVbKqNC8Nrc8y0q+xuM3XtJgMX//xSCFVsRAwyHcpiss9MuKei+Zs6IGZRLv25LbMY03F/RMlMDHKp9I7NXZK/NPmZEn9NLljMdf+Bzos4wCG8xLuICbevkAey/nImHpNAEi6DMImTjjtpTBhBCnQ4IRsKQ3syH8Wjp9JO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339103; c=relaxed/simple;
	bh=6ju7nF+tBZi6mC9sCNOtoJsGxPO0pmE/TqOSGXTWTzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LAZ6iGGjMxuzpH7hl3rrX8tIxKwZcU/8iO18vHj8AoBVPly/m+jmYM9GqK5DdHdlUdvnavFHBMJr62GjM7OUnFG2I70HniOrj/Bq4S3/Da+CNEnT0Hb1wkJUrqDWafQrP/5lmm311nzXETQbXcxE+f323nwCLcp4i/YCgRZnKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=seytGuxw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339092;
	bh=6ju7nF+tBZi6mC9sCNOtoJsGxPO0pmE/TqOSGXTWTzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=seytGuxw3gxPAeBk5B9roGmljvZ1ZCl/q+zVz2Wqor0gMjb8Za18TErVdc+2Ntm6Z
	 xGrKSlDzk6P+xobEXg5iNgeT/hbzIZ40mLOLpv9Dxs80++d/DFblRm0TRryYXmSxuu
	 AhPw00RKP3p45kGteC9wy2BOP9XWTNUpflxSzkwM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:49 +0200
Subject: [PATCH 3/9] tools/nolibc: move prctl() to sys/prctl.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-3-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=3708;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6ju7nF+tBZi6mC9sCNOtoJsGxPO0pmE/TqOSGXTWTzE=;
 b=DKoJcu6B05RRtO1W6ivagl4rdN0VPAmtvnTW35t+IJ4T2vzjmqQTPvXdmwMuNoAElwdPKlzVy
 7tvKkoq1MX/DemTXpbIHsvrW0b4ACw+bz6HHyDcnyFEWIfA4egcMAIf
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the location regular userspace expects this definition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile    |  1 +
 tools/include/nolibc/nolibc.h    |  1 +
 tools/include/nolibc/sys.h       | 21 ---------------------
 tools/include/nolibc/sys/prctl.h | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index aa14dfddd77deb5442a6be65dee5684b6d218da7..35cfbc84d499b0a57689bdfed95a45023904d256 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -52,6 +52,7 @@ all_files := \
 		sys/ioctl.h \
 		sys/mman.h \
 		sys/mount.h \
+		sys/prctl.h \
 		sys/random.h \
 		sys/stat.h \
 		sys/syscall.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 690368f8e46c33df37c824429cf89dd0e95bb806..1c159e32a248d46fa4d36a2c35e92eb9da91e9f6 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -100,6 +100,7 @@
 #include "sys/ioctl.h"
 #include "sys/mman.h"
 #include "sys/mount.h"
+#include "sys/prctl.h"
 #include "sys/random.h"
 #include "sys/stat.h"
 #include "sys/syscall.h"
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index e66dd6e760557333353d98da2627b038dffe7f93..a17fe98968a29081661eaf235111482a543f87ba 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -23,7 +23,6 @@
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
-#include <linux/prctl.h>
 #include <linux/resource.h>
 #include <linux/utsname.h>
 
@@ -697,26 +696,6 @@ int pipe(int pipefd[2])
 }
 
 
-/*
- * int prctl(int option, unsigned long arg2, unsigned long arg3,
- *                       unsigned long arg4, unsigned long arg5);
- */
-
-static __attribute__((unused))
-int sys_prctl(int option, unsigned long arg2, unsigned long arg3,
-		          unsigned long arg4, unsigned long arg5)
-{
-	return my_syscall5(__NR_prctl, option, arg2, arg3, arg4, arg5);
-}
-
-static __attribute__((unused))
-int prctl(int option, unsigned long arg2, unsigned long arg3,
-		      unsigned long arg4, unsigned long arg5)
-{
-	return __sysret(sys_prctl(option, arg2, arg3, arg4, arg5));
-}
-
-
 /*
  * int pivot_root(const char *new, const char *old);
  */
diff --git a/tools/include/nolibc/sys/prctl.h b/tools/include/nolibc/sys/prctl.h
new file mode 100644
index 0000000000000000000000000000000000000000..778a6a868823ce496f0f5482a58a31d69afd6d30
--- /dev/null
+++ b/tools/include/nolibc/sys/prctl.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Prctl definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_SYS_PRCTL_H
+#define _NOLIBC_SYS_PRCTL_H
+
+#include "../sys.h"
+
+#include <linux/prctl.h>
+
+/*
+ * int prctl(int option, unsigned long arg2, unsigned long arg3,
+ *                       unsigned long arg4, unsigned long arg5);
+ */
+
+static __attribute__((unused))
+int sys_prctl(int option, unsigned long arg2, unsigned long arg3,
+			  unsigned long arg4, unsigned long arg5)
+{
+	return my_syscall5(__NR_prctl, option, arg2, arg3, arg4, arg5);
+}
+
+static __attribute__((unused))
+int prctl(int option, unsigned long arg2, unsigned long arg3,
+		      unsigned long arg4, unsigned long arg5)
+{
+	return __sysret(sys_prctl(option, arg2, arg3, arg4, arg5));
+}
+
+#endif /* _NOLIBC_SYS_PRCTL_H */

-- 
2.49.0


