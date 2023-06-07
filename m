Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9441725AA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbjFGJg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbjFGJgZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 05:36:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18A31BC2;
        Wed,  7 Jun 2023 02:36:03 -0700 (PDT)
X-QQ-mid: bizesmtp71t1686130553tmsdhqdy
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 17:35:52 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: lkL5M32tl2CKtzfdmJppNXVfPo4dxxS2i5yjRnmFQwVRtg9qihhO/bdGb8f45
        yWn2uxZLxaR03l3EEyG3ZSe+rmOHf0zQcc978/tiuiHl9/xeA/a5gsfw1Iz5iwm9HgXYtxx
        PP8ebuEvcyWxkYw5KtdUj/NMNt0ADHXsRQs4S7w5o7GFUXvGt70EaVa1Z9M2HAzmkU0j/3+
        Ly/ztVpho8T0NWn1hGi9u1c3QjZoSjFOtbvsYaVB9tnmAOJ4B3oiKbDMiv+FjFA+JDdXPCE
        Izip3hN+MT1jbZAgpNtiTLAHenU2xXWtiLfC3EzFz8W4ty+E3z3Xdes0vghwexbdeA149FC
        1h5T5I9ph8YUWFsHRh2goaMbO2tFv9l+YES8qlLlsYf4mDSk5c1NABZFvisRPFGLWZakBFf
        qSvd39YkcwE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14568529187218780332
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/3] tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
Date:   Wed,  7 Jun 2023 17:27:52 +0800
Message-Id: <1b2ace57de2f47ae0da4457845594baf59f7e06d.1686128703.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686128703.git.falcon@tinylab.org>
References: <cover.1686128703.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Compiling nolibc for rv32 got such errors:

    nolibc/sysroot/riscv/include/sys.h: In function ‘sys_gettimeofday’:
    nolibc/sysroot/riscv/include/sys.h:557:21: error: ‘__NR_gettimeofday’ undeclared (first use in this function); did you mean ‘sys_gettimeofday’?
      557 |  return my_syscall2(__NR_gettimeofday, tv, tz);
          |                     ^~~~~~~~~~~~~~~~~
    nolibc/sysroot/riscv/include/sys.h: In function ‘sys_lseek’:
    nolibc/sysroot/riscv/include/sys.h:675:21: error: ‘__NR_lseek’ undeclared (first use in this function)
      675 |  return my_syscall3(__NR_lseek, fd, offset, whence);
          |                     ^~~~~~~~~~
    nolibc/sysroot/riscv/include/sys.h: In function ‘sys_wait4’:
    nolibc/sysroot/riscv/include/sys.h:1341:21: error: ‘__NR_wait4’ undeclared (first use in this function)
     1341 |  return my_syscall4(__NR_wait4, pid, status, options, rusage);

If a syscall macro is not supported by a target platform, wrap it with
'#ifdef' and 'return -ENOSYS' for the '#else' branch, which lets the
other syscalls work as-is and allows developers to fix up the test
failures reported by nolibc-test one by one later.

This wraps all of the failed syscall macros with '#ifdef' and 'return
-ENOSYS' for the '#else' branch, so, all of the undeclared failures are
fixed.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com/
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 78c86f124335..5464f93e863e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -554,7 +554,11 @@ long getpagesize(void)
 static __attribute__((unused))
 int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
+#ifdef __NR_gettimeofday
 	return my_syscall2(__NR_gettimeofday, tv, tz);
+#else
+	return -ENOSYS;
+#endif
 }
 
 static __attribute__((unused))
@@ -672,7 +676,11 @@ int link(const char *old, const char *new)
 static __attribute__((unused))
 off_t sys_lseek(int fd, off_t offset, int whence)
 {
+#ifdef __NR_lseek
 	return my_syscall3(__NR_lseek, fd, offset, whence);
+#else
+	return -ENOSYS;
+#endif
 }
 
 static __attribute__((unused))
@@ -1338,7 +1346,11 @@ int unlink(const char *path)
 static __attribute__((unused))
 pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 {
+#ifdef __NR_wait4
 	return my_syscall4(__NR_wait4, pid, status, options, rusage);
+#else
+	return -ENOSYS;
+#endif
 }
 
 static __attribute__((unused))
-- 
2.25.1

