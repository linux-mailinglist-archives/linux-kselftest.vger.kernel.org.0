Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C8712181
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbjEZHv0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 03:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242512AbjEZHvY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 03:51:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79E135;
        Fri, 26 May 2023 00:51:23 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685087481;
        bh=DkJgAJcAvtdVnot+t7IOseLE6pLBA89qfDYOzqzRxr4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lLn5Ra4UT5W+7hPi/W7hyftOnWvQtbYt+RnnVvKlguWzQzyC0CwMO2hGXzu6ur9yH
         qfmUquarnq6NgvYS+xMiQ8MFmMW45qi4cvdFJu3NugZ30I2j+u6vl7Wz5c3sc1gHEz
         6DY8wQXm+P5v9F77hDDwcSJsc8sUYdW2ttJUKJJQ=
Date:   Fri, 26 May 2023 09:51:19 +0200
Subject: [PATCH v2 1/2] tools/nolibc: add support for prctl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230526-nolibc-test-no-dump-v2-1-a66500bf73fc@weissschuh.net>
References: <20230526-nolibc-test-no-dump-v2-0-a66500bf73fc@weissschuh.net>
In-Reply-To: <20230526-nolibc-test-no-dump-v2-0-a66500bf73fc@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685087479; l=2797;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DkJgAJcAvtdVnot+t7IOseLE6pLBA89qfDYOzqzRxr4=;
 b=1qmpuRz+hs8ZGEviZzteWWt0ML8v4Ia8/JBkYrADdw2L0sSJWamEoTw3a3mzpd35T6OfV0d2/
 uvz8xMz4/LmC5SqdGi/Jv4+cymN2dC0aC+H8ojsYN0kyrYw8n7SMt0n
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
index 6e0a4dbe321e..95ff2867a91d 100644
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
+		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;

-- 
2.40.1

