Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD074BE36
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGHPcW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGHPcV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:32:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1167E183;
        Sat,  8 Jul 2023 08:32:19 -0700 (PDT)
X-QQ-mid: bizesmtp80t1688830330tnbi25mx
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:32:09 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: SFhf6fKhx/9392JZYlaBcqX7N+KA6AjdqY1MUs2G5hwRQSRVRqVb4QisWKQCO
        HfhGqBYbrXmkVF/kYZsdUHeGXXQhKWidRRUaqBB1u8jAKIlSClrHsv3QmEPoBm6bTCau/uE
        YJSj4Dac4bu8YDSDODE2VmpPIgcaXvEpHZyVWD6j84onxlxz/KhIWyGwJZtvoMZrXMxa79+
        n9FTpbOp45V7syHlg8/MdkC8BXeTYttJduk3gdqrOClUB8tDBeiKf5AdYlxPQe21Z2e1mRk
        mz2DU8cSRnzoDThE4vWcjevDWjg3AiClpBwUr/z2DevYJrfDGc9ceFyjA/0pCyiL0X2k9cl
        yMqtgMU65tz8L4kJ7mJOXSKE5Naiz1UsNYY3DtFBW0gTxMX35najJkiiICOYw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9503456289267630914
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 06/12] tools/nolibc: aarch64/crt.h: shrink _start with _start_c
Date:   Sat,  8 Jul 2023 23:32:09 +0800
Message-Id: <45f8e3a6bef02996cdd97b672b3e350a9a90b626.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
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

move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/aarch64/crt.h | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/tools/include/nolibc/aarch64/crt.h b/tools/include/nolibc/aarch64/crt.h
index 6c81d81cf31f..4e04c421ab63 100644
--- a/tools/include/nolibc/aarch64/crt.h
+++ b/tools/include/nolibc/aarch64/crt.h
@@ -12,26 +12,13 @@ void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"   /* initialize stack protector                     */
+		"bl __stack_chk_init\n" /* initialize stack protector                    */
 #endif
-		"ldr x0, [sp]\n"     /* argc (x0) was in the stack                          */
-		"add x1, sp, 8\n"    /* argv (x1) = sp                                      */
-		"lsl x2, x0, 3\n"    /* envp (x2) = 8*argc ...                              */
-		"add x2, x2, 8\n"    /*           + 8 (skip null)                           */
-		"add x2, x2, x1\n"   /*           + argv                                    */
-		"adrp x3, environ\n"          /* x3 = &environ (high bits)                  */
-		"str x2, [x3, #:lo12:environ]\n" /* store envp into environ                 */
-		"mov x4, x2\n"       /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"ldr x5, [x4], 8\n"  /* x5 = *x4; x4 += 8                                   */
-		"cbnz x5, 0b\n"      /* and stop at NULL after last env                     */
-		"adrp x3, _auxv\n"   /* x3 = &_auxv (high bits)                             */
-		"str x4, [x3, #:lo12:_auxv]\n" /* store x4 into _auxv                       */
-		"and sp, x1, -16\n"  /* sp must be 16-byte aligned in the callee            */
-		"bl main\n"          /* main() returns the status code, we'll exit with it. */
-		"mov x8, 93\n"       /* NR_exit == 93                                       */
-		"svc #0\n"
+		"mov x0, sp\n"          /* save stack pointer to x0, as arg1 of _start_c */
+		"and sp, x0, -16\n"     /* sp must be 16-byte aligned in the callee      */
+		"bl  _start_c\n"        /* transfer to c runtime                         */
 	);
 	__builtin_unreachable();
+
 }
 #endif /* _NOLIBC_AARCH64_CRT_H */
-- 
2.25.1

