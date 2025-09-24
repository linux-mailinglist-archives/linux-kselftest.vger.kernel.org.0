Return-Path: <linux-kselftest+bounces-42190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86765B9A396
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25CE19C7E8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE73430CDA1;
	Wed, 24 Sep 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XVe7RLfd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300273074A1;
	Wed, 24 Sep 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723730; cv=none; b=XVkuPRWZ5QyMJ2SVDFk5A4SfhIIq8QSLv32/x9+1e8NcGjiBqAJwmHxzAPoABPvwQtwlpp3lO89e6SAVaowkchsJH5wBz8vtmtY4OY1d7+JYlnlcy1e04Z8fPBSXztzJSX/QW6AwqLm5El+nF2nOQCmBEe5t2f165pTIT5coRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723730; c=relaxed/simple;
	bh=awqLisS4+otzT1VzhnP+JfaunUlrH6eUNHWKFX7pyDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t12v8OHAQevQteTx+d+sYcTzljZXRJej39CFIcrugQKlz8H8HuQK+QbTtN3qzx/iAxIyays3BiuqmlK7OfmwMB0eWySLMAspCYKCu8wHqKxd5jglHGSHTs3rItDr0+aK72OsyXhO3/5WQ1J+6cBj+gaaIwPTQm2gDlSZAygjtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XVe7RLfd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LP9bDhgXxCDJw6Oc9+3jyKgig0nV2Eyo34N0Tx+L9L8=;
	t=1758723729; x=1759933329; b=XVe7RLfdY3ysDIPpzeINMed1kXnyzyZkgdpcJTBKgHLsAUu
	SCPpex4xT5q455EMQr+G44kjY9GuCFSVec3o8fFSkMwYPh5Zc+vZMXZr3U+NHpdfE+qxbAS8a1YTm
	AveUUx3UF5dogHRYaSAyACEM0ihn4xaWSt9Q8p1/dH20T5blRZ3/Br+aQUFdiNiNp1M4UAYR/efMi
	egruJCcu8HuLlYiZtK80JIq8OLnrQTII4OtFQDItyENHqAWbQn4EcRvD5eBJa1N7OCp61ck6f+wAJ
	N/Scq7UavMeIX7+9ur1E+bqrKs2//+Oobxz2zVJcz28jqT65+tII2e8GtwNDQtUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNg-000000090Bz-25Cd;
	Wed, 24 Sep 2025 16:22:04 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 11/12] tools/nolibc: add ptrace support
Date: Wed, 24 Sep 2025 16:20:58 +0200
Message-ID: <20250924142059.527768-12-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Add ptrace support, as it will be useful in UML.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---
v3:
- Only use variardic for ptrace and not for sys_ptrace
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/ptrace.h            | 44 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 +
 4 files changed, 48 insertions(+)
 create mode 100644 tools/include/nolibc/sys/ptrace.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 9bbbba32dac6..8e0cac3ac522 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -53,6 +53,7 @@ all_files := \
 		sys/mman.h \
 		sys/mount.h \
 		sys/prctl.h \
+		sys/ptrace.h \
 		sys/random.h \
 		sys/reboot.h \
 		sys/resource.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index b4bc1c9b883d..590eef545ca6 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -101,6 +101,7 @@
 #include "sys/mman.h"
 #include "sys/mount.h"
 #include "sys/prctl.h"
+#include "sys/ptrace.h"
 #include "sys/random.h"
 #include "sys/reboot.h"
 #include "sys/resource.h"
diff --git a/tools/include/nolibc/sys/ptrace.h b/tools/include/nolibc/sys/ptrace.h
new file mode 100644
index 000000000000..5d1e52965878
--- /dev/null
+++ b/tools/include/nolibc/sys/ptrace.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * ptrace for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
+#ifndef _NOLIBC_SYS_PTRACE_H
+#define _NOLIBC_SYS_PTRACE_H
+
+#include "../sys.h"
+#include "uio.h"
+
+
+#include <linux/ptrace.h>
+
+/*
+ * long ptrace(int op, pid_t pid, void *addr, void *data);
+ */
+static __attribute__((unused))
+long sys_ptrace(int op, pid_t pid, void *addr, void *data)
+{
+	return my_syscall4(__NR_ptrace, op, pid, addr, data);
+}
+
+static __attribute__((unused))
+ssize_t ptrace(int op, pid_t pid, ...)
+{
+	ssize_t ret;
+	va_list args;
+
+	va_start(args, pid);
+	ret = __sysret(sys_ptrace(op, pid,
+				  va_arg(args, void *),
+				  va_arg(args, void *)));
+	va_end(args);
+
+	return ret;
+}
+
+#endif /* _NOLIBC_SYS_PTRACE_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1907128bc3f6..4c1b9ee32b7d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -17,6 +17,7 @@
 #include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
+#include <sys/ptrace.h>
 #include <sys/random.h>
 #include <sys/reboot.h>
 #include <sys/resource.h>
@@ -1404,6 +1405,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(readv_zero);        EXPECT_SYSZR(1, readv(1, NULL, 0)); break;
 		CASE_TEST(writev_badf);       EXPECT_SYSER(1, writev(-1, &iov_one, 1), -1, EBADF); break;
 		CASE_TEST(writev_zero);       EXPECT_SYSZR(1, writev(1, NULL, 0)); break;
+		CASE_TEST(ptrace);            EXPECT_SYSER(1, ptrace(PTRACE_CONT, getpid(), NULL, NULL), -1, ESRCH); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
 		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
-- 
2.51.0


