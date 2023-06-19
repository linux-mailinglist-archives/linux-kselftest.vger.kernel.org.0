Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54387356C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFSM07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 08:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjFSM06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 08:26:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6185C10E4;
        Mon, 19 Jun 2023 05:26:32 -0700 (PDT)
X-QQ-mid: bizesmtp71t1687177555tdy8glxa
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 20:25:54 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: pmyeiOl6PGloDyKgJ78LuhdCTqCBX14MaQlxSqWSUM+fBWGJ1go2bQbmC59zr
        ZOC1Hp/gCPLtjMu7oHsZfH41/31fX48DKVY/lWdsBds7A1tYEynCyJaUHGfuquUlL6q8gQq
        ZOEeIwhtVdjgOAZdo0sja+Z38C7WlcJD+q1KknwTqaXtPukFvLcMgRx23AA+v8vCstIciwA
        3feXF93xbVOZlOq7HuDhut33K4nqNsTxSI8ewXH9QU/BzaYcez48Cc++oXiXl0w23ujad+H
        U/31uRTiGsETodb0LQXimJx5VA7i0n/vg+Zy7/EsjEaDRgM9jkmxslgVZOo2yNGzuzOWoNd
        MhpflHuVQaot1bisFskuxQnRFInxDvfOfWiR2c4yzXLtOUuJDpdOZQmxGW/D/Zd00E6Fvnx
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14529842388647042885
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v5 2/5] tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
Date:   Mon, 19 Jun 2023 20:25:47 +0800
Message-Id: <8c431e766a15d9e08755cd50d550de2a474e7a95.1687176996.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687176996.git.falcon@tinylab.org>
References: <cover.1687176996.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

