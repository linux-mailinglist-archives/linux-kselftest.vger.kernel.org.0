Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1DA6C1A4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjCTPud (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjCTPtq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C032A98E;
        Mon, 20 Mar 2023 08:41:22 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679326880;
        bh=SKQQeeAAWGRSm8SFG5OU6QwacV+yOMhgHKMMQrEuzXo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tBQq0JK3zlvRWZeoYiPAQ9wwGEa9T89SQKWD5RKqTC9lZOcrJAsmPoPuft4t8Fr51
         A3lCGFeYxC6qnK6ejjhzSBU5KPz93y6aWL6NiU20i/nDCMV/wpOnp2Yy7L/juYGykJ
         LX/UCPXW00tem9ide6DIiHZEfvkOUMXvNO9Pdo3I=
Date:   Mon, 20 Mar 2023 15:41:04 +0000
Subject: [PATCH v2 4/8] tools/nolibc: add support for stack protector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v2-4-4c938e098d67@weissschuh.net>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679326878; l=3910;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SKQQeeAAWGRSm8SFG5OU6QwacV+yOMhgHKMMQrEuzXo=;
 b=pCpEl3ma7Rbkt+V7cxvV1fBSkxozeEcJnk8bVg0tqUNbIZG9dHPkeOWUPTAenPN8ljKX8rHrW
 r0bwZrQjKJaBU8EraYn5aWu0o7UNg3C60Q4DAKQyh7g/ncEFw40ZiEo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is useful when using nolibc for security-critical tools.
Using nolibc has the advantage that the code is easily auditable and
sandboxable with seccomp as no unexpected syscalls are used.
Using compiler-assistent stack protection provides another security
mechanism.

For this to work the compiler and libc have to collaborate.

This patch adds the following parts to nolibc that are required by the
compiler:

* __stack_chk_guard: random sentinel value
* __stack_chk_fail: handler for detected stack smashes

In addition an initialization function is added that randomizes the
sentinel value.

Only support for global guards is implemented.
Register guards are useful in multi-threaded context which nolibc does
not provide support for.

Link: https://lwn.net/Articles/584225/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile         |  4 +--
 tools/include/nolibc/nolibc.h         |  1 +
 tools/include/nolibc/stackprotector.h | 53 +++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index ec57d3932506..9839feafd38a 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,8 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h std.h stdint.h stdio.h stdlib.h \
-             string.h sys.h time.h types.h unistd.h
+all_files := ctype.h errno.h nolibc.h signal.h stackprotector.h std.h stdint.h \
+             stdio.h stdlib.h string.h sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
 all: headers
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index b2bc48d3cfe4..04739a6293c4 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -104,6 +104,7 @@
 #include "string.h"
 #include "time.h"
 #include "unistd.h"
+#include "stackprotector.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
new file mode 100644
index 000000000000..d119cbbbc256
--- /dev/null
+++ b/tools/include/nolibc/stackprotector.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Stack protector support for NOLIBC
+ * Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_STACKPROTECTOR_H
+#define _NOLIBC_STACKPROTECTOR_H
+
+#include "arch.h"
+
+#if defined(NOLIBC_STACKPROTECTOR)
+
+#if !defined(__ARCH_SUPPORTS_STACK_PROTECTOR)
+#error "nolibc does not support stack protectors on this arch"
+#endif
+
+#include "sys.h"
+#include "stdlib.h"
+
+/* The functions in this header are using raw syscall macros to avoid
+ * triggering stack protector errors themselves
+ */
+
+__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
+void __stack_chk_fail(void)
+{
+	pid_t pid;
+	my_syscall3(__NR_write, STDERR_FILENO, "!!Stack smashing detected!!\n", 28);
+	pid = my_syscall0(__NR_getpid);
+	my_syscall2(__NR_kill, pid, SIGABRT);
+	for (;;);
+}
+
+__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
+void __stack_chk_fail_local(void)
+{
+	__stack_chk_fail();
+}
+
+__attribute__((weak,section(".data.nolibc_stack_chk")))
+uintptr_t __stack_chk_guard;
+
+__attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
+void __stack_chk_init(void)
+{
+	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
+	/* a bit more randomness in case getrandom() fails */
+	__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
+}
+#endif // defined(NOLIBC_STACKPROTECTOR)
+
+#endif // _NOLIBC_STACKPROTECTOR_H

-- 
2.40.0

