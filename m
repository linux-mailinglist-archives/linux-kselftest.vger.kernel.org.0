Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A1F70FD5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 20:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjEXSBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEXSBR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 14:01:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610898;
        Wed, 24 May 2023 11:01:14 -0700 (PDT)
X-QQ-mid: bizesmtp75t1684951269t67ndppu
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 02:01:08 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000B00A0000000
X-QQ-FEAT: hoArX50alxHX1mYOrihcB1iZGA+cMKRF18+VTtXY99N55mVqxxcNdy0jsu7Jz
        AcFGpT9by4v33/v8k6d71SGSNut3w5M1Y55V4QKFnuqDFz4e83jelIWCnwnh7ZZM/sT3E7F
        z6uTpi+OMP1Z7jyvBEXLGAs4F6CizZ4L8XY7TfsyP2p/AFUjdFPl7T1OArgl97XQgJkh/6Y
        UFvN8POwUkaWKQhBkorPnFG0okEi1/pIjfr9VCs/vFUjAG/lqDuM5K9BE9462Br2voypj0+
        KqU2y/d9dGgUBYc8VJyjXbBM9c6PjzUS1OidPVawQduEJIza/o8yXXFRHqHoIzmrt3APMEb
        gsgqua+2O/NyW4ZeCqKXTDW6FjzPqNY0tBIaYOff9EXpYK8gO+mip2Uh9tHJw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4020491424755662603
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 11/13] tools/nolibc: sys_select: riscv: use __NR_pselect6_time64 for rv32
Date:   Thu, 25 May 2023 01:59:55 +0800
Message-Id: <9359ab11b52ef7c1799337f475e1e27c0cb00e3b.1684949268.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
__NR_pselect6 after kernel commit d4c08b9776b3 ("riscv: Use latest
system call ABI"), use __NR_pselect6_time64 instead.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index c0335a84f880..00c7197dcd50 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1041,8 +1041,13 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		struct timeval *t;
 	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
 	return my_syscall1(__NR_select, &arg);
-#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
+#elif defined(__ARCH_WANT_SYS_PSELECT6) && (defined(__NR_pselect6) || defined(__NR_pselect6_time64))
+#ifdef __NR_pselect6
 	struct timespec t;
+#else
+	struct timespec64 t;
+#define __NR_pselect6 __NR_pselect6_time64
+#endif
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;
-- 
2.25.1

