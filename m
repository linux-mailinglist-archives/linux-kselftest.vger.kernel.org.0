Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D82720ED8
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 11:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbjFCJFC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFCJFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 05:05:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F6E56;
        Sat,  3 Jun 2023 02:04:59 -0700 (PDT)
X-QQ-mid: bizesmtp85t1685783090tuggc0mf
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 17:04:49 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: 7aHzntQn+UDHWzdTWpnJ/o+QEDhVowL/EH/i/fZBEdZqSAhhL5+pk34byH2Y5
        kzLZBz9qzzO0LP7M+PHEtGEIMj8KpN0Glze3AWMa2ZIfxU/SvPwyc9Aa+8xPzPVir/sy1Aq
        KT3Zbu29n8BjDugTZ9m11vay+P3VJC2mSUwnJ4qxmYg4oTSyqLFXJgJ+WZPFXp993qh/a+Z
        zCdQJ/oTJCl6Q+WrnkmPUwenBidK5AngUE7qtZZvIDdjHmT03Us1ykhpzts22qNACVokfWX
        UEWPEo9i8QuM2Ge+WRNEkvl9tU5a/xj5WytSvIRNnldYygYj9PtwEo5FCjzizT0ZAQPHGK5
        8qirc5kUl/BjHnumj7Hv6kkmRw0JMb+ifxJwUlYqlQ9HPJzHwKu2zfUKDBaW/uGb4mFlarp
        2I9DDIpEOdw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10955599285119131163
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 2/3] tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
Date:   Sat,  3 Jun 2023 17:04:17 +0800
Message-Id: <a81040d90ad9f2042f653acdeb1d53b29a259028.1685780412.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685780412.git.falcon@tinylab.org>
References: <cover.1685780412.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

