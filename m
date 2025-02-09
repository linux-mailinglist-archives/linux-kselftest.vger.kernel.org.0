Return-Path: <linux-kselftest+bounces-26132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F19A2DE0B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 14:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEF616574B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DDF1DE3B8;
	Sun,  9 Feb 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NJd6W27S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93C1D61B5;
	Sun,  9 Feb 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739107556; cv=none; b=mNkDVd/ZjAjxeOgPHmX74PH/NsGCSkkRx+ZidSCNlYdbPPE1XJphdUQFfhniqWLletxPKG0mLarH7+UM6AqJY5ja+A6zexFFLHNcGpFxLIqrTJNaak7reORe/1vx3ds7Pbz8ClRkdaNuGrl1Y2g6xHXbm0bBQuECPmI0DBvrj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739107556; c=relaxed/simple;
	bh=WjVyDvzXit8LE7L5BGe98GWQH/dYHunZsipbsQ1lOuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aK17H5MesScM5wUmGaPDIm0T+wMN1b95dD9qsNBPvvaB/t/L2pjEIbV6NbobUp13pnufK+hvuvU9b+SrxebVrQOPrf5ycdLKw8vAw8Gj0Q/iB+MkoNp++qZybsmyUd3dK3ZGF3du2xnmyMzEifZ30f6skCuE4eQ3lgxjsC9MCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NJd6W27S; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739107550;
	bh=WjVyDvzXit8LE7L5BGe98GWQH/dYHunZsipbsQ1lOuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NJd6W27SZfOGiEfK1IU3D0yY3jqfk/QinC1iSAu/m7NJ3C5M+9LLa1KuLlfn6XOI9
	 ttFPdvjrEhPzxO1JBwCiAdrxsqx5K0TWwJmVxdIF1fgaiox44Jlu/LM72/OfzPccxr
	 LnMqpaw6tzu3NuMJImKjQqKLcOKY7t5V5EpPc3Dc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Feb 2025 14:25:46 +0100
Subject: [PATCH v2 2/2] tools/nolibc: add support for directory access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250209-nolibc-dir-v2-2-57cc1da8558b@weissschuh.net>
References: <20250209-nolibc-dir-v2-0-57cc1da8558b@weissschuh.net>
In-Reply-To: <20250209-nolibc-dir-v2-0-57cc1da8558b@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739107550; l=5637;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uiJbgPei12+itcfIBRJ+oWT2TJzWv5EOINTxxNj/iwE=;
 b=3oUv9eUqBx9pN91b9HwCN5S/LXPwd36UpQ9Pp+bpVkccJJH5v8yPvLV1qO8Cfy4iMLMqg75t9
 41GO7O8GEhqAvR0rUlEibULcV5jFShrZone5DtOlVofqCrwGYOfkY2o
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Add an implementation for directory access operations.
To keep nolibc itself allocation-free, a "DIR *" does not point to any
data, but directly encodes a filedescriptor number, equivalent to "FILE *".
Without any per-directory storage it is not possible to implement
readdir() POSIX confirming. Instead only readdir_r() is provided.
While readdir_r() is deprecated in glibc, the reasons for that are
not applicable to nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/dirent.h                | 98 ++++++++++++++++++++++++++++
 tools/include/nolibc/nolibc.h                |  1 +
 tools/testing/selftests/nolibc/nolibc-test.c | 39 +++++++++++
 4 files changed, 139 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index a1f55fb24bb38c1f49c653af5825e8bcc569a56d..dceec0e1a135119108d6f4dcb3d2ec57c002ffd3 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -29,6 +29,7 @@ all_files := \
 		compiler.h \
 		crt.h \
 		ctype.h \
+		dirent.h \
 		errno.h \
 		nolibc.h \
 		signal.h \
diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
new file mode 100644
index 0000000000000000000000000000000000000000..c5c30d0dd6806b1bec2fa8120a3df29aaa201393
--- /dev/null
+++ b/tools/include/nolibc/dirent.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Directory access for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_DIRENT_H
+#define _NOLIBC_DIRENT_H
+
+#include "stdint.h"
+#include "types.h"
+
+#include <linux/limits.h>
+
+struct dirent {
+	ino_t	d_ino;
+	char	d_name[NAME_MAX + 1];
+};
+
+/* See comment of FILE in stdio.h */
+typedef struct {
+	char dummy[1];
+} DIR;
+
+static __attribute__((unused))
+DIR *fdopendir(int fd)
+{
+	if (fd < 0) {
+		SET_ERRNO(EBADF);
+		return NULL;
+	}
+	return (DIR *)(intptr_t)~fd;
+}
+
+static __attribute__((unused))
+DIR *opendir(const char *name)
+{
+	int fd;
+
+	fd = open(name, O_RDONLY);
+	if (fd == -1)
+		return NULL;
+	return fdopendir(fd);
+}
+
+static __attribute__((unused))
+int closedir(DIR *dirp)
+{
+	intptr_t i = (intptr_t)dirp;
+
+	if (i >= 0) {
+		SET_ERRNO(EBADF);
+		return -1;
+	}
+	return close(~i);
+}
+
+static __attribute__((unused))
+int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
+{
+	char buf[sizeof(struct linux_dirent64) + NAME_MAX + 1];
+	struct linux_dirent64 *ldir = (void *)buf;
+	intptr_t i = (intptr_t)dirp;
+	int fd, ret;
+
+	if (i >= 0)
+		return EBADF;
+
+	fd = ~i;
+
+	ret = sys_getdents64(fd, ldir, sizeof(buf));
+	if (ret < 0)
+		return -ret;
+	if (ret == 0) {
+		*result = NULL;
+		return 0;
+	}
+
+	/*
+	 * getdents64() returns as many entries as fit the buffer.
+	 * readdir() can only return one entry at a time.
+	 * Make sure the non-returned ones are not skipped.
+	 */
+	ret = lseek(fd, ldir->d_off, SEEK_SET);
+	if (ret == -1)
+		return errno;
+
+	entry->d_ino = ldir->d_ino;
+	/* the destination should always be big enough */
+	strlcpy(entry->d_name, ldir->d_name, sizeof(entry->d_name));
+	*result = entry;
+	return 0;
+}
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#endif /* _NOLIBC_DIRENT_H */
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 92436b1e44413e659b3cca592930aad8b458cb74..05d92afedb7258f0e3c311bf6f12be68b25d6e9a 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -105,6 +105,7 @@
 #include "string.h"
 #include "time.h"
 #include "stackprotector.h"
+#include "dirent.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f162793b162f9b1ec687098b9094a6d247a53e99..798fbdcd3ff8c36b514feb3fa1c7b8d7701cccd7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -769,6 +769,44 @@ int test_getdents64(const char *dir)
 	return ret;
 }
 
+static int test_dirent(void)
+{
+	int comm = 0, cmdline = 0;
+	struct dirent dirent, *result;
+	DIR *dir;
+	int ret;
+
+	dir = opendir("/proc/self");
+	if (!dir)
+		return 1;
+
+	while (1) {
+		errno = 0;
+		ret = readdir_r(dir, &dirent, &result);
+		if (ret != 0)
+			return 1;
+		if (!result)
+			break;
+
+		if (strcmp(dirent.d_name, "comm") == 0)
+			comm++;
+		else if (strcmp(dirent.d_name, "cmdline") == 0)
+			cmdline++;
+	}
+
+	if (errno)
+		return 1;
+
+	ret = closedir(dir);
+	if (ret)
+		return 1;
+
+	if (comm != 1 || cmdline != 1)
+		return 1;
+
+	return 0;
+}
+
 int test_getpagesize(void)
 {
 	int x = getpagesize();
@@ -1061,6 +1099,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
+		CASE_TEST(directories);       EXPECT_SYSZR(proc, test_dirent()); break;
 		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
 		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;

-- 
2.48.1


