Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE11A711FFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbjEZGap (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 02:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjEZGam (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 02:30:42 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681F125;
        Thu, 25 May 2023 23:30:40 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685082638;
        bh=feE5GF7sSHQYQ5FSqkLvKWbBOiMTo93SuVWHmjxyeJw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ExDchs/ZRrFRV4v4wSML7GCpmB6CbFZGI2pFOKySq4/R0XYKv7NO8qhMUdcp59qLM
         yO8jj0Hy//LPUkI5AY35Pkm2YrSP9OhcTGdAlRfU5HjjiuaU1Dqf5SgbthmSyQHeeq
         hxEa+6eGi0g96TcsnBAmXJRdKGIwG+8+w3ks5iyI=
Date:   Fri, 26 May 2023 08:30:35 +0200
Subject: [PATCH 1/2] tools/nolibc: add support for prctl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230526-nolibc-test-no-dump-v1-1-62e724a96db2@weissschuh.net>
References: <20230526-nolibc-test-no-dump-v1-0-62e724a96db2@weissschuh.net>
In-Reply-To: <20230526-nolibc-test-no-dump-v1-0-62e724a96db2@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685082637; l=2782;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=feE5GF7sSHQYQ5FSqkLvKWbBOiMTo93SuVWHmjxyeJw=;
 b=rKi2UVvspxLdWtiD9wtKUzt6GsxOe7oxvaliatgqOG70KqJoHRv8LLJbfWoAcJjMUfpGU/10R
 d43FqGOGdnOAE2UR81CMJvQezwmf0cO5fuBibGQmBn7BMVjw9uZgnRs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It will be used to disable core dumps from the child spawned to validate
the stack protector functionality.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h                   | 27 +++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 7874062bea95..3d521feffad6 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -22,6 +22,7 @@
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
 #include <linux/reboot.h> /* for LINUX_REBOOT_* */
+#include <linux/prctl.h>
 
 #include "arch.h"
 #include "errno.h"
@@ -894,6 +895,32 @@ int open(const char *path, int flags, ...)
 }
 
 
+/*
+ * int prctl(int option, unsigned long arg2, unsigned long arg3,
+ *                       unsigned long arg4, unsigned long arg5);
+ */
+
+static __attribute__((unused))
+int sys_prctl(int option, unsigned long arg2, unsigned long arg3,
+		          unsigned long arg4, unsigned long arg5)
+{
+	return my_syscall5(__NR_prctl, option, arg2, arg3, arg4, arg5);
+}
+
+static __attribute__((unused))
+int prctl(int option, unsigned long arg2, unsigned long arg3,
+		      unsigned long arg4, unsigned long arg5)
+{
+	int ret = sys_prctl(option, arg2, arg3, arg4, arg5);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
 /*
  * int pivot_root(const char *new, const char *old);
  */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6e0a4dbe321e..76a9a0f362b1 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
+#include <sys/prctl.h>
 #include <sys/reboot.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
@@ -580,6 +581,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
 		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
+		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, NULL, 0, 0, 0), -1, EFAULT); break;
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;

-- 
2.40.1

