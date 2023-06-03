Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF32720ED5
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjFCJDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFCJDV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 05:03:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FAC1BB;
        Sat,  3 Jun 2023 02:03:18 -0700 (PDT)
X-QQ-mid: bizesmtp76t1685782989t9lb8av7
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 17:03:08 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: /+iK7ZpVlLT+meya2RLyMQl070OIddaVNI9G1y5G8+TvTKWsfOc8JNv+7BK7y
        RKv9TegIR10DaoHy8oH6VC39YXFThvF3r2eoaezrq1kS22HCWwdup1DPRVl2DdMaR9WkMs9
        keMUjAfFGvoRvkbbQIl20PebzYruePczV9S6XOcJisPXAQqKpU7CDe9vtuMoYadkIj29Lnw
        o4jvKADJagdCzLM7K3+hZTQ5oJQ+1CvJ/S11x/01xmu4P1fjgtZjRRuyTeAznKwRJ5CEEQy
        9Gfn81VmVLrEaEUgroPsUmnxKXU5smYo/nS4NWASsoXvmjEVfsIwUbUBgT57YWhAsaEKiGv
        cNf2x0/4PmmKOFdFJDBjI3ULrKU3qoYkSo8Z55ACWrfMxA5JsNgMIVn85rB35dwWo6CUW1J
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3791833262952156128
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 1/3] tools/nolibc: fix up #error compile failures with -ENOSYS
Date:   Sat,  3 Jun 2023 17:01:58 +0800
Message-Id: <f2776eb566b8cf2409d2c21f83ebf85ab92d2f09.1685780412.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685780412.git.falcon@tinylab.org>
References: <cover.1685780412.git.falcon@tinylab.org>
MIME-Version: 1.0
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

    In file included from nolibc/sysroot/riscv/include/nolibc.h:99,
                     from nolibc/sysroot/riscv/include/errno.h:26,
                     from nolibc/sysroot/riscv/include/stdio.h:14,
                     from tools/testing/selftests/nolibc/nolibc-test.c:12:
    nolibc/sysroot/riscv/include/sys.h:946:2: error: #error Neither __NR_ppoll nor __NR_poll defined, cannot implement sys_poll()
      946 | #error Neither __NR_ppoll nor __NR_poll defined, cannot implement sys_poll()
          |  ^~~~~
    nolibc/sysroot/riscv/include/sys.h:1062:2: error: #error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()
     1062 | #error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()

If a syscall is not supported by a target platform, 'return -ENOSYS' is
better than '#error', which lets the other syscalls work as-is and
allows developers to fix up the test failures reported by nolibc-test
one by one later.

This converts all of the '#error' to 'return -ENOSYS', so, all of the
'#error' failures are fixed.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 856249a11890..78c86f124335 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -124,7 +124,7 @@ int sys_chmod(const char *path, mode_t mode)
 #elif defined(__NR_chmod)
 	return my_syscall2(__NR_chmod, path, mode);
 #else
-#error Neither __NR_fchmodat nor __NR_chmod defined, cannot implement sys_chmod()
+	return -ENOSYS;
 #endif
 }
 
@@ -153,7 +153,7 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
 #elif defined(__NR_chown)
 	return my_syscall3(__NR_chown, path, owner, group);
 #else
-#error Neither __NR_fchownat nor __NR_chown defined, cannot implement sys_chown()
+	return -ENOSYS;
 #endif
 }
 
@@ -251,7 +251,7 @@ int sys_dup2(int old, int new)
 #elif defined(__NR_dup2)
 	return my_syscall2(__NR_dup2, old, new);
 #else
-#error Neither __NR_dup3 nor __NR_dup2 defined, cannot implement sys_dup2()
+	return -ENOSYS;
 #endif
 }
 
@@ -351,7 +351,7 @@ pid_t sys_fork(void)
 #elif defined(__NR_fork)
 	return my_syscall0(__NR_fork);
 #else
-#error Neither __NR_clone nor __NR_fork defined, cannot implement sys_fork()
+	return -ENOSYS;
 #endif
 }
 #endif
@@ -648,7 +648,7 @@ int sys_link(const char *old, const char *new)
 #elif defined(__NR_link)
 	return my_syscall2(__NR_link, old, new);
 #else
-#error Neither __NR_linkat nor __NR_link defined, cannot implement sys_link()
+	return -ENOSYS;
 #endif
 }
 
@@ -700,7 +700,7 @@ int sys_mkdir(const char *path, mode_t mode)
 #elif defined(__NR_mkdir)
 	return my_syscall2(__NR_mkdir, path, mode);
 #else
-#error Neither __NR_mkdirat nor __NR_mkdir defined, cannot implement sys_mkdir()
+	return -ENOSYS;
 #endif
 }
 
@@ -729,7 +729,7 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
 #elif defined(__NR_mknod)
 	return my_syscall3(__NR_mknod, path, mode, dev);
 #else
-#error Neither __NR_mknodat nor __NR_mknod defined, cannot implement sys_mknod()
+	return -ENOSYS;
 #endif
 }
 
@@ -848,7 +848,7 @@ int sys_open(const char *path, int flags, mode_t mode)
 #elif defined(__NR_open)
 	return my_syscall3(__NR_open, path, flags, mode);
 #else
-#error Neither __NR_openat nor __NR_open defined, cannot implement sys_open()
+	return -ENOSYS;
 #endif
 }
 
@@ -943,7 +943,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else
-#error Neither __NR_ppoll nor __NR_poll defined, cannot implement sys_poll()
+	return -ENOSYS;
 #endif
 }
 
@@ -1059,7 +1059,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 #endif
 	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
 #else
-#error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()
+	return -ENOSYS;
 #endif
 }
 
@@ -1196,7 +1196,7 @@ int sys_stat(const char *path, struct stat *buf)
 #elif defined(__NR_stat)
 	ret = my_syscall2(__NR_stat, path, &stat);
 #else
-#error Neither __NR_newfstatat nor __NR_stat defined, cannot implement sys_stat()
+	return -ENOSYS;
 #endif
 	buf->st_dev          = stat.st_dev;
 	buf->st_ino          = stat.st_ino;
@@ -1243,7 +1243,7 @@ int sys_symlink(const char *old, const char *new)
 #elif defined(__NR_symlink)
 	return my_syscall2(__NR_symlink, old, new);
 #else
-#error Neither __NR_symlinkat nor __NR_symlink defined, cannot implement sys_symlink()
+	return -ENOSYS;
 #endif
 }
 
@@ -1312,7 +1312,7 @@ int sys_unlink(const char *path)
 #elif defined(__NR_unlink)
 	return my_syscall1(__NR_unlink, path);
 #else
-#error Neither __NR_unlinkat nor __NR_unlink defined, cannot implement sys_unlink()
+	return -ENOSYS;
 #endif
 }
 
-- 
2.25.1

