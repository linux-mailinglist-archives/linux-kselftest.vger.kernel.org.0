Return-Path: <linux-kselftest+bounces-7916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D38A4114
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 09:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A70282A0E
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD321345;
	Sun, 14 Apr 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oTWaWeHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15215E9B;
	Sun, 14 Apr 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081401; cv=none; b=PwgMA71XRYSCoCP6IpYgw4kxF6IDlY53NjBf+JdMLmK1RyimODOwxsBNjRNgPGU/YsaGHSIDkNVgMyB6PgZycc/B0eRReOBn5UIQCji4OZI8xoDM4qXZ5Mk8ezBl2M4drtzPpPgz6I8XN/Pj00oWUx6y0G0V4OcvYWLde00/1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081401; c=relaxed/simple;
	bh=txG+MaiGhkYK6WZayglTtsGLPC9RsnrKCz2cnhHMAtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YFxidvVyRY9q9MgW6rBNqiL43FnnAuBR39wj1K3bKv6mKu2TGcUoDuJIbwK17cmTnE2VUr3ZsIhBAl2yKr3up2sEAJXoIYbkwaUq9ucdQJI3cLhfhHWAa6MZesuCXr8ZLOwe6MX+X+EI08VRvn+boeRGbgB75dIx6lGvEjaRPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oTWaWeHu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713081388;
	bh=txG+MaiGhkYK6WZayglTtsGLPC9RsnrKCz2cnhHMAtg=;
	h=From:Date:Subject:To:Cc:From;
	b=oTWaWeHuxUAT50GTvGTwOMRFrD2NUDOHWRd5cI7jxTMSQUSghN4eDwDr1v8soR7LM
	 86elWuuny7t4N+Wn+CJ7HEi6q56rTdP5N9eyh9K8VOk0vHvsmHDoG8EKs31SIf84vt
	 +/G/Y/dIjO3jpWoR1pK6ngcf1ccBXYFt2hcRqKe0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 14 Apr 2024 09:56:23 +0200
Subject: [PATCH] tools/nolibc: add support for uname(2)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-nolibc-uname-v1-1-28a1fdbd5c64@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACaMG2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0MT3bz8nMykZN3SvMTcVN2UVGMLS9NEExMj0zQloJaCotS0zAqwcdG
 xtbUA0uBRgF4AAAA=
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713081387; l=3814;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=txG+MaiGhkYK6WZayglTtsGLPC9RsnrKCz2cnhHMAtg=;
 b=iSSLGnCYRC5zFPlphtA8E3uU1uI7QrmwEbQ5wteqb1DtG8koyghnwfl11QJTXB5WelscFbjuU
 4RAJBHppMilDQrg2YMcU28DkJ42anKlzxR4bLNYjIKYW2x7sf9Km13M
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All supported kernels are assumed to use struct new_utsname.
This is validated in test_uname().

uname(2) can for example be used in ksft_min_kernel_version() from the
kernels selftest framework.

Link: https://lore.kernel.org/lkml/20240412123536.GA32444@redhat.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h                   | 27 ++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 42 ++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index dda9dffd1d74..7b82bc3cf107 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -22,6 +22,7 @@
 #include <linux/stat.h>  /* for statx() */
 #include <linux/prctl.h>
 #include <linux/resource.h>
+#include <linux/utsname.h>
 
 #include "arch.h"
 #include "errno.h"
@@ -1139,6 +1140,32 @@ int umount2(const char *path, int flags)
 }
 
 
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
+
 /*
  * int unlink(const char *path);
  */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6ba4f8275ac4..3c9a9bd38194 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -27,6 +27,7 @@
 #include <sys/syscall.h>
 #include <sys/sysmacros.h>
 #include <sys/time.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
 #include <errno.h>
@@ -761,6 +762,45 @@ int test_stat_timestamps(void)
 	return 0;
 }
 
+int test_uname(void)
+{
+	struct utsname buf;
+	char osrelease[sizeof(buf.release)];
+	ssize_t r;
+	int fd;
+
+	memset(&buf.domainname, 'P', sizeof(buf.domainname));
+
+	if (uname(&buf))
+		return 1;
+
+	if (strncmp("Linux", buf.sysname, sizeof(buf.sysname)))
+		return 1;
+
+	fd = open("/proc/sys/kernel/osrelease", O_RDONLY);
+	if (fd == -1)
+		return 1;
+
+	r = read(fd, osrelease, sizeof(osrelease));
+	if (r == -1)
+		return 1;
+
+	close(fd);
+
+	if (osrelease[r - 1] == '\n')
+		r--;
+
+	/* Validate one of the later fields to ensure field sizes are correct */
+	if (strncmp(osrelease, buf.release, r))
+		return 1;
+
+	/* Ensure the field domainname is set, it is missing from struct old_utsname */
+	if (strnlen(buf.domainname, sizeof(buf.domainname)) == sizeof(buf.domainname))
+		return 1;
+
+	return 0;
+}
+
 int test_mmap_munmap(void)
 {
 	int ret, fd, i, page_size;
@@ -966,6 +1006,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
+		CASE_TEST(uname);             EXPECT_SYSZR(1, test_uname()); break;
+		CASE_TEST(uname_fault);       EXPECT_SYSER(1, uname(NULL), -1, EFAULT); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
 		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;
 		CASE_TEST(wait_child);        EXPECT_SYSER(1, wait(&tmp), -1, ECHILD); break;

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240414-nolibc-uname-de3895a4425f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


