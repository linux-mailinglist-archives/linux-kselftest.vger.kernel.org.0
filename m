Return-Path: <linux-kselftest+bounces-33134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D8AB9056
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBBC1BA658A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED3E29B8ED;
	Thu, 15 May 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DUwMUHyM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2029B771;
	Thu, 15 May 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339107; cv=none; b=jGdQqbqOntMX+sgUy305mOMfkHYsgTYgJNCks8G5PxY8VyGzX3M3RhkgqoPgkUyTgb73tnySShm3tY/daoRscHKXpz4aXcrVh9upfPlT6ac1k3DtnLDar6Dcm87Gt/QID4styszpIYZe7/vYeYj1V9QsOOo/+s5fWt7QSNAGRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339107; c=relaxed/simple;
	bh=0DlqLIWaNZFpmu78FucI89rY5fHoKKK4yBF1UQkOheo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXeMWoE70EYLQjS65AGPrPYxec66JbrF1GgzjY+4I98fnXHBAyqSZ/qys2B+wQk7xbeTgWfQaT0rvg5jjl7ZPBtkzBxrT4LXD4Lyn4NJw/n6hscieevJfWKF1FGoB/MyqrhCQyycLrNcZ/a8i2qvcXB99UCbzZEb8oRpR//v7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DUwMUHyM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339094;
	bh=0DlqLIWaNZFpmu78FucI89rY5fHoKKK4yBF1UQkOheo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DUwMUHyMQ1VqtzBPwYQ5OUMWKYdS964RyInylMLwtwLSX8Oq5dWoLLmD3ENPGGqGP
	 rz3J5RURhLDTbK5s4s1H3ZC5jfeF/bM1fPwqgaSkW0f4BHp+WwMK/ohe270QW4Yl/R
	 z0LuwD+AWxADnrIe7XafdLXZjwSBQBiDDkN7pTWY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:53 +0200
Subject: [PATCH 7/9] tools/nolibc: move uname() and friends to
 sys/utsname.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-7-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=3394;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0DlqLIWaNZFpmu78FucI89rY5fHoKKK4yBF1UQkOheo=;
 b=/PBUSVE95jOqgccQhI1vDHW+C3v3VwYTppDHIjIPiz37KeqvFUgWnPoar034skO05NS85WZea
 7mwcaF/UiufAXXXK+Rod1hUWTf7Lm8W1crywgXx5s97uobOA2dMycWX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the location regular userspace expects these definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile      |  1 +
 tools/include/nolibc/nolibc.h      |  1 +
 tools/include/nolibc/sys.h         | 27 ------------------------
 tools/include/nolibc/sys/utsname.h | 42 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index ae04de46cdfeb2080d95b60c3d16e1c9f3692c9c..0ff06374577df457b0611d91dcfe637a05476364 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -62,6 +62,7 @@ all_files := \
 		sys/time.h \
 		sys/timerfd.h \
 		sys/types.h \
+		sys/utsname.h \
 		sys/wait.h \
 		time.h \
 		types.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 182dcfce126638db1cc9fd3fa79ab99835b42c26..c199ade200c240ef4081f767a162698256f39677 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -109,6 +109,7 @@
 #include "sys/sysmacros.h"
 #include "sys/time.h"
 #include "sys/timerfd.h"
+#include "sys/utsname.h"
 #include "sys/wait.h"
 #include "ctype.h"
 #include "elf.h"
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 282909b1992d17d5292917fbabb0bd2a2dbfce88..9556c69a6ae1ff0f19d884f5022599fc31e04f1f 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -23,7 +23,6 @@
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
-#include <linux/utsname.h>
 
 #include "errno.h"
 #include "stdarg.h"
@@ -894,32 +893,6 @@ int umount2(const char *path, int flags)
 }
 
 
-/*
- * int uname(struct utsname *buf);
- */
-
-struct utsname {
-	char sysname[65];
-	char nodename[65];
-	char release[65];
-	char version[65];
-	char machine[65];
-	char domainname[65];
-};
-
-static __attribute__((unused))
-int sys_uname(struct utsname *buf)
-{
-	return my_syscall1(__NR_uname, buf);
-}
-
-static __attribute__((unused))
-int uname(struct utsname *buf)
-{
-	return __sysret(sys_uname(buf));
-}
-
-
 /*
  * int unlink(const char *path);
  */
diff --git a/tools/include/nolibc/sys/utsname.h b/tools/include/nolibc/sys/utsname.h
new file mode 100644
index 0000000000000000000000000000000000000000..3adda115085069403253c2a276de1e2ae9bb1ad3
--- /dev/null
+++ b/tools/include/nolibc/sys/utsname.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Utsname definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_SYS_UTSNAME_H
+#define _NOLIBC_SYS_UTSNAME_H
+
+#include "../sys.h"
+
+#include <linux/utsname.h>
+
+/*
+ * int uname(struct utsname *buf);
+ */
+
+struct utsname {
+	char sysname[65];
+	char nodename[65];
+	char release[65];
+	char version[65];
+	char machine[65];
+	char domainname[65];
+};
+
+static __attribute__((unused))
+int sys_uname(struct utsname *buf)
+{
+	return my_syscall1(__NR_uname, buf);
+}
+
+static __attribute__((unused))
+int uname(struct utsname *buf)
+{
+	return __sysret(sys_uname(buf));
+}
+
+#endif /* _NOLIBC_SYS_UTSNAME_H */

-- 
2.49.0


