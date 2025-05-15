Return-Path: <linux-kselftest+bounces-33129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27919AB904E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40239E5578
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A9298244;
	Thu, 15 May 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Oete7QE9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809825A646;
	Thu, 15 May 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339104; cv=none; b=kpBfkENUyIaxX+dJzGtrvyU7akIvDOhGL92IzT7NIZmhPIur3Z0Rc52z1g8OE2ujiSSKLVxa+VSSxDcF2bXC2f5j4NrOJmCcBxvJRstL04sw+Ycf1qbJB8s8Stbfo+eAr6gRsPQ8ugvjaq33dEw5IcbzhHL2Ra09YQ0Ca8YD3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339104; c=relaxed/simple;
	bh=Pg5hG2NXJIJ2AsojvxyH+DEumI/6ZQZsHN1YJrvIni4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmKsga/GzL21hovK4gk/YXlaPpRkHfbboJKQ47zdopB/0RReYmhf49hDfPFrjSEShegu2SkrRYx8LHGUz9SX+xtkCdRJWBnZcqlAbXdQJtM2Yutm5wmpRevdh/TYkXwvr7oM91tcOA0aDK9AUcxCgJQkQJ6FQIV4/yPO8onJm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Oete7QE9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339092;
	bh=Pg5hG2NXJIJ2AsojvxyH+DEumI/6ZQZsHN1YJrvIni4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oete7QE9FEy5ARoDlAAWYcFZ+QJWuJ3IO3NylIUU1Ff+JUNVWUFO1hYTw0uXoteYW
	 rBYLiFPr/LZIud10uikynE7UtEMPHAzehHC1/jujNc5oNyYSGNg4kGQZX4qph/mnti
	 Y6V1wPkoGbxNgwgeVaNIkIAU+eLlRhHmwdMdHyEA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:50 +0200
Subject: [PATCH 4/9] tools/nolibc: move reboot() to sys/reboot.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-4-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=3644;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Pg5hG2NXJIJ2AsojvxyH+DEumI/6ZQZsHN1YJrvIni4=;
 b=TXd33KbCdsy+Zqu3NmNWddnRa1h3aM9OEjjUt42dUhnIxfEm+M4UhoPoO/m/Fs4rLG4aqsr3J
 GJT56Y8bS46AfNRjiQtZjGLW2IjERegD1KrQ+IHbZ+SH0LnR1vmw6zc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the location regular userspace expects this definition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile     |  1 +
 tools/include/nolibc/nolibc.h     |  1 +
 tools/include/nolibc/sys.h        | 18 ------------------
 tools/include/nolibc/sys/reboot.h | 34 ++++++++++++++++++++++++++++++++++
 tools/include/nolibc/types.h      |  1 -
 5 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 35cfbc84d499b0a57689bdfed95a45023904d256..4850501b8d53be6b603ecbb04d6f952cd5370cf0 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -54,6 +54,7 @@ all_files := \
 		sys/mount.h \
 		sys/prctl.h \
 		sys/random.h \
+		sys/reboot.h \
 		sys/stat.h \
 		sys/syscall.h \
 		sys/time.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 1c159e32a248d46fa4d36a2c35e92eb9da91e9f6..36ea7a02c7434cc006a7b12d413add04a2f85565 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -102,6 +102,7 @@
 #include "sys/mount.h"
 #include "sys/prctl.h"
 #include "sys/random.h"
+#include "sys/reboot.h"
 #include "sys/stat.h"
 #include "sys/syscall.h"
 #include "sys/time.h"
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index a17fe98968a29081661eaf235111482a543f87ba..6c89dd0316dd0ebf03ebde6fa5c14273df6a0c62 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -730,24 +730,6 @@ ssize_t read(int fd, void *buf, size_t count)
 }
 
 
-/*
- * int reboot(int cmd);
- * <cmd> is among LINUX_REBOOT_CMD_*
- */
-
-static __attribute__((unused))
-ssize_t sys_reboot(int magic1, int magic2, int cmd, void *arg)
-{
-	return my_syscall4(__NR_reboot, magic1, magic2, cmd, arg);
-}
-
-static __attribute__((unused))
-int reboot(int cmd)
-{
-	return __sysret(sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0));
-}
-
-
 /*
  * int getrlimit(int resource, struct rlimit *rlim);
  * int setrlimit(int resource, const struct rlimit *rlim);
diff --git a/tools/include/nolibc/sys/reboot.h b/tools/include/nolibc/sys/reboot.h
new file mode 100644
index 0000000000000000000000000000000000000000..727363fbfd8a6f8994a0cf13829b7347ced198bb
--- /dev/null
+++ b/tools/include/nolibc/sys/reboot.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Reboot definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_SYS_REBOOT_H
+#define _NOLIBC_SYS_REBOOT_H
+
+#include "../sys.h"
+
+#include <linux/reboot.h>
+
+/*
+ * int reboot(int cmd);
+ * <cmd> is among LINUX_REBOOT_CMD_*
+ */
+
+static __attribute__((unused))
+ssize_t sys_reboot(int magic1, int magic2, int cmd, void *arg)
+{
+	return my_syscall4(__NR_reboot, magic1, magic2, cmd, arg);
+}
+
+static __attribute__((unused))
+int reboot(int cmd)
+{
+	return __sysret(sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0));
+}
+
+#endif /* _NOLIBC_SYS_REBOOT_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 93da29fe7719c9f196fba38d1f3f31cad0fc02f1..74c7694b2d5e54f7a86854697ac32a2ea2b62e86 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -12,7 +12,6 @@
 
 #include "std.h"
 #include <linux/mman.h>
-#include <linux/reboot.h> /* for LINUX_REBOOT_* */
 #include <linux/stat.h>
 #include <linux/time.h>
 #include <linux/wait.h>

-- 
2.49.0


