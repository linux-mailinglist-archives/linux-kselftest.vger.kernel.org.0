Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6527799F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjHKVwO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjHKVwO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 17:52:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E957271B;
        Fri, 11 Aug 2023 14:52:10 -0700 (PDT)
X-QQ-mid: bizesmtp69t1691790715t2l3imm8
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 05:51:53 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: jGGC4gWX7WFEuWrQD10QYevA6rKFR5eyLN27zADU7mMJyUa1X6F5wj5b8c1PO
        ER8oXLqoaZcj68vp2XW1IvvzWMXYjLid4rTDbWxcHY9+xK0LZ6TboYz9xrN1UuKrfZPeivH
        Xhx+frlWCSJTPIl4qTvNiv+IIPg62gxZBtdjgSzG1OWsfAsHQZwMgx7V1TgW3uPw9evoaY9
        f/3qSx8aKzolxDdGprJ9lCbNnqC8BdKQhSeoDf1ZVL0vz1omtIq9sC7KeFcpXHcLENpcFN+
        ZEMfFnvLJZED4528TgM/+SpuC2OxOWzKeNxwVnytS785YBa97JXf5RSeKCPgFQkYpErIUmN
        JyXdyk2gkVM2i9Ad6ukNE5KRQK4tVquu5jqDZvRRUNb6m1LNpMtGj4GfqQLSUQA0SHWLMTn
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14313426769615256479
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, david.laight@aculab.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v6 2/2] tools/nolibc: fix up size inflate regression
Date:   Sat, 12 Aug 2023 05:51:53 +0800
Message-Id: <96624cc918092737d35dd539d184de06dba7a9b8.1691788036.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691788036.git.falcon@tinylab.org>
References: <cover.1691788036.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As reported and suggested by Willy, the inline __sysret() helper
introduces three types of conversions and increases the size:

(1) the "unsigned long" argument to __sysret() forces a sign extension
from all sys_* functions that used to return 'int'

(2) the comparison with the error range now has to be performed on a
'unsigned long' instead of an 'int'

(3) the return value from __sysret() is a 'long' (note, a signed long)
which then has to be turned back to an 'int' before being returned by the
caller to satisfy the caller's prototype.

To fix up this, firstly, let's use macro instead of inline function to
preserves the input type and avoids these useless conversions (1), (3).

Secondly, since all of the sys_* functions have been converted to return
integer, now, it is able to remove comparison to a 'unsigned long'
-MAX_ERRNO (2) and restore the simple sign comparison as before.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230806095846.GB10627@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index a28e7fbff448..e0b68d3532b6 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -27,23 +27,16 @@
 #include "errno.h"
 #include "types.h"
 
-
-/* Syscall return helper for library routines, set errno as -ret when ret is in
- * range of [-MAX_ERRNO, -1]
- *
- * Note, No official reference states the errno range here aligns with musl
- * (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h)
- */
-
-static __inline__ __attribute__((unused, always_inline))
-long __sysret(unsigned long ret)
-{
-	if (ret >= (unsigned long)-MAX_ERRNO) {
-		SET_ERRNO(-(long)ret);
-		return -1;
-	}
-	return ret;
-}
+/* Syscall return helper, set errno as -ret when ret < 0 */
+#define __sysret(arg)                        \
+({                                           \
+	__typeof__(arg) __ret = (arg);       \
+	if (__ret < 0) {                     \
+		SET_ERRNO(-__ret);           \
+		__ret = -1L;                 \
+	}                                    \
+	__ret;                               \
+})
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
-- 
2.25.1

