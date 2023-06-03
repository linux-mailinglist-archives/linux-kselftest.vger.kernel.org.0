Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57CE720EA1
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjFCIHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFCIHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:07:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C201B3;
        Sat,  3 Jun 2023 01:07:13 -0700 (PDT)
X-QQ-mid: bizesmtp69t1685779624txgoo497
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:07:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: jGGC4gWX7WHvWPvSTOy/Lb7c8eVQpIcZemPq3PNoP6Btk/BRzXuaFdwjgIiSQ
        W6WK+idd8OnQM2tBuGBsUB5beRI5q0M/Pseeq9EajJLxpVMERzq4SbzdXJeAMmnvk+RDf2P
        TZjyzttZ1Ehh6oddMbwBEiGZTqJ3qpRAtwBtvGt7chZQ8i8xgDj4SqHU8eUwv9wDgpEEjHY
        lnJU4TMdKXxJGfhwX6qivcyJSXse9hUWqH6YasFJrCeSsBTuQ8ETIo6vk2yikQ6VuH4V1L8
        8se4qXCohhtmlaq4NYQoptvpaNs/qDVEi7JnyngIyi42FDB3nAsGKDq6CHusQPKWdlA7tCc
        LEgI7y4TMRHR9CVXYEeCIxiSgqOv5XthjaPtZWt2q0Hdr/vnY4EdwGsTfpjFPpZORhVhBp5
        K+cfJACxuF4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18271478634976400800
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 05/12] selftests/nolibc: not include limits.h for nolibc
Date:   Sat,  3 Jun 2023 16:06:57 +0800
Message-Id: <0aa3b57a44b0922a118dda503a9bbb2e49125f96.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When compile nolibc-test.c with 2.31 glibc, we got such error:

    In file included from /usr/riscv64-linux-gnu/include/sys/cdefs.h:452,
                     from /usr/riscv64-linux-gnu/include/features.h:461,
                     from /usr/riscv64-linux-gnu/include/bits/libc-header-start.h:33,
                     from /usr/riscv64-linux-gnu/include/limits.h:26,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:194,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/syslimits.h:7,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:34,
                     from /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/nolibc-test.c:6:
    /usr/riscv64-linux-gnu/include/bits/wordsize.h:28:3: error: #error "rv32i-based targets are not supported"
       28 | # error "rv32i-based targets are not supported"

Glibc (>= 2.33) commit 5b6113d62efa ("RISC-V: Support the 32-bit ABI
implementation") fixed up above error.

As suggested by Thomas, defining INT_MIN/INT_MAX for nolibc can remove
the including of limits.h, and therefore no above error. of course, the
other libcs still require limits.h, move it to the right place.

The LONG_MIN/LONG_MAX are also defined too.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/09d60dc2-e298-4c22-8e2f-8375861bd9be@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/stdint.h                | 14 ++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  4 +---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index c1ce4f5e0603..31a5264539ae 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -96,4 +96,18 @@ typedef uint64_t          uintmax_t;
 #define UINT_FAST32_MAX  SIZE_MAX
 #define UINT_FAST64_MAX  SIZE_MAX
 
+#ifndef INT_MIN
+#define INT_MIN          (-__INT_MAX__ - 1)
+#endif
+#ifndef INT_MAX
+#define INT_MAX          __INT_MAX__
+#endif
+
+#ifndef LONG_MIN
+#define LONG_MIN         (-__LONG_MAX__ - 1)
+#endif
+#ifndef LONG_MAX
+#define LONG_MAX         __LONG_MAX__
+#endif
+
 #endif /* _NOLIBC_STDINT_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 403f6255c177..2a2954cb7bef 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -2,9 +2,6 @@
 
 #define _GNU_SOURCE
 
-/* platform-specific include files coming from the compiler */
-#include <limits.h>
-
 /* libc-specific include files
  * The program may be built in 3 ways:
  *   $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
@@ -39,6 +36,7 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <unistd.h>
+#include <limits.h>
 #endif
 #endif
 
-- 
2.25.1

