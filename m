Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E9074BE3A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGHPeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHPeg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:34:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDB3B9;
        Sat,  8 Jul 2023 08:34:34 -0700 (PDT)
X-QQ-mid: bizesmtp71t1688830464t9qr84v5
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:34:24 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: RmDZc/K2LPGrTc+Pc4Z2+3faJnbCPSy2B/cQnsYjS8cIDt3lndFeaPYMb6dVv
        66TIx8pcxIbgWY06emMhGeUkT53LMFTNGUbLANkvUosh4MvYKjoocDa18HkvXgsNohOk+wC
        bHUNoPa5KHa6/cZleWKjVTEjELQEGDzT+B8opn1vLcA6YjeBD7WDtm7FTeVzmGk63TiST8I
        2DLzl8HMSz8vMBGSCp5wu+c+RHImsN+H+fHEVmNtVFYBYJWeu7B+Uj8q1FEAMEW3+OKO09B
        CbdCIUjolq+sJuYPJiNBmepGT44pYKlTR8q2AVDDxPAEg5RB5zUzTo1lOnrXhVaOEMncfIa
        i2eTVLw9VQkzBgX0cztOgs6mKU/Ygs8LVo2hYUa+iqsmYIM9dHPMwRLAsrR0A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10461963764472987799
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 08/12] tools/nolibc: x86_64/crt.h: shrink _start with _start_c
Date:   Sat,  8 Jul 2023 23:34:23 +0800
Message-Id: <190ba3df4d2be93a220a8f83a902785adcc4c302.1688828139.git.falcon@tinylab.org>
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
 tools/include/nolibc/x86_64/crt.h | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/tools/include/nolibc/x86_64/crt.h b/tools/include/nolibc/x86_64/crt.h
index 6fede1235efc..03899042854e 100644
--- a/tools/include/nolibc/x86_64/crt.h
+++ b/tools/include/nolibc/x86_64/crt.h
@@ -18,27 +18,16 @@ void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                          */
+		"call __stack_chk_init\n" /* initialize stack protector                      */
 #endif
-		"pop %rdi\n"                /* argc   (first arg, %rdi)                            */
-		"mov %rsp, %rsi\n"          /* argv[] (second arg, %rsi)                           */
-		"lea 8(%rsi,%rdi,8),%rdx\n" /* then a NULL then envp (third arg, %rdx)             */
-		"mov %rdx, environ\n"       /* save environ                                        */
-		"xor %ebp, %ebp\n"          /* zero the stack frame                                */
-		"mov %rdx, %rax\n"          /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"add $8, %rax\n"            /* search for auxv using rax, it follows the           */
-		"cmp -8(%rax), %rbp\n"      /* ... NULL after last env (rbp is zero here)          */
-		"jnz 0b\n"
-		"mov %rax, _auxv\n"         /* save it into _auxv                                  */
-		"and $-16, %rsp\n"          /* x86 ABI : esp must be 16-byte aligned before call   */
-		"call main\n"               /* main() returns the status code, we'll exit with it. */
-		"mov %eax, %edi\n"          /* retrieve exit code (32 bit)                         */
-		"mov $60, %eax\n"           /* NR_exit == 60                                       */
-		"syscall\n"                 /* really exit                                         */
-		"hlt\n"                     /* ensure it does not return                           */
+		"xor  %ebp, %ebp\n"       /* zero the stack frame                            */
+		"mov  %rsp, %rdi\n"       /* save stack pointer to %rdi, as arg1 of _start_c */
+		"and  $-16, %rsp\n"       /* %rsp must be 16-byte aligned before call        */
+		"call _start_c\n"         /* transfer to c runtime                           */
+		"hlt\n"                   /* ensure it does not return                       */
 	);
 	__builtin_unreachable();
+
 }
 
 #endif /* _NOLIBC_X86_64_CRT_H */
-- 
2.25.1

