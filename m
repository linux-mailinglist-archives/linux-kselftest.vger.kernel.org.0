Return-Path: <linux-kselftest+bounces-33131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E9EAB9050
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5FE1BA73E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175D129B215;
	Thu, 15 May 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JSV+bIcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45812269B07;
	Thu, 15 May 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339105; cv=none; b=NRS7eXYiQMUVSSs+OM6+6zuSpRgkxEj9jmpoqUjW4bMt8qSkoxvdu6LcO6zi5QnKgBW5mLtL27UMDEZS9ho6YapKocWvaTnpjNGlNoeWNaxLV/+xPnRI1pdcTe6MUrlDBNDxSBmj9oNCxjYaGAzFk4hY/GcRdBGOTt3VsW7aU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339105; c=relaxed/simple;
	bh=kSM1bMW0+DdV7v7mJM3vOo2rB0NxykmWPI2GBmXW580=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpMgL+3S89Lbo6Qzgp1pVIgpeagGmfKwE6hvMEugn/gxJbQbfogVM+GtyvNk0o89FnIGtxssovskaxG8oQPW9f36YRspRPafM+rStNr/dyzJnNnB+o2yXRFUeJz9xdbD26qDEuHbxwo1QGjVInF8wJqpfYZ5kzvzGDLMBs++aMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JSV+bIcU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339092;
	bh=kSM1bMW0+DdV7v7mJM3vOo2rB0NxykmWPI2GBmXW580=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JSV+bIcUPO2ZGvCByrzetPHwmG2F0KwurIrITftorgw2nkuqrLaVmIRGmt7JdtZnP
	 zXZBVXD4iIeZBTq998BMJE3Kq8EE2qAv2t5lVMQLsooOxr/Ylmmj1L0B7o3mVvt02a
	 IzpHUnFCCYXeY6V3hovIrf2Fqx9/W3w9ZjwWYVjg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:47 +0200
Subject: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=2838;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kSM1bMW0+DdV7v7mJM3vOo2rB0NxykmWPI2GBmXW580=;
 b=xdJfwjYCyN0LOEllnfA0IzlQCNpGMTh01WdmXuSRwrGbv2rIrDbF9EZji13+Z+v/wTo7cbqXQ
 X+yB9na3+5WBb4AixxJeHEEeg0Bs6E+ObS64cAXkcIKfwEGXwg00n1U
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the location regular userspace expects this definition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile    |  1 +
 tools/include/nolibc/nolibc.h    |  1 +
 tools/include/nolibc/sys.h       | 12 ------------
 tools/include/nolibc/sys/ioctl.h | 29 +++++++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 4c4b7b5ff605ac5dde11628331378489d76d4466..7d66847df91a94ca784c04ced278eb6d7099bab4 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -49,6 +49,7 @@ all_files := \
 		string.h \
 		sys.h \
 		sys/auxv.h \
+		sys/ioctl.h \
 		sys/mman.h \
 		sys/random.h \
 		sys/stat.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 51c423a36b5957e2528e94d717d88e2383230cba..d6048d1e9ea5d4b5d504e156aafc5651dcd6b8c1 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -97,6 +97,7 @@
 #include "types.h"
 #include "sys.h"
 #include "sys/auxv.h"
+#include "sys/ioctl.h"
 #include "sys/mman.h"
 #include "sys/random.h"
 #include "sys/stat.h"
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5733fe54911dca44c7423951ff85fb166d95c06f..313c210173c804f728b0be4ab8e67542bb3a7219 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -517,18 +517,6 @@ uid_t getuid(void)
 }
 
 
-/*
- * int ioctl(int fd, unsigned long cmd, ... arg);
- */
-
-static __attribute__((unused))
-long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	return my_syscall3(__NR_ioctl, fd, cmd, arg);
-}
-
-#define ioctl(fd, cmd, arg) __sysret(sys_ioctl(fd, cmd, (unsigned long)(arg)))
-
 /*
  * int kill(pid_t pid, int signal);
  */
diff --git a/tools/include/nolibc/sys/ioctl.h b/tools/include/nolibc/sys/ioctl.h
new file mode 100644
index 0000000000000000000000000000000000000000..cb34be92a5f96aa566afa53a0f19932c2d5fe1eb
--- /dev/null
+++ b/tools/include/nolibc/sys/ioctl.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Ioctl definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_SYS_IOCTL_H
+#define _NOLIBC_SYS_IOCTL_H
+
+#include "../sys.h"
+
+#include <linux/ioctl.h>
+
+/*
+ * int ioctl(int fd, unsigned long cmd, ... arg);
+ */
+
+static __attribute__((unused))
+long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	return my_syscall3(__NR_ioctl, fd, cmd, arg);
+}
+
+#define ioctl(fd, cmd, arg) __sysret(sys_ioctl(fd, cmd, (unsigned long)(arg)))
+
+#endif /* _NOLIBC_SYS_IOCTL_H */

-- 
2.49.0


