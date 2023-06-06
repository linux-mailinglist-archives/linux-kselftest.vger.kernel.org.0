Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B35D723B1B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjFFIPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjFFIPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:15:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A94D2;
        Tue,  6 Jun 2023 01:15:15 -0700 (PDT)
X-QQ-mid: bizesmtp90t1686039304trwmue6s
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 16:15:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: Sx1DrRIRqMdZ/MlCKruD26v8RqVr1CqYgFN5TjLwES8X+31r0YtgE6IBd5cmf
        DKk1dhvd4kdbyYCcvDHYlgPvIIZUN8eIxVkKKiLqrQ4UUMsnftqUrk03X/oF/6ZFzFAwjhj
        77U0T4jL4pFsMjQBOVLSF3utZBeIScSOMCTU82gLNitvMSA7M6+yqVKIrOMBZcyYpTEkNUb
        VI5+pKYaFWHr2fNaC+pzOW98RgrorJ472+Q5MGW5Eor2qTEcQ3Y1Ib5/9I5EvC1EB41M1l1
        Norl38y/vfKux6oTJBLP1e3GtPQ194vOUr95Or/8HE/F4qLGhBmgAUrUYtf/7JA/nDZfWgs
        CLnnL18aYxDAf+ZnzXWb6h5xBNkYESID5pJspa3wChK48GopzMjXEGvre/m3A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13882787233173972735
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/4] tools/nolibc: unistd.h: apply __sysret() helper
Date:   Tue,  6 Jun 2023 16:11:03 +0800
Message-Id: <52084c2083472421b13d092357819b14f405e0ea.1686036862.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686036862.git.falcon@tinylab.org>
References: <cover.1686036862.git.falcon@tinylab.org>
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

Use __sysret() to shrink the whole _syscall() to oneline code.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/unistd.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index c20b2fbf065e..7e3c005d28ba 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -56,16 +56,7 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
-#define _syscall(N, ...)                                                      \
-({                                                                            \
-	long _ret = my_syscall##N(__VA_ARGS__);                               \
-	if (_ret < 0) {                                                       \
-		SET_ERRNO(-_ret);                                             \
-		_ret = -1;                                                    \
-	}                                                                     \
-	_ret;                                                                 \
-})
-
+#define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
 #define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
 #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
 #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
-- 
2.25.1

