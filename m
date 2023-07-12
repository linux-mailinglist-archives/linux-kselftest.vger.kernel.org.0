Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC77502AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjGLJSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjGLJRw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:17:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CAB11D;
        Wed, 12 Jul 2023 02:17:50 -0700 (PDT)
X-QQ-mid: bizesmtp62t1689153460t6fqn0jb
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:17:39 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: k0mQ4ihyJQOSubvL2shrPA/LW4atE5uOf3i0CK3EnGdQf0viNxC21BnUmaM3X
        HwVGiywAmFeUbqHVOieSjk+LDTytitz9TsRFkNTe2ErraPTqLYFx9dJuD2UemllBPmqYHEz
        9p1w2Tz0tz8jgvM/Sx/SYPYxU5LHY2ni5EdU3M5C6tSZpyFaoa5FzsSQkMcCutoy8UvdCRg
        QlR7mP6Mo0Dc0PVgRrFH0/1vHBBde+PiAh1IqMyilOioHaNX8k6gpTR46/wjL9u2Ch1aHDk
        xXASOab4L2E9M7TKSK4ciHT0LYiBKp91+4OdVJ4oWfyVsiwjRIrnF++PmV2EWvsuTYVBkwh
        DIAcdZOcyjnn3W4ia5tN9uainmlOCBT/Lt9dgBJTkwNPGDCXqImvd8w0X0Z4ySEQ5ceDNH3
        RTdEGLLEdTM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4436459021916993005
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Date:   Wed, 12 Jul 2023 17:17:39 +0800
Message-Id: <ef5b9900a84bdbbc59eb4319e3260a6e29d24f68.1689150149.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689150149.git.falcon@tinylab.org>
References: <cover.1689150149.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
argv, envp and _auxv for us, and then call main(), finally, it exit()
with main's return status. With this new _start_c(), the future new
architectures only require to add very few assembly instructions.

As suggested by Thomas, users may use a different signature of main
(e.g. void main(void)), a _nolibc_main alias is added for main to
silence the warning about potential conflicting types.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/90fdd255-32f4-4caf-90ff-06456b53dac3@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/Makefile |  1 +
 tools/include/nolibc/crt.h    | 59 +++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
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
index 000000000000..f9db2389acd2
--- /dev/null
+++ b/tools/include/nolibc/crt.h
@@ -0,0 +1,59 @@
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
+typedef int (_nolibc_main_fn)(int, char **, char **);
+static void exit(int);
+
+void _start_c(long *sp)
+{
+	int argc, i;
+	char **argv;
+	char **envp;
+	/* silence potential warning: conflicting types for 'main' */
+	_nolibc_main_fn _nolibc_main __asm__ ("main");
+
+	/*
+	 * sp  :  argc          <-- argument count, required by main()
+	 * argv:  argv[0]       <-- argument vector, required by main()
+	 *        argv[1]
+	 *        ...
+	 *        argv[argc-1]
+	 *        null
+	 * envp:  envp[0]       <-- environment variables, required by main() and getenv()
+	 *        envp[1]
+	 *        ...
+	 *        null
+	 * _auxv: auxv[0]       <-- auxiliary vector, required by getauxval()
+	 *        auxv[1]
+	 *        ...
+	 *        null
+	 */
+
+	/* assign argc and argv */
+	argc = sp[0];
+	argv = (void *)(sp + 1);
+
+	/* find envp */
+	envp = argv + argc + 1;
+	environ = envp;
+
+	/* find auxv */
+	i = 0;
+	while (envp[i])
+		i++;
+	_auxv = (void *)(envp + i + 1);
+
+	/* go to application */
+	exit(_nolibc_main(argc, argv, envp));
+}
+
+#endif /* _NOLIBC_CRT_H */
-- 
2.25.1

