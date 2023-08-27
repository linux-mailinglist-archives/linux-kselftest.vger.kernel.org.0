Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5260C789BFE
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 10:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjH0IAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjH0IAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 04:00:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B7DC;
        Sun, 27 Aug 2023 01:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693123218;
        bh=Zc+0e7HEVg0QwGCWDx6Xu2P8HO+18jc06c3eNrQ5BSs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ec+EMVZIv96OcaBWHX1Rmpn5YjoeVsw1mZMFSxZQEsxQgIzEZL5qEzWqCFfsCqsXu
         mbomHMNudf4kDljpmngnvkXvborebxr33JqisSF32DeloJA/Y+w3wM9/4XtNnLALVs
         JaHMDM3Uerind5XSNZfQWpSJr6RVWp/+1nO55aOg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 27 Aug 2023 10:00:15 +0200
Subject: [PATCH 1/2] tools/nolibc: add stdarg.h header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
References: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
In-Reply-To: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, Yuan Tan <tanyuan@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693123218; l=1624;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Zc+0e7HEVg0QwGCWDx6Xu2P8HO+18jc06c3eNrQ5BSs=;
 b=I3cB+FO3c/qRP1Az43SKg/JA1ENpSisFWRhvYaaPOIOpzgPQbco5F2Y1C3KSz2989lekn3Oil
 ClDYmtw+LBqCS5fj2sckq0WUYqvgpaUvgBqzVNCF4/GCJ2mlMrTmPbM
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
 tools/include/nolibc/stdarg.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

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

-- 
2.42.0

