Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2271501A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjE2T5q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjE2T5q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:57:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAC2CF;
        Mon, 29 May 2023 12:57:43 -0700 (PDT)
X-QQ-mid: bizesmtp80t1685390254t729c4zv
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:57:32 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: OXH3MF60TyUJojDygxgZs4OMGkp1TUBtXvEWJdTtHAxot7E3XnB+0jWSYs5Qa
        BpmJ83k0gOTutEc9dsST9cB8jNwauzivhsGGJ+WxNBuD9M9eNdiIZUiSovoSAwtJzVLUqNm
        6l1RtQ45rz9J2I3WLQmOeHihNwFnMtTRziVyjB0iz59ARI+qIWT0VVbOhERipkWFJ3lGSgs
        z31bSq9gRuFfFjPOr/TnPG9HYs05G8i6RHx6VH+8NqisChYzoHDYOtLHXrJQ9UnnJ5xgUiG
        dFCN5lljhXjqrqsg4PxpyT3yteKfbL1fTzNCP55FIWq10KjWQOyKMweMhP0WyvDzHbgWZJr
        TFKLrgmQR/8gwTpM43kNKwXTRSuAGZdl+qjEyHibORah4Pf6S3xUE86Z/xwAHoNYlmIeKbK
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9056491278207555835
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 09/13] tools/nolibc: sys_select: add pure 64bit select
Date:   Tue, 30 May 2023 03:57:23 +0800
Message-Id: <fa047211708451779ddbfabeff749c4d692031ff.1685387484.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685387484.git.falcon@tinylab.org>
References: <cover.1685387484.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It's time to provide 64bit time structs for all platforms, for y2038 is
near.

pselect6_time64 has been added from v4.20 and the last arch support is
at least from v5.0.0.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/76a5f9a0-eec4-415a-9c5d-ac3bca4d4b0e@t-8ch.de/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/bf3e07c1-75f5-425b-9124-f3f2b230e63a@app.fastmail.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-aarch64.h   |  3 ---
 tools/include/nolibc/arch-loongarch.h |  3 ---
 tools/include/nolibc/arch-riscv.h     |  3 ---
 tools/include/nolibc/sys.h            | 25 ++++++++++---------------
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 11f294a406b7..53255a3a326f 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -47,10 +47,7 @@ struct sys_stat_struct {
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
- *
- * On aarch64, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index ad3f266e7093..973fdca96651 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -18,10 +18,7 @@
  *   - the arguments are cast to long and assigned into the target
  *     registers which are then simply passed as registers to the asm code,
  *     so that we don't have to experience issues with register constraints.
- *
- * On LoongArch, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index a2e8564e66d6..713eb9d2c91d 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -53,10 +53,7 @@ struct sys_stat_struct {
  *   - the arguments are cast to long and assigned into the target
  *     registers which are then simply passed as registers to the asm code,
  *     so that we don't have to experience issues with register constraints.
- *
- * On riscv, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 1b3675d4c5fc..db648b5b9a1c 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1046,28 +1046,23 @@ int sched_yield(void)
 static __attribute__((unused))
 int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
 {
-#if defined(__ARCH_WANT_SYS_OLD_SELECT) && !defined(__NR__newselect)
-	struct sel_arg_struct {
-		unsigned long n;
-		fd_set *r, *w, *e;
-		struct timeval *t;
-	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
-	return my_syscall1(__NR_select, &arg);
-#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
+#if defined(__NR_pselect6) || defined(__NR_pselect6_time64)
+#ifdef __NR_pselect6_time64
+	const long nr_pselect = __NR_pselect6_time64;
+#elif __SIZEOF_LONG__ == 8
+	const long nr_pselect = __NR_pselect6;
+#else
+#error No __NR_pselect6_time64 defined, cannot implement time64 sys_select()
+#endif
 	struct timespec t;
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
-	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#elif defined(__NR__newselect) || defined(__NR_select)
-#ifndef __NR__newselect
-#define __NR__newselect __NR_select
-#endif
-	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
+	return my_syscall6(nr_pselect, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #else
-#error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()
+#error Neither __NR_pselect6 nor __NR_pselect6_time64 defined, cannot implement sys_select()
 #endif
 }
 
-- 
2.25.1

