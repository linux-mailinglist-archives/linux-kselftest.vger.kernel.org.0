Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13D754A9F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGOSVV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOSVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:21:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C28226AF;
        Sat, 15 Jul 2023 11:21:18 -0700 (PDT)
X-QQ-mid: bizesmtp84t1689445269tlee84vg
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:21:08 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: QHkcO4X2U8joJupPCpNMTgviFG27Seoc0xKyOo5tFeYezFAx8mwUHDv7HcNY0
        3aWJHz5rQCJpUYy6v4dJOAq+9yn8TBEdXJ/NSwL6AeYNiwJ/9+eYQgoBmOVn4/HB8x1KKsO
        zO0nTlUoxSYkGp29661ioMq8gyZHI8+ePwaIjxU9NIXUmKwKCdA/oVfl+3CTPP4j8j+gRbg
        B0ey6jZvcKpSjhU/BqYp9b3Ale7Pa1ftpOnJ6qdfN1hWz6rGRnvugW/fzwYo5txRbLQzigM
        rvUadcYQG56iEf/GjtzdanmTeuhVuf7uR4sTuXhuiMAj1LZROfmVWkTioXnWYkMC7cRrayh
        kwKLkKy8TediP/gyu7h5BSi8k7UOwYoGb5v4WR12eycX/UJOJKK4E86I+7rcCYxrI+Wx8ad
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2703713777350334701
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 04/18] tools/nolibc: add new crt.h with _start_c
Date:   Sun, 16 Jul 2023 02:21:08 +0800
Message-Id: <b2a971ae1768db0247f19f909fb598bbc772b418.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the environ and _auxv support added for nolibc, the assembly _start
function becomes more and more complex and therefore makes the porting
of nolibc to new architectures harder and harder.

To simplify portability, this C version of _start_c() is added to do
most of the assembly start operations in C, which reduces the complexity
a lot and will eventually simplify the porting of nolibc to the new
architectures.

The new _start_c() only requires a stack pointer argument, it will find
argc, argv, envp/environ and _auxv for us, and then call main(),
finally, it exit() with main's return status. With this new _start_c(),
the future new architectures only require to add very few assembly
instructions.

As suggested by Thomas, users may use a different signature of main
(e.g. void main(void)), a _nolibc_main alias is added for main to
silence the warning about potential conflicting types.

As suggested by Willy, the code is carefully polished for both smaller
size and better readability with local variables and the right types.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230715095729.GC24086@1wt.eu/
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/90fdd255-32f4-4caf-90ff-06456b53dac3@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/Makefile |  1 +
 tools/include/nolibc/crt.h    | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/include/nolibc/crt.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 64d67b080744..909b6eb500fe 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -27,6 +27,7 @@ nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
 all_files := \
 		compiler.h \
+		crt.h \
 		ctype.h \
 		errno.h \
 		nolibc.h \
diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
new file mode 100644
index 000000000000..92a2a0478cb1
--- /dev/null
+++ b/tools/include/nolibc/crt.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * C Run Time support for NOLIBC
+ * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
+ */
+
+#ifndef _NOLIBC_CRT_H
+#define _NOLIBC_CRT_H
+
+char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
+
+static void exit(int);
+
+void _start_c(long *sp)
+{
+	long argc;
+	char **argv;
+	char **envp;
+	const unsigned long *auxv;
+	/* silence potential warning: conflicting types for 'main' */
+	int _nolibc_main(int, char **, char **) __asm__ ("main");
+
+	/*
+	 * sp  :    argc          <-- argument count, required by main()
+	 * argv:    argv[0]       <-- argument vector, required by main()
+	 *          argv[1]
+	 *          ...
+	 *          argv[argc-1]
+	 *          null
+	 * environ: environ[0]    <-- environment variables, required by main() and getenv()
+	 *          environ[1]
+	 *          ...
+	 *          null
+	 * _auxv:   _auxv[0]      <-- auxiliary vector, required by getauxval()
+	 *          _auxv[1]
+	 *          ...
+	 *          null
+	 */
+
+	/* assign argc and argv */
+	argc = *sp;
+	argv = (void *)(sp + 1);
+
+	/* find environ */
+	environ = envp = argv + argc + 1;
+
+	/* find _auxv */
+	for (auxv = (void *)envp; *auxv++;)
+		;
+	_auxv = auxv;
+
+	/* go to application */
+	exit(_nolibc_main(argc, argv, envp));
+}
+
+#endif /* _NOLIBC_CRT_H */
-- 
2.25.1

