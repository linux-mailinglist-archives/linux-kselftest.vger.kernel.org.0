Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6603374B36C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGGO5e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 10:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGGO5d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 10:57:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFA210A;
        Fri,  7 Jul 2023 07:57:31 -0700 (PDT)
X-QQ-mid: bizesmtp65t1688741838t0f6f5rq
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 22:57:17 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 6/K5pWSRdGp5l3PoSnsEr+W6n/O4GVkW2LsupZpOaCCnabhC9drJ+DsHTHGGa
        rpPAydJpCLVE4Yu5xjNNf886fcd75eYPy4f1CJVneC7/0vFizOlY/8RavL9cQLH+5qlBKdY
        T26RBSYkIWrac+plKyZyFDAQHOazNAOnx1T7kOiVneWS5f/wr8Ez5VRxQvzZvQxdei7uftr
        G8bYJAdCFUoNytCFtmfyt9XZohqeJxoGQaPP3fHRTj28Ly8xD8BkFYsPULycHa/6IDvJuAN
        MqUK5SPN9/+jB5l4g/5XTC9L51uz2CBdxApWKXmcHXt6PfAwJmgYn/9kDGGQLO0EvowDYOC
        tj5RprGXjtRiusZgLAzassh26B9m6zPartP8HLPVFF77FEdqu/QC8BNCz0T6GLu2e8ZMYia
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6279798532617974938
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v6 06/15] tools/nolibc: __sysret: support syscalls who return a pointer
Date:   Fri,  7 Jul 2023 22:56:59 +0800
Message-Id: <11fd815773f7d202d329ac2c64cd6980b32e4fcf.1688739492.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688739492.git.falcon@tinylab.org>
References: <cover.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

No official reference states the errno range, here aligns with musl and
glibc and uses [-MAX_ERRNO, -1] instead of all negative ones.

- musl: src/internal/syscall_ret.c
- glibc: sysdeps/unix/sysv/linux/sysdep.h

The MAX_ERRNO used by musl and glibc is 4095, just like the one nolibc
defined in tools/include/nolibc/errno.h.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZKKdD%2Fp4UkEavru6@1wt.eu/
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Link: https://lore.kernel.org/linux-riscv/94dd5170929f454fbc0a10a2eb3b108d@AcuMS.aculab.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 53bc3ad6593e..3479f54d7957 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -28,13 +28,20 @@
 #include "errno.h"
 #include "types.h"
 
-/* Syscall return helper, set errno as -ret when ret < 0 */
+
+/* Syscall return helper for library routines, set errno as -ret when ret is in
+ * range of [-MAX_ERRNO, -1]
+ *
+ * Note, No official reference states the errno range here aligns with musl
+ * (src/internal/syscall_ret.c) and glibc (sysdeps/unix/sysv/linux/sysdep.h)
+ */
+
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

