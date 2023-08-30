Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89E578DAD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjH3ShQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245304AbjH3PHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 11:07:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA01A4;
        Wed, 30 Aug 2023 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693408036;
        bh=8FIja9IFIvy0ghblU2pMnjY5DcbONT7SKYZbKgOAbVY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=B4a8ElQ83YuPnV6polCeO4SrrT9XumGWQZUfyHL307vjC52fc0POVPfoLO1v8+ioU
         tZYfa/Xy/XC2H8ZFWxuHsQ+9sCA8jO+5coszHm2HiTsn3JrLcxufMGZo87ry+IlNzR
         kl7MQpTgsq24H+hprf3DZK7XRbG8t4ZrCtAn81ic=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 30 Aug 2023 17:07:12 +0200
Subject: [PATCH v2 1/2] tools/nolibc: add stdarg.h header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230830-nolibc-nostdinc-v2-1-c5b1387b4a77@weissschuh.net>
References: <20230830-nolibc-nostdinc-v2-0-c5b1387b4a77@weissschuh.net>
In-Reply-To: <20230830-nolibc-nostdinc-v2-0-c5b1387b4a77@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, Yuan Tan <tanyuan@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693408035; l=3407;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8FIja9IFIvy0ghblU2pMnjY5DcbONT7SKYZbKgOAbVY=;
 b=0H2FPq1DK3HALGiANLknXK96oNZsN2fGV3pIP3M0i55YkJEHHW3DeizcEAi2e/LBE7LCq8DvL
 Qcn32rg9lOMBd/I9wLuzSmTbUBzigjZM4QUHC/V9WVXJEK4+2zp6+EX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows nolic to work with `-nostdinc` avoiding any reliance on
system headers.

The implementation has been lifted from musl libc 1.2.4.
There is already an implementation of stdarg.h in include/linux/stdarg.h
but that is GPL licensed and therefore not suitable for nolibc.

The used compiler builtins have been validated to be at least available
since GCC 4.1.2 and clang 3.0.0.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile |  1 +
 tools/include/nolibc/nolibc.h |  4 ++--
 tools/include/nolibc/stdarg.h | 16 ++++++++++++++++
 tools/include/nolibc/stdio.h  |  3 +--
 tools/include/nolibc/sys.h    |  2 +-
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 909b6eb500fe..e69c26abe1ea 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -34,6 +34,7 @@ all_files := \
 		signal.h \
 		stackprotector.h \
 		std.h \
+		stdarg.h \
 		stdint.h \
 		stdlib.h \
 		string.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 1f8d821000ac..989e707263a4 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -74,10 +74,10 @@
  *            -I../nolibc -o hello hello.c -lgcc
  *
  * The available standard (but limited) include files are:
- *   ctype.h, errno.h, signal.h, stdio.h, stdlib.h, string.h, time.h
+ *   ctype.h, errno.h, signal.h, stdarg.h, stdio.h, stdlib.h, string.h, time.h
  *
  * In addition, the following ones are expected to be provided by the compiler:
- *   float.h, stdarg.h, stddef.h
+ *   float.h, stddef.h
  *
  * The following ones which are part to the C standard are not provided:
  *   assert.h, locale.h, math.h, setjmp.h, limits.h
diff --git a/tools/include/nolibc/stdarg.h b/tools/include/nolibc/stdarg.h
new file mode 100644
index 000000000000..c628b5783da6
--- /dev/null
+++ b/tools/include/nolibc/stdarg.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Variadic argument support for NOLIBC
+ * Copyright (C) 2005-2020 Rich Felker, et al.
+ */
+
+#ifndef _NOLIBC_STDARG_H
+#define _NOLIBC_STDARG_H
+
+typedef __builtin_va_list va_list;
+#define va_start(v, l)   __builtin_va_start(v, l)
+#define va_end(v)        __builtin_va_end(v)
+#define va_arg(v, l)     __builtin_va_arg(v, l)
+#define va_copy(d, s)    __builtin_va_copy(d, s)
+
+#endif /* _NOLIBC_STDARG_H */
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index cae402c11e57..d7ef43973916 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -7,13 +7,12 @@
 #ifndef _NOLIBC_STDIO_H
 #define _NOLIBC_STDIO_H
 
-#include <stdarg.h>
-
 #include "std.h"
 #include "arch.h"
 #include "errno.h"
 #include "types.h"
 #include "sys.h"
+#include "stdarg.h"
 #include "stdlib.h"
 #include "string.h"
 
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index fdb6bd6c0e2f..b478750c9004 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -7,7 +7,6 @@
 #ifndef _NOLIBC_SYS_H
 #define _NOLIBC_SYS_H
 
-#include <stdarg.h>
 #include "std.h"
 
 /* system includes */
@@ -25,6 +24,7 @@
 
 #include "arch.h"
 #include "errno.h"
+#include "stdarg.h"
 #include "types.h"
 
 

-- 
2.42.0

