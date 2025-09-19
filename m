Return-Path: <linux-kselftest+bounces-41971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F48B8A55B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970FF3B1B1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBB31DD85;
	Fri, 19 Sep 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FBC2YWFr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14131D369;
	Fri, 19 Sep 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296176; cv=none; b=iWRUGGiY9I1fCa/m4GEp0VOk1fpNu9QpekrUVBVYras00ysfxRj++7dFCu5G3VF2QHfV+ulfeGij9e6c2Tni92osS8g7dN8sTZUlt4vRs5mwNtsXC7N280QKa0NzxtsAVU7mXFlIsXPmAiUKXuLvK0njVh2FbHM371CH5qBigMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296176; c=relaxed/simple;
	bh=rJjlvQq2edYfrYlSPc09wTCxHjzMxtUi0IeHlrgomMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPjHtEJhbczKavkBnEJQxsyYfeI+kQbh6Mtpigsn4XrnxdD6BT4OYlR/iwtISy8xjmCtcsh51rGUYzwSV2yR+W/SGFGxuK9gZheMk5xZ2HMcy0R6As5LEvaOiX+Gjs0a1aRpSbp9cd7MCdGJ+M8K8kFmGqn3hXLlew34A/v7Hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FBC2YWFr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RXl6ubRbFlom4y2e4H1GJqpLZi638eTvTDwJgOCQyw8=;
	t=1758296174; x=1759505774; b=FBC2YWFrEcRv7WbqI/XbgqRjtwxu+bDY/6kup4e3sr5BAkE
	hXywxPWRlzVTaF2cqEoxCVWzqdV6czu/PcrcsYrEY3GuV8WzPAeDZsnYI33L29lAmdMjfxV3iAqIY
	KLLHIze5TP4kMkDxFP3T+2cHcNT2v792gTCU1vZvgyUrOJuLiRAW2Mng/6f2Ct2c/4NHcgGR8YSDK
	saIIsdM3wXg2hrFvmXstn7kMeBMINp6r83Vx4zMDPmG6kmEryNBShLURfltAD7bNCEUTylUSxv/rm
	eHiZDniWu3K8+fM5hLYMgzuSmShfRzPynD2MOpsRFZQEqNWgJNB6pUsrz0FCl24w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9f-0000000G6O6-0Sob;
	Fri, 19 Sep 2025 17:36:11 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 10/11] tools/nolibc: add ptrace support
Date: Fri, 19 Sep 2025 17:34:19 +0200
Message-ID: <20250919153420.727385-11-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
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
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/ptrace.h            | 52 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 +
 4 files changed, 56 insertions(+)
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
index 000000000000..3119abdeeecb
--- /dev/null
+++ b/tools/include/nolibc/sys/ptrace.h
@@ -0,0 +1,52 @@
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
+ *
+ * However, addr may also be an integer in some cases.
+ */
+static __attribute__((unused))
+long sys_vptrace(int op, pid_t pid, va_list args)
+{
+	return my_syscall4(__NR_ptrace, op, pid,
+			   va_arg(args, void *), va_arg(args, void *));
+}
+
+static __attribute__((unused))
+ssize_t sys_ptrace(int op, pid_t pid, ...)
+{
+	va_list args;
+
+	va_start(args, pid);
+	return sys_vptrace(op, pid, args);
+	va_end(args);
+}
+
+static __attribute__((unused))
+ssize_t ptrace(int op, pid_t pid, ...)
+{
+	va_list args;
+
+	va_start(args, pid);
+	return __sysret(sys_vptrace(op, pid, args));
+	va_end(args);
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


