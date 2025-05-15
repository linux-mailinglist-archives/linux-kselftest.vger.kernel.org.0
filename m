Return-Path: <linux-kselftest+bounces-33135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D122AB9060
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C69A23262
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD229C32E;
	Thu, 15 May 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uT7Yn/JH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23429B79B;
	Thu, 15 May 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339108; cv=none; b=lYM4Vn2P3/fDJYxWEgLlrT9Dnuf83Vtb19YZy39EwwQ8CRW0vJoRxv/EuQUrMjJ/3uHN1uz3YrXs9cDcANM+mpW1O6zNhYEndTlPfk0ZaNspZSv41NasJwTfXyQPrPKl1duBO1vZ00N+EQz86lC/Df7CwSW2hFsmzHcP6LCiUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339108; c=relaxed/simple;
	bh=CEjTUvBGsnd69Gkp4Kcg41wqhm8jvAm1b9FkzCvqtDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPXAUKRA0imz2i8h301T4B3MVMXKqQxW349HXu2XuZ9GZxk3lYkCWsdd+Kv4gixd25zRfRoB2dgH0bM9a57vgASJVRsrVg4lcNh3sCte21WlzzR47HL6+meocbccJbInCb6Tiq0faXKrDKXAQ6lyfCvouYmrLPqW81/NZEICDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uT7Yn/JH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339094;
	bh=CEjTUvBGsnd69Gkp4Kcg41wqhm8jvAm1b9FkzCvqtDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uT7Yn/JHVpJOQTD9dj7EN5XnGoXwXqhmNRvJUUQq0K5ZNNLJMzGT3NPoedHqaaC0D
	 FL4Jjvu76p9qhG3uApaVsEXEBoYgzM+XxsbCZsEhwSIqTFI5e90xODgF3okFCDAg4f
	 kEK85uwl85hdObNm/YgUv5YpWfeaqPAYqwqvq4Io=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:52 +0200
Subject: [PATCH 6/9] tools/nolibc: move makedev() and friends to
 sys/sysmacros.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-6-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=2913;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CEjTUvBGsnd69Gkp4Kcg41wqhm8jvAm1b9FkzCvqtDU=;
 b=tLPjHehGTm0gr5f1D8hEuXArffa0vPCMgKHd0jfciSsFm3GwJESOOCMXYbIisD9hNj9RcAjIy
 UOV712DOT5ICiq0JTFIiMfldNmSNhSp2wRNuCtn8oAGNqS6OgjUi1mK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the location regular userspace expects these definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile        |  1 +
 tools/include/nolibc/nolibc.h        |  1 +
 tools/include/nolibc/sys/sysmacros.h | 20 ++++++++++++++++++++
 tools/include/nolibc/types.h         |  5 -----
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index cc82399e940e53940061b60588566db51f2e191a..ae04de46cdfeb2080d95b60c3d16e1c9f3692c9c 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -58,6 +58,7 @@ all_files := \
 		sys/resource.h \
 		sys/stat.h \
 		sys/syscall.h \
+		sys/sysmacros.h \
 		sys/time.h \
 		sys/timerfd.h \
 		sys/types.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 7d151776e47a30080dc3d961bcdeacd6ab558629..182dcfce126638db1cc9fd3fa79ab99835b42c26 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -106,6 +106,7 @@
 #include "sys/resource.h"
 #include "sys/stat.h"
 #include "sys/syscall.h"
+#include "sys/sysmacros.h"
 #include "sys/time.h"
 #include "sys/timerfd.h"
 #include "sys/wait.h"
diff --git a/tools/include/nolibc/sys/sysmacros.h b/tools/include/nolibc/sys/sysmacros.h
new file mode 100644
index 0000000000000000000000000000000000000000..e7e24dda1dbb51df92307def00f3670459b2409c
--- /dev/null
+++ b/tools/include/nolibc/sys/sysmacros.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Sysmacro definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_SYS_SYSMACROS_H
+#define _NOLIBC_SYS_SYSMACROS_H
+
+#include "../std.h"
+
+/* WARNING, it only deals with the 4096 first majors and 256 first minors */
+#define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
+#define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
+#define minor(dev) ((unsigned int)((dev) & 0xff))
+
+#endif /* _NOLIBC_SYS_SYSMACROS_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 2225c9388a46480a18e9ce603b08d846e5276bab..0071bfbc23154cf9b47b0bd747101fea4955018d 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -188,11 +188,6 @@ struct stat {
 typedef __kernel_clockid_t clockid_t;
 typedef int timer_t;
 
-/* WARNING, it only deals with the 4096 first majors and 256 first minors */
-#define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
-#define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
-#define minor(dev) ((unsigned int)((dev) & 0xff))
-
 #ifndef offsetof
 #define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
 #endif

-- 
2.49.0


