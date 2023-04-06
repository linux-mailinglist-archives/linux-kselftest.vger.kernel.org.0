Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101826DA503
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDFVza (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbjDFVzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:55:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE98AD20;
        Thu,  6 Apr 2023 14:54:59 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818095;
        bh=X60ak0sedknadOIvWDQ9aZzSRdad/1Q+QXzu97VjaVg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=A6jHzu4hl7h2IqK2hYbiB9n8cM4IKteAULIPE6nlG64aIFGTzLxiuRNmm58AKi/wI
         e3gH8Jiiw+K/fgoGHaP/5QWYFSo7z9WujywvvNjwNwD33hAsNHAVczBTxrR4nYAau4
         sTzxOcLcEpPiwE5h3fHD3EzYs5dxKFieeRCyCfy4=
Date:   Thu, 06 Apr 2023 21:54:56 +0000
Subject: [PATCH v2 10/11] tools/nolibc: use C89 comment syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-10-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=3509;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=X60ak0sedknadOIvWDQ9aZzSRdad/1Q+QXzu97VjaVg=;
 b=PMX15SgYaKLuh5We5vXFX7qq/vVTiYc/ps7vPXcz4VTIyom6AennGirjFTmtxyRzGmXO4A2zN
 Bc47UZD5RNzAmKgsnNVfINKRiw5puxDBrjGWqTc4NgasTco8G3aTs+5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most of nolibc is already using C89 comments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stackprotector.h        |  4 ++--
 tools/include/nolibc/sys.h                   |  8 ++++----
 tools/testing/selftests/nolibc/nolibc-test.c | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index d119cbbbc256..77e5251c4490 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -48,6 +48,6 @@ void __stack_chk_init(void)
 	/* a bit more randomness in case getrandom() fails */
 	__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
 }
-#endif // defined(NOLIBC_STACKPROTECTOR)
+#endif /* defined(NOLIBC_STACKPROTECTOR) */
 
-#endif // _NOLIBC_STACKPROTECTOR_H
+#endif /* _NOLIBC_STACKPROTECTOR_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index bea9760dbd16..1b9b91cd8b57 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -12,15 +12,15 @@
 
 /* system includes */
 #include <asm/unistd.h>
-#include <asm/signal.h>  // for SIGCHLD
+#include <asm/signal.h>  /* for SIGCHLD */
 #include <asm/ioctls.h>
 #include <asm/mman.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
 #include <linux/auxvec.h>
-#include <linux/fcntl.h> // for O_* and AT_*
-#include <linux/stat.h>  // for statx()
+#include <linux/fcntl.h> /* for O_* and AT_* */
+#include <linux/stat.h>  /* for statx() */
 
 #include "arch.h"
 #include "errno.h"
@@ -322,7 +322,7 @@ static __attribute__((noreturn,unused))
 void sys_exit(int status)
 {
 	my_syscall1(__NR_exit, status & 255);
-	while(1); // shut the "noreturn" warnings.
+	while(1); /* shut the "noreturn" warnings. */
 }
 
 static __attribute__((noreturn,unused))
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e692be98973a..f06b38cfe38a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #define _GNU_SOURCE
 
@@ -46,8 +46,8 @@ char **environ;
 
 /* definition of a series of tests */
 struct test {
-	const char *name;              // test name
-	int (*func)(int min, int max); // handler
+	const char *name;              /* test name */
+	int (*func)(int min, int max); /* handler */
 };
 
 #ifndef _NOLIBC_STDLIB_H
@@ -494,7 +494,7 @@ int run_syscall(int min, int max)
 	euid0 = geteuid() == 0;
 
 	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; // line length
+		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
@@ -584,7 +584,7 @@ int run_stdlib(int min, int max)
 	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; // line length
+		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
@@ -731,7 +731,7 @@ static int run_vfprintf(int min, int max)
 	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; // line length
+		int llen = 0; /* line length */
 
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.

-- 
2.40.0

