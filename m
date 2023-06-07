Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3253725D2A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 13:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjFGLcD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 07:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjFGLcC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 07:32:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D824010CA;
        Wed,  7 Jun 2023 04:31:57 -0700 (PDT)
X-QQ-mid: bizesmtp90t1686137506t0akcs63
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 19:31:45 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: dKvkn8qoLrHe6LOHMBCWXivAD3jSJX56tkAHTePVV6se5edU/yVWT48Z+BxDO
        d4DGxeqgrsnPJ4fbTy+ZEMF8RMEdgl8zXU7OdTTO9L9RqxLBdwC87y/40SdiVhpCEdHHvtX
        xIIgsl9eCnWP1PIRp4Pkhnm4QdwRpuCW+0IT88p2iV00eJwNRnyxsoG58G0v4enZ2XhUkMa
        SpXG6UsK/2KquLDDbzmmbT2ZRqCRoLMecnsZz1Twz3kR4YlzLU6xwq9EOTUo0vnEsKXtKHl
        Z2O+l+T6Tx+eQ6bKu7zRTy2NonNIfDFNuxuvoSa6f9yDloKT/lZEoUTIXaI0XtPMAdFZPO5
        LqkqOKBaTEkhkwzHDco4hD4piuu1r7UIs/LdG6JBGsyVyjJXV5773+B4SgSVEsT2smFnQ+O
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3202086989928057354
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/3] tools/nolibc: unistd.h: apply __sysret() helper
Date:   Wed,  7 Jun 2023 19:31:39 +0800
Message-Id: <af5635d5e7a10429fe30b79e090e67bbec707195.1686135913.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686135913.git.falcon@tinylab.org>
References: <cover.1686135913.git.falcon@tinylab.org>
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

