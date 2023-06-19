Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4AC735B78
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFSPre (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjFSPrd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:47:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB56A4;
        Mon, 19 Jun 2023 08:47:31 -0700 (PDT)
X-QQ-mid: bizesmtp71t1687189637tfw3qus3
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:47:15 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: FVl8EHhfVR5hTM2MdejT0GIbTUMQnvvUQOWCRxCGR49gRYux9d12G2vVb1lRF
        8nq44JbZnU0bAxj0jSCsfcBSnRc0JIxf/jv3bG/13gWzc3g2D0LkkHTvfJF2apjjfviXc7Z
        CzsdtFb6SMoG0Rg4aRXlRooX7fXnpjG/6m4wWa+KcgD8bp8m+4QaoymFemrnQ4SBC5aTwHe
        C5zEEEN2nDn46AjT8WhSfRULcj588bZGxRL3Nq6UQirUYAVy/3YPM7NnaEH63bX6VUzD6lt
        V0gXqP6ju6pyEStUUX71fZJeb/rH0LOdpd3lRFsptbPeM4NeKX51kaJi+AKMiikSpDE90/C
        P4rfTz822WFFf8KcwQRa8FJoB+Azztezxzl3qZrnw/JLJlyL3pXca5bRlaU81/rWwt1HFvf
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3012571999382365335
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v4 05/10] tools/nolibc: add missing my_syscall6() for mips
Date:   Mon, 19 Jun 2023 23:47:12 +0800
Message-Id: <44abf14c4fa920eadb98833356e517d414b1d66d.1687187451.git.falcon@tinylab.org>
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

It is able to pass the 6th argument like the 5th argument via the stack
for mips, let's add a new my_syscall6() now, see [1] for details:

  The mips/o32 system call convention passes arguments 5 through 8 on
  the user stack.

Both mmap() and pselect6() require my_syscall6().

[1]: https://man7.org/linux/man-pages/man2/syscall.2.html

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-mips.h | 26 ++++++++++++++++++++++++++
 tools/include/nolibc/nolibc.h    |  9 ++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index db24e0837a39..48dd42b4abc3 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -178,6 +178,32 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num __asm__ ("v0") = (num);                            \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+	register long _arg5 = (long)(arg5);                                   \
+	register long _arg6 = (long)(arg6);                                   \
+	                                                                      \
+	__asm__  volatile (                                                   \
+		"addiu $sp, $sp, -32\n"                                       \
+		"sw %7, 16($sp)\n"                                            \
+		"sw %8, 20($sp)\n"                                            \
+		"syscall\n  "                                                 \
+		"addiu $sp, $sp, 32\n"                                        \
+		: "=r" (_num), "=r"(_arg4)                                    \
+		: "0"(_num),                                                  \
+		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
+		  "r"(_arg6)                                                  \
+		: "memory", "cc", "at", "v1", "hi", "lo",                     \
+	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+	);                                                                    \
+	_arg4 ? -_num : _num;                                                 \
+})
+
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 05a228a6ee78..1f8d821000ac 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -13,11 +13,10 @@
  * Syscalls are split into 3 levels:
  *   - The lower level is the arch-specific syscall() definition, consisting in
  *     assembly code in compound expressions. These are called my_syscall0() to
- *     my_syscall6() depending on the number of arguments. The MIPS
- *     implementation is limited to 5 arguments. All input arguments are cast
- *     to a long stored in a register. These expressions always return the
- *     syscall's return value as a signed long value which is often either a
- *     pointer or the negated errno value.
+ *     my_syscall6() depending on the number of arguments. All input arguments
+ *     are castto a long stored in a register. These expressions always return
+ *     the syscall's return value as a signed long value which is often either
+ *     a pointer or the negated errno value.
  *
  *   - The second level is mostly architecture-independent. It is made of
  *     static functions called sys_<name>() which rely on my_syscallN()
-- 
2.25.1

