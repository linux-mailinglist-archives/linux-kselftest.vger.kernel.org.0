Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B351F7A3657
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjIQPhG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjIQPgg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 11:36:36 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CBFA;
        Sun, 17 Sep 2023 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694964988;
        bh=Kd7GKLDLXksFJfiA80JZxSw1ujvuMQ52Z8zyi0PXrrE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uGZi+a2s7YCC8X6OXifmQaalx/UCazKGCDAcBs8bKPudTZomZNr2C+WM+oNU/oPat
         S6H5T9pHI1a0ur2zWBrJ3FiuQr1E+uQuuulL9K8o+g/dBMdVjH7jIHJzntn0UdFuU/
         IxLPQaiB/wlHGLbyqUKHma2GBSgMPA8fNT+JU47k=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 17 Sep 2023 17:36:17 +0200
Subject: [PATCH v2 2/4] tools/nolibc: avoid unused parameter warnings for
 ENOSYS fallbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230917-nolibc-syscall-nr-v2-2-03863d509b9a@weissschuh.net>
References: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
In-Reply-To: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694964977; l=5233;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Kd7GKLDLXksFJfiA80JZxSw1ujvuMQ52Z8zyi0PXrrE=;
 b=XwOvyRGPpz62PEO1mHwwgUjtiZze0jEapfYPwOr/ySCCHaaVfpWLRDWMJiJ/WnglbeDyEn4Ia
 Zc2jwm89BSjDozRCzvUCpAXOVCGkctGNX1iWn6TZzLmV+CwxyNSf9tT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ENOSYS fallback code does not use its functions parameters.
This can lead to compiler warnings about unused parameters.

Explicitly avoid these warnings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b478750c9004..8389820e1928 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -43,6 +43,16 @@
 		: __sysret_arg;                         /* return original value */ \
 })
 
+/* Syscall ENOSYS helper: Avoids unused-parameter warnings and provides a
+ * debugging hook.
+ */
+
+static __inline__ int __nolibc_enosys(const char *syscall, ...)
+{
+	(void)syscall;
+	return -ENOSYS;
+}
+
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
@@ -133,7 +143,7 @@ int sys_chmod(const char *path, mode_t mode)
 #elif defined(__NR_chmod)
 	return my_syscall2(__NR_chmod, path, mode);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, mode);
 #endif
 }
 
@@ -156,7 +166,7 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
 #elif defined(__NR_chown)
 	return my_syscall3(__NR_chown, path, owner, group);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, owner, group);
 #endif
 }
 
@@ -230,7 +240,7 @@ int sys_dup2(int old, int new)
 #elif defined(__NR_dup2)
 	return my_syscall2(__NR_dup2, old, new);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, old, new);
 #endif
 }
 
@@ -312,7 +322,7 @@ pid_t sys_fork(void)
 #elif defined(__NR_fork)
 	return my_syscall0(__NR_fork);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__);
 #endif
 }
 #endif
@@ -486,7 +496,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 #ifdef __NR_gettimeofday
 	return my_syscall2(__NR_gettimeofday, tv, tz);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, tv, tz);
 #endif
 }
 
@@ -563,7 +573,7 @@ int sys_link(const char *old, const char *new)
 #elif defined(__NR_link)
 	return my_syscall2(__NR_link, old, new);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, old, new);
 #endif
 }
 
@@ -584,7 +594,7 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 #ifdef __NR_lseek
 	return my_syscall3(__NR_lseek, fd, offset, whence);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, fd, offset, whence);
 #endif
 }
 
@@ -607,7 +617,7 @@ int sys_mkdir(const char *path, mode_t mode)
 #elif defined(__NR_mkdir)
 	return my_syscall2(__NR_mkdir, path, mode);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, mode);
 #endif
 }
 
@@ -629,7 +639,7 @@ int sys_rmdir(const char *path)
 #elif defined(__NR_unlinkat)
 	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, AT_REMOVEDIR);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path);
 #endif
 }
 
@@ -652,7 +662,7 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
 #elif defined(__NR_mknod)
 	return my_syscall3(__NR_mknod, path, mode, dev);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, mode, dev);
 #endif
 }
 
@@ -742,7 +752,7 @@ int sys_open(const char *path, int flags, mode_t mode)
 #elif defined(__NR_open)
 	return my_syscall3(__NR_open, path, flags, mode);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, flags, mode);
 #endif
 }
 
@@ -842,7 +852,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, fds, nfds, timeout);
 #endif
 }
 
@@ -934,7 +944,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 #endif
 	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, nfds, rfds, wfds, efds, timeout);
 #endif
 }
 
@@ -989,7 +999,7 @@ int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct sta
 #ifdef __NR_statx
 	return my_syscall5(__NR_statx, fd, path, flags, mask, buf);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, fd, path, flags, mask, buf);
 #endif
 }
 
@@ -1047,7 +1057,7 @@ int sys_symlink(const char *old, const char *new)
 #elif defined(__NR_symlink)
 	return my_syscall2(__NR_symlink, old, new);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, old, new);
 #endif
 }
 
@@ -1104,7 +1114,7 @@ int sys_unlink(const char *path)
 #elif defined(__NR_unlink)
 	return my_syscall1(__NR_unlink, path);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path);
 #endif
 }
 
@@ -1127,7 +1137,7 @@ pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 #ifdef __NR_wait4
 	return my_syscall4(__NR_wait4, pid, status, options, rusage);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, pid, status, options, rusage);
 #endif
 }
 

-- 
2.42.0

