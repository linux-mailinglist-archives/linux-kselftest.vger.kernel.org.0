Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40EE7412B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjF1Nk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:40:27 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:10796 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231896AbjF1NkX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:40:23 -0400
X-QQ-mid: bizesmtp63t1687959609tym1h2ar
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:40:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: RrZlkntZBfm7xfyOGEmRqtWFTO3iq7nrzLtjOv4A2klW688L8fqcGLaJOxs8X
        3F31Ai7GCBo2e9HJyJILIB42zbeQx1PuK7MYOfzgKgeaSRyYEmvI3hI2uTHhybYCBrsA3cp
        lS9RSbXqWjPh8ae0mL2HdWhgRJCIj6hHiwuiw5vmOpYUuMmi5hG9xLwpb+2pSbkKiMMXT7H
        zh8H3WHw1AhFVzB0XpFpehS+BHfnlTIdh6yP8pcReyx66HBcS99g/oRIzWaDjHA8RbxP/zQ
        PaskCzmAYuEA1rRID6wETmtTzTqReplG8ThnqMB1q3tpCd7su10qnwcpvXYWaRnHzPvYojP
        +KN8Bp67CChP70petq2j5GKX9rlALGG3tAh+/jWXJy/KNyr37geEaTCIZOvaA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14474260632320986348
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v5 10/14] tools/nolibc: __sysret: support syscalls who return a pointer
Date:   Wed, 28 Jun 2023 21:39:56 +0800
Message-Id: <72d948095d22c3ba4e69d98877addcea49a326c6.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To support syscalls (e.g. mmap()) who return a pointer and to allow the
pointer as big as possible, we should convert the negated errno value to
unsigned long (uintptr_t), otherwise, in signed long, a potential big
pointer (whose highest bit is 1) will be treated as a failure.

tools/include/nolibc/errno.h defines the MAX_ERRNO, let's use it
directly. after converting to unsigned long, the negative errno value
from -1 to -MAX_ERRNO becomes something like '~1 + 1' (every bit is 1)
to '~MAX_ERRNO + 1', '~1 + 1' is the biggest, '~MAX_ERRNO + 1' is the
smallest, so, the check becomes:

    if (ret <= (unsigned long)-1 && ret >= (unsigned long)-MAX_ERRNO) {
        ...
    }

Since (unsigned long)-1 is the biggest unsigned long value, it is always
true if bigger than (unsigned long)-MAX_ERRNO, so, just reserve the
following check is enough:

    if (ret >= (unsigned long)-MAX_ERRNO) {
        ...
    }

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Link: https://lore.kernel.org/linux-riscv/94dd5170929f454fbc0a10a2eb3b108d@AcuMS.aculab.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 53bc3ad6593e..b6125e600dc2 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -28,13 +28,16 @@
 #include "errno.h"
 #include "types.h"
 
-/* Syscall return helper, set errno as -ret when ret < 0 */
+
+/* Syscall return helper for library routines
+ * set errno as -ret when ret in [-MAX_ERRNO, -1]
+ */
 static __inline__ __attribute__((unused, always_inline))
-long __sysret(long ret)
+long __sysret(unsigned long ret)
 {
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
+	if (ret >= (unsigned long)-MAX_ERRNO) {
+		SET_ERRNO(-(long)ret);
+		return -1;
 	}
 	return ret;
 }
-- 
2.25.1

