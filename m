Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD197214D4
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 07:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjFDFf0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 01:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDFfZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 01:35:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B85FCE;
        Sat,  3 Jun 2023 22:35:23 -0700 (PDT)
X-QQ-mid: bizesmtp83t1685856912tz2mpqb9
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 04 Jun 2023 13:35:11 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: rZJGTgY0+YN6Hgm0UEoWeI0raRxwz+OClFuVPySOxGuRMnsmCqEXyxefSu3x0
        2WU1GagREmkvIIMdLAcKZPPfzXOjtPC6QHE3ohpmFo0EwDu8CwIBqVcnio0loP9RgMSMEle
        vfF2rNJrqkaUHui8aQBWgK5qof0qpL61KoggBuPyvGXjWlRfC+JUz68VKJvriGEPu22kSbc
        RqLABcHytpqcY77XZL3DpY4doFeZYFXTqw9icVDCrprILlhn+oHUh/o89uCtTCHgHw1Z4/g
        qH5mWGlhL8RN+5kTi7TjkC8GBo1nfTwYXvNmegQ1933fDtiBVCTz03KNUfGCKHNsjcRg/aK
        RsT2h465n546UCWpcxgDIIFqF9rZUXUyBTxm19I3slRZRZGF2/hpk36ULoPt4VGRjQLLtme
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 350183426812210734
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 1/4] tools/nolibc: unistd.h: add __syscall() and __syscall_ret() helpers
Date:   Sun,  4 Jun 2023 13:34:29 +0800
Message-Id: <f549b27981484b429b7c7f98e212bf3c5561724f.1685856497.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685856497.git.falcon@tinylab.org>
References: <cover.1685856497.git.falcon@tinylab.org>
MIME-Version: 1.0
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

most of the library routines share the same code model, let's add some
macros to simplify the coding and shrink the code lines too.

One added for syscall return, one added for syscall call, both of them
can get the typeof 'return value' automatically.

To get the return type of syscalls, __auto_type is better than typeof(),
but it is not supported by the old compilers (before 2013, see [1]), so,
use typeof() here.

[1]: https://gcc.gnu.org/legacy-ml/gcc-patches/2013-11/msg01378.html

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 1d6f33f58629..937a8578e3d4 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -28,6 +28,21 @@
 #include "errno.h"
 #include "types.h"
 
+/* Syscall call and return helpers */
+#define __syscall_ret(ret)						\
+({									\
+	if (ret < 0) {							\
+		SET_ERRNO(-ret);					\
+		ret = (typeof(ret))-1;					\
+	}								\
+	ret;								\
+})
+
+#define __syscall(name, ...)						\
+({									\
+	typeof(sys_##name(__VA_ARGS__)) ret = sys_##name(__VA_ARGS__);	\
+	__syscall_ret(ret);						\
+})
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
-- 
2.25.1

