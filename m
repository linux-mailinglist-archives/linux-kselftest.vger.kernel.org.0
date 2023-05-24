Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C427870FD4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEXR4Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEXR4X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:56:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10F7D3;
        Wed, 24 May 2023 10:56:21 -0700 (PDT)
X-QQ-mid: bizesmtp83t1684950976taj01xsk
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:56:14 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3heRPkZGAvThL5q8yJbl4iq2g+n/V08QcrkuDixKCO+Kd5/chZ81
        RzQT/uozjLZp+bJTDwM4DrjefAVoP6YAkePF7XNpTK/nJeuf9WQLmw0zG25rrehB1prqfgh
        Mxe/FZ2oQE83jxi0IwkPYBpg1nhziKdy250rcb2fxzd2Y14WfvDQutJBG35HFVq8BnVLs7O
        P8KDx0A/JpQyxXInpBxAh2ptKYxoEApcMkJMZmv56mSHAl/oZrtg2VYwPJm4gT9nt9jEq1L
        c4eGTgncEQWLJLlWkWX99AdeN6dGvF7IcjRuEmGdHroUaPPPUybeEoz2wiy/oTiy6tvnQ3v
        Dn5Dy/0Ii+6Wiu+MMEXg7lf4YzUemtxh5Zhk5Dp+Tsn/rDdZtH0dxeEjPUGUQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1222464122104175739
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 08/13] tools/nolibc: sys_lseek: riscv: use __NR_llseek for rv32
Date:   Thu, 25 May 2023 01:55:39 +0800
Message-Id: <f25526b466803d6826dd9c5bb1489a5276cf58b0.1684949268.git.falcon@tinylab.org>
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

riscv uses the generic include/uapi/asm-generic/unistd.h, it has code
like this:

  #if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
  #define __NR_lseek __NR3264_lseek
  #else
  #define __NR_llseek __NR3264_lseek
  #endif

There is no __NR_lseek for rv32, use __NR_llseek instead.

This code is based on sysdeps/unix/sysv/linux/lseek.c of glibc.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/std.h |  1 +
 tools/include/nolibc/sys.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 933bc0be7e1c..83c0b0cb9564 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -32,5 +32,6 @@ typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
 typedef   signed long        time_t;
+typedef     long long        loff_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index d5792a5de70b..0ff77c0a06d7 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -671,7 +671,25 @@ int link(const char *old, const char *new)
 static __attribute__((unused))
 off_t sys_lseek(int fd, off_t offset, int whence)
 {
+#ifdef __NR_lseek
 	return my_syscall3(__NR_lseek, fd, offset, whence);
+#elif defined(__NR_llseek)
+	loff_t result;
+	off_t retval;
+	int ret;
+
+	ret = my_syscall5(__NR_llseek, fd, (long) (((uint64_t) (offset)) >> 32), (long) offset, &result, whence);
+	if (ret)
+		return ret;
+
+	retval = (off_t) result;
+	if (retval != result)
+		return -EOVERFLOW;
+
+	return retval;
+#else
+#error Neither __NR_lseek nor __NR_llseek defined, cannot implement sys_lseek()
+#endif
 }
 
 static __attribute__((unused))
-- 
2.25.1

