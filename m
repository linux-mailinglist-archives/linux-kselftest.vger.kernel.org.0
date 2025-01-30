Return-Path: <linux-kselftest+bounces-25434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD3A234E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B5B165B12
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16BA1F1305;
	Thu, 30 Jan 2025 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rB/HccV3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020F199939;
	Thu, 30 Jan 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266858; cv=none; b=Xz2+fGhyc0Hgeauve56x4VZbZta6U6PPlGb9KvoVbgMvCwDAup0cc2gTFn0vTpXv4kskH/zrQj2LiQeEBqua3oVicFuJH6KTiwibqIbgn5u0+rla1M23y1652vBFrSAba8u54CNxGCbOdLZHaGkhUB3c9S4D9aGh8/r3XoF7OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266858; c=relaxed/simple;
	bh=lD165NNEOx4JS/jLCp4B8JJPz8lAZpHenx8Ihi3OLGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Es4OU5owZyebzkPh1vKgPGN1bcOT8S2LglXgzkrWSIpuB4SziOTnzASYAKIB78zZt2KhIaY8upmir27J1N2BzeOb/j1HAKgZV4+8IHueB60Awo2edgokVb/xv5L6Bw6lWe0Qa/qroT1lWuRjKxf5MqbmbB2Y2vDc7qmv5BA3vKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rB/HccV3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738266852;
	bh=lD165NNEOx4JS/jLCp4B8JJPz8lAZpHenx8Ihi3OLGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rB/HccV3BGduc5vvnsYMyd1o6CP4i1zLeetlb6p3QxZJ1NYnttio5AzzKiz6bC4j2
	 m0csRF8AY9R9h9BjkYLb+60eJA8wUAEkhVHd4tTmk0w2LFoM9x75Utqi0OICNm+XlB
	 29j0/8gD/kS7ezgDm882uxeHwzC9urWtQNNbLLSY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 30 Jan 2025 20:54:03 +0100
Subject: [PATCH 2/2] tools/nolibc: add support for directory access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250130-nolibc-dir-v1-2-ea9950b52e29@weissschuh.net>
References: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
In-Reply-To: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738266851; l=4781;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kp/tooTahxOKvO50CcfLj/UVzFkR86TBh24wMxcEIDw=;
 b=UoBk2QfkirwMjbsMMM+wZKAZBL/SLae+FAUMWXcspdCQcgeCOSZ/5/nv+UqJmQPoyFVX66WqG
 Af7TLpZfqSyCv+MXnXSx9doxUOa4FAPThUr6KbBveowTitroaBEb7dh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Add an allocation-free implementation of readdir() and related
functions. The implementation is modelled after the one for FILE.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
I'm not entirely sure where to put it. It doesn't really belong into
stdio.h, but that's where the FILE stuff is.
sys.h wants alphabetical ordering, but IMO these functions should stick
together.
---
 tools/include/nolibc/stdio.h                 | 76 ++++++++++++++++++++++++++++
 tools/include/nolibc/types.h                 |  5 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 37 ++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 3892034198dd566d21a5cc0a9f67cf097d428393..1f275a0a7b6b2c6f1c15405d027c282bb77aa618 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -387,6 +387,82 @@ const char *strerror(int errno)
 	return buf;
 }
 
+/* See comment of FILE above */
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
+struct dirent *readdir(DIR *dirp)
+{
+	static struct dirent dirent;
+
+	char buf[sizeof(struct linux_dirent64) + NAME_MAX];
+	struct linux_dirent64 *ldir = (void *)buf;
+	intptr_t i = (intptr_t)dirp;
+	int fd, ret;
+
+	if (i >= 0) {
+		SET_ERRNO(EBADF);
+		return NULL;
+	}
+
+	fd = ~i;
+
+	ret = getdents64(fd, ldir, sizeof(buf));
+	if (ret == -1 || ret == 0)
+		return NULL;
+
+	/*
+	 * getdents64() returns as many entries as fit the buffer.
+	 * readdir() can only return one entry at a time.
+	 * Make sure the non-returned ones are not skipped.
+	 */
+	ret = lseek(fd, ldir->d_off, SEEK_SET);
+	if (ret == -1)
+		return NULL;
+
+	dirent = (struct dirent) {
+		.d_ino = ldir->d_ino,
+	};
+	strlcpy(dirent.d_name, ldir->d_name, sizeof(dirent.d_name));
+
+	return &dirent;
+}
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index b26a5d0c417c7c3b232f28e78cdd6d94a759b7bc..67885731fff3b2008efffe7c02f93f978ef7b078 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -179,6 +179,11 @@ struct linux_dirent64 {
 	char           d_name[];
 };
 
+struct dirent {
+	ino_t	d_ino;
+	char	d_name[256];
+};
+
 /* The format of the struct as returned by the libc to the application, which
  * significantly differs from the format returned by the stat() syscall flavours.
  */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0e0e3b48a8c3a6802c6989954b6f3a7c7258db43..18f769bcf68dfb190b157aeeba14f7904965377b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -767,6 +767,42 @@ int test_getdents64(const char *dir)
 	return ret;
 }
 
+int test_directories(void)
+{
+	int comm = 0, cmdline = 0;
+	struct dirent *dirent;
+	DIR *dir;
+	int ret;
+
+	dir = opendir("/proc/self");
+	if (!dir)
+		return 1;
+
+	while (1) {
+		errno = 0;
+		dirent = readdir(dir);
+		if (!dirent)
+			break;
+
+		if (strcmp(dirent->d_name, "comm") == 0)
+			comm++;
+		else if (strcmp(dirent->d_name, "cmdline") == 0)
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
@@ -1059,6 +1095,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
+		CASE_TEST(directories);       EXPECT_SYSZR(proc, test_directories()); break;
 		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
 		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;

-- 
2.48.1


