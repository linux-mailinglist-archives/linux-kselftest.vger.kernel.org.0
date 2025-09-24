Return-Path: <linux-kselftest+bounces-42189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FFDB9A395
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874E97A26D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2A330CB20;
	Wed, 24 Sep 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OUMg+eFS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10D30C37A;
	Wed, 24 Sep 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723729; cv=none; b=QOJtefrkRqJu+GWa48K8N0OtV+9dhu7sAXTqhoPhbXHOYuy7hBZmsXwvXimCVkAQxj7QlojXUj3cGSzjlcQ1q9cepStFYsQa5eWN34fFM+KbCxf7HxODEX3zLvMqkaxfvC2DP4A95H5k78n1UG7VoQkbBAO5sZGUNtHC9e7Ovvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723729; c=relaxed/simple;
	bh=8cWdpKI/DnvDD347e7jyPxVXAEa3tbXsFCItO8RPDog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvbIv4R+zH25fAz1pT2MobRWjcstap6tgEuiLGBghFOvetqy0Uj1BoAQGw6YcvYEde6DyxmmJvqhKldP/evgFU0GRDRxelx0jtuLOpseCGmXbC4Kjm0585/0quyamrTr7PRb6G1hQGPwAXsGXI7YCMvvR+vZPBXSIyjIuQr9hIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OUMg+eFS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pzfcxmV9exnO/NrKu+9Abg5ORjXxzI+JoCHdX4YtSlk=;
	t=1758723727; x=1759933327; b=OUMg+eFSa6xCGjKI1O+SRdLwaJgRFmCowDcymCpKtzhhAKf
	BKTXd61MhW02SlNUjk0PhWgX3ehKuzu22sXY5MFtsRU2uis97GImJl0iLDAYzGQ7eR2XVSuSiNYU+
	LOesJoDcWSYZKXXHensGPY5pTQr7rkh99FkYfW7ceQAarpH3L+Upny8d30+dQPQEW7l5nIhNJfVE5
	ictNPImaBkq3l/EAnEdhXZQliqOTBZgI0JfYVQ1YM2YpkjrKmqFqciVZJx57vf4m6m8oOwhzeTy7Y
	MBk6XuuZExLXvmokxddv5PxH5iG7Z8VpyqS4LcwJXy+wkPrn1l9ViwEtsEJdG3Hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNb-000000090Bz-3jHh;
	Wed, 24 Sep 2025 16:22:02 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 10/12] tools/nolibc: add uio.h with readv and writev
Date: Wed, 24 Sep 2025 16:20:57 +0200
Message-ID: <20250924142059.527768-11-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Benjamin Berg <benjamin.berg@intel.com>

This is generally useful and struct iovec is also needed for other
purposes such as ptrace.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/uio.h               | 49 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  9 ++++
 4 files changed, 60 insertions(+)
 create mode 100644 tools/include/nolibc/sys/uio.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 143c2d2c2ba6..9bbbba32dac6 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -62,6 +62,7 @@ all_files := \
 		sys/time.h \
 		sys/timerfd.h \
 		sys/types.h \
+		sys/uio.h \
 		sys/utsname.h \
 		sys/wait.h \
 		time.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index c199ade200c2..b4bc1c9b883d 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -109,6 +109,7 @@
 #include "sys/sysmacros.h"
 #include "sys/time.h"
 #include "sys/timerfd.h"
+#include "sys/uio.h"
 #include "sys/utsname.h"
 #include "sys/wait.h"
 #include "ctype.h"
diff --git a/tools/include/nolibc/sys/uio.h b/tools/include/nolibc/sys/uio.h
new file mode 100644
index 000000000000..7ad42b927d2f
--- /dev/null
+++ b/tools/include/nolibc/sys/uio.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * uio for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
+#ifndef _NOLIBC_SYS_UIO_H
+#define _NOLIBC_SYS_UIO_H
+
+#include "../sys.h"
+#include <linux/uio.h>
+
+
+/*
+ * ssize_t readv(int fd, const struct iovec *iovec, int count);
+ */
+static __attribute__((unused))
+ssize_t sys_readv(int fd, const struct iovec *iovec, int count)
+{
+	return my_syscall3(__NR_readv, fd, iovec, count);
+}
+
+static __attribute__((unused))
+ssize_t readv(int fd, const struct iovec *iovec, int count)
+{
+	return __sysret(sys_readv(fd, iovec, count));
+}
+
+/*
+ * ssize_t writev(int fd, const struct iovec *iovec, int count);
+ */
+static __attribute__((unused))
+ssize_t sys_writev(int fd, const struct iovec *iovec, int count)
+{
+	return my_syscall3(__NR_writev, fd, iovec, count);
+}
+
+static __attribute__((unused))
+ssize_t writev(int fd, const struct iovec *iovec, int count)
+{
+	return __sysret(sys_writev(fd, iovec, count));
+}
+
+
+#endif /* _NOLIBC_SYS_UIO_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a297ee0d6d07..1907128bc3f6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -25,6 +25,7 @@
 #include <sys/sysmacros.h>
 #include <sys/time.h>
 #include <sys/timerfd.h>
+#include <sys/uio.h>
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
@@ -1283,6 +1284,10 @@ int run_syscall(int min, int max)
 	int proc;
 	int test;
 	int tmp;
+	struct iovec iov_one = {
+		.iov_base = &tmp,
+		.iov_len = 1,
+	};
 	int ret = 0;
 	void *p1, *p2;
 	int has_gettid = 1;
@@ -1395,6 +1400,10 @@ int run_syscall(int min, int max)
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
+		CASE_TEST(readv_badf);        EXPECT_SYSER(1, readv(-1, &iov_one, 1), -1, EBADF); break;
+		CASE_TEST(readv_zero);        EXPECT_SYSZR(1, readv(1, NULL, 0)); break;
+		CASE_TEST(writev_badf);       EXPECT_SYSER(1, writev(-1, &iov_one, 1), -1, EBADF); break;
+		CASE_TEST(writev_zero);       EXPECT_SYSZR(1, writev(1, NULL, 0)); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
 		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
-- 
2.51.0


