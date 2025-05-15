Return-Path: <linux-kselftest+bounces-33133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58BAB9055
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286551BC08D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848B429B8EA;
	Thu, 15 May 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rH2X/+Az"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4D29B76F;
	Thu, 15 May 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339107; cv=none; b=hBlmj7RkUJoRbyYwZqsDyJDHLgtrjkzaOXECmv3fXv5q+9FzoOoxTRaNc736n/+N6e3rpYmbjBLX8WdWJ83Xf9zB3CDT2o6UiL4z2LcOSdLjh5ZG9Bx+0o2pKkK8v7bLlJ42UCAmmM90IKIUlc7gF2znW9l8a35DjkCnuEsKD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339107; c=relaxed/simple;
	bh=0mUa7QIK52LFZ5X4Py+boeWdALPA3eeNNCjqgmKvvE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXOtaYalHRxWmJtSgtVtYDmRIvUdBkJi5N/6E65OAq22fwxQdCKWk2BUhtClrEnLgjcDaVmW3cM+GRWw6T4JE1e+xApoIZ+vX0mh++nAW4qisWiyGxSLIXOt/tJF9Vj10tI8H91VpQrxHiU7zybYitPbUE9OI9kDpfPHIOf9XA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rH2X/+Az; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339094;
	bh=0mUa7QIK52LFZ5X4Py+boeWdALPA3eeNNCjqgmKvvE0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rH2X/+Az5uUP7XoRLT8SXA54BpMrre2+Detrzbnc2uWAQ8u6+wnTOdrTWMlWY5zuD
	 +gVKPoc5KoEB3oL8FiiRCUrUH1gYwkCgczfBR3/ECfRoBJvGWDQAmnaZRgAknXVUaV
	 nSZNzPZUWM/e/kYCAmfnYVqzWDCGD0dg2RuGjvXA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:54 +0200
Subject: [PATCH 8/9] tools/nolibc: move NULL and offsetof() to sys/stddef.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-8-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=2694;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0mUa7QIK52LFZ5X4Py+boeWdALPA3eeNNCjqgmKvvE0=;
 b=aUalZNrMbnWgHJrEn8oTpfJ68qOXis1S1o0rQvrjZrrFqVyYaJtwi8yRxUN/hXtejpJ4n1mQc
 y7o6s4xMsFtCzMIOXJ4W0J5GPlaIV5UGUNmW/kR8cPqWEcu2zWC3Qri
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the location regular userspace expects these definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile |  1 +
 tools/include/nolibc/std.h    |  6 +-----
 tools/include/nolibc/stddef.h | 24 ++++++++++++++++++++++++
 tools/include/nolibc/types.h  |  4 ----
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 0ff06374577df457b0611d91dcfe637a05476364..c4615bed731ced75a00867fdeb455d72652a7e42 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -44,6 +44,7 @@ all_files := \
 		std.h \
 		stdarg.h \
 		stdbool.h \
+		stddef.h \
 		stdint.h \
 		stdlib.h \
 		string.h \
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 933bc0be7e1c6be3b7909efc127f1d3b9c611135..adda7333d12e7d2c336938ede1aaf215b4b93165 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -13,12 +13,8 @@
  * syscall-specific stuff, as this file is expected to be included very early.
  */
 
-/* note: may already be defined */
-#ifndef NULL
-#define NULL ((void *)0)
-#endif
-
 #include "stdint.h"
+#include "stddef.h"
 
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
diff --git a/tools/include/nolibc/stddef.h b/tools/include/nolibc/stddef.h
new file mode 100644
index 0000000000000000000000000000000000000000..ecbd13eab1f5190fd0e90a07699c2f06dbde8916
--- /dev/null
+++ b/tools/include/nolibc/stddef.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Stddef definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#ifndef _NOLIBC_STDDEF_H
+#define _NOLIBC_STDDEF_H
+
+#include "stdint.h"
+
+/* note: may already be defined */
+#ifndef NULL
+#define NULL ((void *)0)
+#endif
+
+#ifndef offsetof
+#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
+#endif
+
+#endif /* _NOLIBC_STDDEF_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 0071bfbc23154cf9b47b0bd747101fea4955018d..30904be544ed01b212042ebc0f4dab610f64b216 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -188,10 +188,6 @@ struct stat {
 typedef __kernel_clockid_t clockid_t;
 typedef int timer_t;
 
-#ifndef offsetof
-#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
-#endif
-
 #ifndef container_of
 #define container_of(PTR, TYPE, FIELD) ({			\
 	__typeof__(((TYPE *)0)->FIELD) *__FIELD_PTR = (PTR);	\

-- 
2.49.0


