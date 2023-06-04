Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B607214F8
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 07:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFDFqC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 01:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjFDFpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C12710FA;
        Sat,  3 Jun 2023 22:45:30 -0700 (PDT)
X-QQ-mid: bizesmtp74t1685857519t0x8zryb
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 04 Jun 2023 13:45:18 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: k0mQ4ihyJQNhZgjLnbfL7HCaFDgVKYuM1kJqwk8p56+jzW2yx/W+okDk8osaV
        Lg8uL+Xt+N5tzChN4aOjAi7U0xipva9vNgmF05ZRtV6ZFu7JgsMRO1oQ2B0KNgQAaiqlxGW
        6kEicqhzo2KaeYMm+7AvGGkM6xlPhNguVPJc0zj6Nhj1AKiNazsAN0RMnayd3av0lnQZNeI
        63NG1LkOkrGtz1uU9Oor9J4lKW/ToBiKJnlc4xpmSg+7m55yXvlNc3zGX1Q6j4/kaMt3JEA
        9nt/UfODaLrX4DmRtWieMyIzbSqoBlxG0+0XNWNY6b2jHFpPnY0yANZcp2YH5/TMOd3tgDN
        YDVtbWVQtXTbGKO06+Y2iimGeIWUy8NqCoL77vFmKucyN9a9gA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3837813299015765052
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 4/4] tools/nolibc: sys.h: apply __syscall() helper
Date:   Sun,  4 Jun 2023 13:43:34 +0800
Message-Id: <472e4986e3b217ba42b4ca798dcb32b11ea89a72.1685856497.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685856497.git.falcon@tinylab.org>
References: <cover.1685856497.git.falcon@tinylab.org>
MIME-Version: 1.0
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

Use __syscall() helper to shrink 252 lines of code.

    $ git show HEAD^:tools/include/nolibc/sys.h | wc -l
    1432
    $ git show HEAD:tools/include/nolibc/sys.h | wc -l
    1180
    $ echo "1432-1180" | bc -l
    252

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 336 +++++--------------------------------
 1 file changed, 42 insertions(+), 294 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 976f23d1fdad..1f64f760d7fd 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -113,13 +113,7 @@ int sys_chdir(const char *path)
 static __attribute__((unused))
 int chdir(const char *path)
 {
-	int ret = sys_chdir(path);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(chdir, path);
 }
 
 
@@ -142,13 +136,7 @@ int sys_chmod(const char *path, mode_t mode)
 static __attribute__((unused))
 int chmod(const char *path, mode_t mode)
 {
-	int ret = sys_chmod(path, mode);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(chmod, path, mode);
 }
 
 
@@ -171,13 +159,7 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
 static __attribute__((unused))
 int chown(const char *path, uid_t owner, gid_t group)
 {
-	int ret = sys_chown(path, owner, group);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(chown, path, owner, group);
 }
 
 
@@ -194,13 +176,7 @@ int sys_chroot(const char *path)
 static __attribute__((unused))
 int chroot(const char *path)
 {
-	int ret = sys_chroot(path);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(chroot, path);
 }
 
 
@@ -217,13 +193,7 @@ int sys_close(int fd)
 static __attribute__((unused))
 int close(int fd)
 {
-	int ret = sys_close(fd);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(close, fd);
 }
 
 
@@ -240,13 +210,7 @@ int sys_dup(int fd)
 static __attribute__((unused))
 int dup(int fd)
 {
-	int ret = sys_dup(fd);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(dup, fd);
 }
 
 
@@ -269,13 +233,7 @@ int sys_dup2(int old, int new)
 static __attribute__((unused))
 int dup2(int old, int new)
 {
-	int ret = sys_dup2(old, new);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(dup2, old, new);
 }
 
 
@@ -293,13 +251,7 @@ int sys_dup3(int old, int new, int flags)
 static __attribute__((unused))
 int dup3(int old, int new, int flags)
 {
-	int ret = sys_dup3(old, new, flags);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(dup3, old, new, flags);
 }
 #endif
 
@@ -317,13 +269,7 @@ int sys_execve(const char *filename, char *const argv[], char *const envp[])
 static __attribute__((unused))
 int execve(const char *filename, char *const argv[], char *const envp[])
 {
-	int ret = sys_execve(filename, argv, envp);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(execve, filename, argv, envp);
 }
 
 
@@ -370,13 +316,7 @@ pid_t sys_fork(void)
 static __attribute__((unused))
 pid_t fork(void)
 {
-	pid_t ret = sys_fork();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(fork);
 }
 
 
@@ -393,13 +333,7 @@ int sys_fsync(int fd)
 static __attribute__((unused))
 int fsync(int fd)
 {
-	int ret = sys_fsync(fd);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(fsync, fd);
 }
 
 
@@ -416,13 +350,7 @@ int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
 static __attribute__((unused))
 int getdents64(int fd, struct linux_dirent64 *dirp, int count)
 {
-	int ret = sys_getdents64(fd, dirp, count);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(getdents64, fd, dirp, count);
 }
 
 
@@ -460,13 +388,7 @@ pid_t sys_getpgid(pid_t pid)
 static __attribute__((unused))
 pid_t getpgid(pid_t pid)
 {
-	pid_t ret = sys_getpgid(pid);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(getpgid, pid);
 }
 
 
@@ -565,13 +487,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 static __attribute__((unused))
 int gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-	int ret = sys_gettimeofday(tv, tz);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(gettimeofday, tv, tz);
 }
 
 
@@ -609,13 +525,7 @@ int sys_ioctl(int fd, unsigned long req, void *value)
 static __attribute__((unused))
 int ioctl(int fd, unsigned long req, void *value)
 {
-	int ret = sys_ioctl(fd, req, value);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(ioctl, fd, req, value);
 }
 
 /*
@@ -631,13 +541,7 @@ int sys_kill(pid_t pid, int signal)
 static __attribute__((unused))
 int kill(pid_t pid, int signal)
 {
-	int ret = sys_kill(pid, signal);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(kill, pid, signal);
 }
 
 
@@ -660,13 +564,7 @@ int sys_link(const char *old, const char *new)
 static __attribute__((unused))
 int link(const char *old, const char *new)
 {
-	int ret = sys_link(old, new);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(link, old, new);
 }
 
 
@@ -683,13 +581,7 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 static __attribute__((unused))
 off_t lseek(int fd, off_t offset, int whence)
 {
-	off_t ret = sys_lseek(fd, offset, whence);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(lseek, fd, offset, whence);
 }
 
 
@@ -712,13 +604,7 @@ int sys_mkdir(const char *path, mode_t mode)
 static __attribute__((unused))
 int mkdir(const char *path, mode_t mode)
 {
-	int ret = sys_mkdir(path, mode);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(mkdir, path, mode);
 }
 
 
@@ -741,13 +627,7 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
 static __attribute__((unused))
 int mknod(const char *path, mode_t mode, dev_t dev)
 {
-	int ret = sys_mknod(path, mode, dev);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(mknod, path, mode, dev);
 }
 
 #ifndef MAP_SHARED
@@ -805,13 +685,7 @@ int sys_munmap(void *addr, size_t length)
 static __attribute__((unused))
 int munmap(void *addr, size_t length)
 {
-	int ret = sys_munmap(addr, length);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(munmap, addr, length);
 }
 
 /*
@@ -831,13 +705,7 @@ int mount(const char *src, const char *tgt,
           const char *fst, unsigned long flags,
           const void *data)
 {
-	int ret = sys_mount(src, tgt, fst, flags, data);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(mount, src, tgt, fst, flags, data);
 }
 
 
@@ -871,13 +739,7 @@ int open(const char *path, int flags, ...)
 		va_end(args);
 	}
 
-	ret = sys_open(path, flags, mode);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(open, path, flags, mode);
 }
 
 
@@ -897,13 +759,7 @@ static __attribute__((unused))
 int prctl(int option, unsigned long arg2, unsigned long arg3,
 		      unsigned long arg4, unsigned long arg5)
 {
-	int ret = sys_prctl(option, arg2, arg3, arg4, arg5);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(prctl, option, arg2, arg3, arg4, arg5);
 }
 
 
@@ -920,13 +776,7 @@ int sys_pivot_root(const char *new, const char *old)
 static __attribute__((unused))
 int pivot_root(const char *new, const char *old)
 {
-	int ret = sys_pivot_root(new, old);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(pivot_root, new, old);
 }
 
 
@@ -955,13 +805,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 static __attribute__((unused))
 int poll(struct pollfd *fds, int nfds, int timeout)
 {
-	int ret = sys_poll(fds, nfds, timeout);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(poll, fds, nfds, timeout);
 }
 
 
@@ -978,13 +822,7 @@ ssize_t sys_read(int fd, void *buf, size_t count)
 static __attribute__((unused))
 ssize_t read(int fd, void *buf, size_t count)
 {
-	ssize_t ret = sys_read(fd, buf, count);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(read, fd, buf, count);
 }
 
 
@@ -1002,13 +840,7 @@ ssize_t sys_reboot(int magic1, int magic2, int cmd, void *arg)
 static __attribute__((unused))
 int reboot(int cmd)
 {
-	int ret = sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0);
 }
 
 
@@ -1025,13 +857,7 @@ int sys_sched_yield(void)
 static __attribute__((unused))
 int sched_yield(void)
 {
-	int ret = sys_sched_yield();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(sched_yield);
 }
 
 
@@ -1071,13 +897,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 static __attribute__((unused))
 int select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
 {
-	int ret = sys_select(nfds, rfds, wfds, efds, timeout);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(select, nfds, rfds, wfds, efds, timeout);
 }
 
 
@@ -1094,13 +914,7 @@ int sys_setpgid(pid_t pid, pid_t pgid)
 static __attribute__((unused))
 int setpgid(pid_t pid, pid_t pgid)
 {
-	int ret = sys_setpgid(pid, pgid);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(setpgid, pid, pgid);
 }
 
 
@@ -1117,13 +931,7 @@ pid_t sys_setsid(void)
 static __attribute__((unused))
 pid_t setsid(void)
 {
-	pid_t ret = sys_setsid();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(setsid);
 }
 
 #if defined(__NR_statx)
@@ -1140,13 +948,7 @@ int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct sta
 static __attribute__((unused))
 int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
 {
-	int ret = sys_statx(fd, path, flags, mask, buf);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(statx, fd, path, flags, mask, buf);
 }
 #endif
 
@@ -1223,13 +1025,7 @@ int sys_stat(const char *path, struct stat *buf)
 static __attribute__((unused))
 int stat(const char *path, struct stat *buf)
 {
-	int ret = sys_stat(path, buf);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(stat, path, buf);
 }
 
 
@@ -1252,13 +1048,7 @@ int sys_symlink(const char *old, const char *new)
 static __attribute__((unused))
 int symlink(const char *old, const char *new)
 {
-	int ret = sys_symlink(old, new);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(symlink, old, new);
 }
 
 
@@ -1292,13 +1082,7 @@ int sys_umount2(const char *path, int flags)
 static __attribute__((unused))
 int umount2(const char *path, int flags)
 {
-	int ret = sys_umount2(path, flags);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(umount2, path, flags);
 }
 
 
@@ -1321,13 +1105,7 @@ int sys_unlink(const char *path)
 static __attribute__((unused))
 int unlink(const char *path)
 {
-	int ret = sys_unlink(path);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(unlink, path);
 }
 
 
@@ -1346,38 +1124,20 @@ pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 static __attribute__((unused))
 pid_t wait(int *status)
 {
-	pid_t ret = sys_wait4(-1, status, 0, NULL);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(wait4, -1, status, 0, NULL);
 }
 
 static __attribute__((unused))
 pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 {
-	pid_t ret = sys_wait4(pid, status, options, rusage);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(wait4, pid, status, options, rusage);
 }
 
 
 static __attribute__((unused))
 pid_t waitpid(pid_t pid, int *status, int options)
 {
-	pid_t ret = sys_wait4(pid, status, options, NULL);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(wait4, pid, status, options, NULL);
 }
 
 
@@ -1394,13 +1154,7 @@ ssize_t sys_write(int fd, const void *buf, size_t count)
 static __attribute__((unused))
 ssize_t write(int fd, const void *buf, size_t count)
 {
-	ssize_t ret = sys_write(fd, buf, count);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(write, fd, buf, count);
 }
 
 
@@ -1417,13 +1171,7 @@ int sys_memfd_create(const char *name, unsigned int flags)
 static __attribute__((unused))
 int memfd_create(const char *name, unsigned int flags)
 {
-	ssize_t ret = sys_memfd_create(name, flags);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __syscall(memfd_create, name, flags);
 }
 
 /* make sure to include all global symbols */
-- 
2.25.1

