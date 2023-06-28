Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE1741864
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjF1SzJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:55:09 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:32295 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjF1Sxk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:40 -0400
X-QQ-mid: bizesmtp68t1687978411t0a7h12q
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 02:53:30 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: mhgCCnGOC3zHQx6jmcB1kz2NwHDP18v38JyGZQAiWr5o2Az3hiwOxWqJkj3sr
        al8QuuOwy8FjxN1au85JUw6DW1Wb/vHX+2GC8XTjfP+O1t3S8qORnqLdPM4Cf3pGlaNlChX
        IHySjIMY6PzNPzCMg+XhHGFJZdwOJjXNsPKyYq9th7KpBU9mTcFUUeq4Sd4P+9ywNxuj/kp
        QXH2k7KkcaMDqTnkd4C35V2UHyfP7DbRQBaqLYhMy0H3EM5JlWAOt5xoIudinQAR0jwiSBJ
        40AtcWRh83++0lXsOvsW4Jkmh6pGtR+4nBRcL1IOSR0yfiq5l+cw6ZOed+Sl5CuENCqT1a2
        z8R4BsBETw1oB5lmDLIPriksbujqTB7Rf8E6RzmmPTuI8MlY10=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10897143188466502564
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 02/11] tools/nolibc: add new crt.h with _start_c
Date:   Thu, 29 Jun 2023 02:53:18 +0800
Message-Id: <0976471a36cd4facf712bc02e733f669f1697083.1687976753.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687976753.git.falcon@tinylab.org>
References: <cover.1687976753.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the environ and _auxv support added for nolibc, the assembly _start
function becomes more and more complex and therefore makes the porting
of nolibc to new architectures harder and harder.

To simplify portability, this crt.h is added to do most of the assembly
start operations in C function: _start_c(), which reduces the complexity
a lot and will eventually simplify the porting of nolibc to the new
architectures.

The new _start_c() only requires a stack pointer argument, it will find
argv, envp and _auxv for us, and then call main(), finally, it exit()
with main's return status. With this new _start_c(), the future new
architectures only require to add very few assembly instructions.

It may also easier the future init/fini support.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/crt.h | 57 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 tools/include/nolibc/crt.h

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
new file mode 100644
index 000000000000..698fe1084d26
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
+int main(int argc, char *argv[], char **envp);
+static void exit(int);
+
+void _start_c(long *sp)
+{
+	int argc, i;
+	char **argv;
+	char **envp;
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
+	exit(main(argc, argv, envp));
+}
+
+#endif /* _NOLIBC_CRT_H */
-- 
2.25.1

