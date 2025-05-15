Return-Path: <linux-kselftest+bounces-33127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C920DAB904A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA63F9E56EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2827FB3A;
	Thu, 15 May 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="onIOrrC/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD01E480;
	Thu, 15 May 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339103; cv=none; b=gImD4lzuXElw+WromB9Yfe25tUodzAYY/eOPwS7gwAlFa6KIrMugiPZTEio3BCthJOHvbljj6LSqAmb5DaPKmV9YI54FyMHV+FlzAYimNQIX+smvy6+B/KcDXibFHKHIb/HYZz1nhCJqONr40fz3uKG9j/dY6QJeFvDYGkrwKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339103; c=relaxed/simple;
	bh=TvfFTWUEfp0HIUC1UiK0IdPOdFMzIQJdjD0UUr/+o0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTg11gh8NpbGoFBGYomH3vQgst2ytH+ajWu/F7ezeBPvf2Vn+U5599YjGIyWZNqZaJCzAOkDFc+kSnuPTAyaHB6PuiFiLhRT+pYLfELywl556lcuN331TRBm6jhUGbPRmf65n29hLzzPHerE7vzOfIAD4qMeD4mnwcz6iuc8Wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=onIOrrC/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339092;
	bh=TvfFTWUEfp0HIUC1UiK0IdPOdFMzIQJdjD0UUr/+o0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=onIOrrC/+PZ1lzbUoLwawy8U4RH/ZtuU/8dRKSoWIXcADDuulEl2wcEjKtUwJZ58A
	 OQ4w8PzPRkUZIqmEOxP6Aph1pMFtoBqwmjgZ887ipTHWbH4wtPHFEi3I7p10WsGHIg
	 zw4YVkf7Z7XQQprD82QR/dbZrLbx+DSHkstElIFg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:48 +0200
Subject: [PATCH 2/9] tools/nolibc: move mount() to sys/mount.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-2-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=3542;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TvfFTWUEfp0HIUC1UiK0IdPOdFMzIQJdjD0UUr/+o0E=;
 b=3/DdAFeh3tu/36+3/jAUkeF62jqtj70ad4s9nUWZmK/Uc1wpKjwUdm10kEnVnEN/OOD+FAhGG
 /sqeusOOkUDBl2wShHHSSINDHBnZdH0TaucQ+jK6TMgT0G7BUpMjaGl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the location regular userspace expects this definition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile    |  1 +
 tools/include/nolibc/nolibc.h    |  1 +
 tools/include/nolibc/sys.h       | 20 --------------------
 tools/include/nolibc/sys/mount.h | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 7d66847df91a94ca784c04ced278eb6d7099bab4..aa14dfddd77deb5442a6be65dee5684b6d218da7 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -51,6 +51,7 @@ all_files := \
 		sys/auxv.h \
 		sys/ioctl.h \
 		sys/mman.h \
+		sys/mount.h \
 		sys/random.h \
 		sys/stat.h \
 		sys/syscall.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index d6048d1e9ea5d4b5d504e156aafc5651dcd6b8c1..690368f8e46c33df37c824429cf89dd0e95bb806 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -99,6 +99,7 @@
 #include "sys/auxv.h"
 #include "sys/ioctl.h"
 #include "sys/mman.h"
+#include "sys/mount.h"
 #include "sys/random.h"
 #include "sys/stat.h"
 #include "sys/syscall.h"
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 313c210173c804f728b0be4ab8e67542bb3a7219..e66dd6e760557333353d98da2627b038dffe7f93 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -672,26 +672,6 @@ int mknod(const char *path, mode_t mode, dev_t dev)
 	return __sysret(sys_mknod(path, mode, dev));
 }
 
-/*
- * int mount(const char *source, const char *target,
- *           const char *fstype, unsigned long flags,
- *           const void *data);
- */
-static __attribute__((unused))
-int sys_mount(const char *src, const char *tgt, const char *fst,
-                     unsigned long flags, const void *data)
-{
-	return my_syscall5(__NR_mount, src, tgt, fst, flags, data);
-}
-
-static __attribute__((unused))
-int mount(const char *src, const char *tgt,
-          const char *fst, unsigned long flags,
-          const void *data)
-{
-	return __sysret(sys_mount(src, tgt, fst, flags, data));
-}
-
 
 /*
  * int pipe2(int pipefd[2], int flags);
diff --git a/tools/include/nolibc/sys/mount.h b/tools/include/nolibc/sys/mount.h
new file mode 100644
index 0000000000000000000000000000000000000000..5129420e716d0a7e75c32a5bbc8f4e9f0e21b03b
--- /dev/null
+++ b/tools/include/nolibc/sys/mount.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Mount definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_SYS_MOUNT_H
+#define _NOLIBC_SYS_MOUNT_H
+
+#include "../sys.h"
+
+#include <linux/mount.h>
+
+/*
+ * int mount(const char *source, const char *target,
+ *           const char *fstype, unsigned long flags,
+ *           const void *data);
+ */
+static __attribute__((unused))
+int sys_mount(const char *src, const char *tgt, const char *fst,
+	      unsigned long flags, const void *data)
+{
+	return my_syscall5(__NR_mount, src, tgt, fst, flags, data);
+}
+
+static __attribute__((unused))
+int mount(const char *src, const char *tgt,
+	  const char *fst, unsigned long flags,
+	  const void *data)
+{
+	return __sysret(sys_mount(src, tgt, fst, flags, data));
+}
+
+#endif /* _NOLIBC_SYS_MOUNT_H */

-- 
2.49.0


