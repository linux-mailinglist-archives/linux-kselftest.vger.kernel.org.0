Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C1735B84
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFSPud (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjFSPuc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:50:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB789A4;
        Mon, 19 Jun 2023 08:50:29 -0700 (PDT)
X-QQ-mid: bizesmtp65t1687189816tdj31vkq
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:50:14 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: lJ9dImo9Gpeyz8IOKq+GcNXt5bf5lKsHx4krldfzto/2klwvpwlW5zu4HsFMO
        T3D5l8mDvV8FkGonqQzuWoU43QdE6GRR6PIVIB0HxaHgFBH0BglfRFDghFmMPBZM8DI5II7
        1VmJ6Lw8HBn/7eZ94UtUuKdSkNOVFWWoatTOu/yoQdknRrDgAMarKa+RO+x/sJPTWthw60d
        FOPdQ9jEm8q4jTAlrRtzy/dOgsqWUQkAXSGHiUxYPOh0i7mnXppFlh6qDQrVDFpSYG70mbs
        HCEsMn0XqQDYpLsRzogrLqNBsOjF9Vx78SpiIXCEViHeVbcUwPuoB20V4Mq9sMAQiVDcul0
        3A3z92ODahZBnR/e1BhsIBg5cub/ZAWqKvEcrF71WY0VAO9OHRUliKtrQKgw8FfmlatbISe
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1071758241014777112
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v4 06/10] tools/nolibc: __sysret: support syscalls who return a pointer
Date:   Mon, 19 Jun 2023 23:48:21 +0800
Message-Id: <aae854b2de881f9bc1c82ab9dda53b51d7330c9a.1687187451.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687187451.git.falcon@tinylab.org>
References: <cover.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 4fbefe5adf93..8a6e16472d54 100644
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

