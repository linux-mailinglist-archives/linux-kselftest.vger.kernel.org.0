Return-Path: <linux-kselftest+bounces-464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A77F546D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 00:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634FEB20DB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A36208B9;
	Wed, 22 Nov 2023 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mj3VfFIz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8C199;
	Wed, 22 Nov 2023 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700695286;
	bh=+wwLWsOzUhO5DcZAPO5W8gHxG/+RvPZMOuDOlIqHikY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mj3VfFIzMYATJNncnNxf7lCtyL3K6dQoyS9Lbp0oFSdDotwX8gFxppwzH5tB39izR
	 7KVuXn1tTQLfyQxb2d8h9IgqbnSjjxUB+fv2JK2aQw0BgqyWviBJEqNbp9pM5Ndl5i
	 bbZwcEag6OyEdWBkuZ7XPorboZ5kLmF2XcNlaVYc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Nov 2023 00:21:26 +0100
Subject: [PATCH 2/3] tools/nolibc: add support for getrlimit/setrlimit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-nolibc-rlimit-v1-2-a428b131de2a@weissschuh.net>
References: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
In-Reply-To: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700695285; l=3555;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+wwLWsOzUhO5DcZAPO5W8gHxG/+RvPZMOuDOlIqHikY=;
 b=7MH+fFec8xzEZGptGCONnSZDtxVsM+HH4V2Xb+pgNVsICmD0Q+KtMr6Ifj3FNt2kIOQmsu8G0
 pjNx/wPYoAiDwH6zFsR6eS08MvGJmNRAl0Bokd1kUCjwBTX07S46Hh8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The implementation uses the prlimit64 systemcall as that is available on
all architectures.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h                   | 38 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 29 +++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 2f359cb03d10..dda9dffd1d74 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -21,6 +21,7 @@
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
 #include <linux/prctl.h>
+#include <linux/resource.h>
 
 #include "arch.h"
 #include "errno.h"
@@ -898,6 +899,43 @@ int reboot(int cmd)
 }
 
 
+/*
+ * int getrlimit(int resource, struct rlimit *rlim);
+ * int setrlimit(int resource, const struct rlimit *rlim);
+ */
+
+static __attribute__((unused))
+int sys_prlimit64(pid_t pid, int resource,
+		  const struct rlimit64 *new_limit, struct rlimit64 *old_limit)
+{
+	return my_syscall4(__NR_prlimit64, pid, resource, new_limit, old_limit);
+}
+
+static __attribute__((unused))
+int getrlimit(int resource, struct rlimit *rlim)
+{
+	struct rlimit64 rlim64;
+	int ret;
+
+	ret = __sysret(sys_prlimit64(0, resource, NULL, &rlim64));
+	rlim->rlim_cur = rlim64.rlim_cur;
+	rlim->rlim_max = rlim64.rlim_max;
+
+	return ret;
+}
+
+static __attribute__((unused))
+int setrlimit(int resource, const struct rlimit *rlim)
+{
+	struct rlimit64 rlim64 = {
+		.rlim_cur = rlim->rlim_cur,
+		.rlim_max = rlim->rlim_max,
+	};
+
+	return __sysret(sys_prlimit64(0, resource, &rlim64, NULL));
+}
+
+
 /*
  * int sched_yield(void);
  */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2b71fb5fae4e..d07cebace107 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -22,6 +22,7 @@
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/reboot.h>
+#include <sys/resource.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/sysmacros.h>
@@ -839,6 +840,33 @@ int test_pipe(void)
 	return !!memcmp(buf, msg, len);
 }
 
+int test_rlimit(void)
+{
+	struct rlimit rlim = {
+		.rlim_cur = 1 << 20,
+		.rlim_max = 1 << 20,
+	};
+	int ret;
+
+	ret = setrlimit(RLIMIT_CORE, &rlim);
+	if (ret)
+		return -1;
+
+	rlim.rlim_cur = 0;
+	rlim.rlim_max = 0;
+
+	ret = getrlimit(RLIMIT_CORE, &rlim);
+	if (ret)
+		return -1;
+
+	if (rlim.rlim_cur != 1 << 20)
+		return -1;
+	if (rlim.rlim_max != 1 << 20)
+		return -1;
+
+	return 0;
+}
+
 
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
@@ -929,6 +957,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll(NULL, 1, 0), -1, EFAULT); break;
 		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
+		CASE_TEST(rlimit);            EXPECT_SYSZR(1, test_rlimit()); break;
 		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
 		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;

-- 
2.43.0


