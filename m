Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A9741205
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjF1NOI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:14:08 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:43530 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjF1NOE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:14:04 -0400
X-QQ-mid: bizesmtp73t1687958029tsqr6b77
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:13:48 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 6/K5pWSRdGp43NN4ltMFANlOU2Sg0mNfffJBpDS3NAh4y+jOp5br/5X7NSQbv
        JJjezjNjJ2F7JVsGBr6YomcNMUPz3YDjNty6Sab4wZkeKPeWZYTczlUqOwr0oqDQCm9CBA5
        PElQgLZCW+RkmcPFOfx5acqWXC0ahwFBRIBGwXWEpUAk1/gSJGdJD/dZmaid37okcbYUWmr
        YSOBaSKkAwtk6iVrcC0HKDnulIUbOuk49DvQd0vJnkMQ+DhD6sDCQeR4OVxSMrTXzGn8axq
        kLaSthGoNh3C9qM6ksm6yEyJTORXYuWhlPj9Dv+CPeCIMcMMB868AggAVIuhrp6d6sXqVQg
        t+h88UgOuOCm6ASdOkG4tN+gOrKDPYHK+Kda4ljgPl2KOlAL4A=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10854173496193420036
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 03/14] tools/nolibc: sys.h: apply __sysret() helper
Date:   Wed, 28 Jun 2023 21:13:25 +0800
Message-Id: <5b8202ef42f0112a72366b6004929df70157614b.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use __sysret() to shrink most of the library routines to oneline code.

Removed 266 lines of duplicated code.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 354 +++++--------------------------------
 1 file changed, 44 insertions(+), 310 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 097eef88cf7e..53bc3ad6593e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -76,13 +76,7 @@ void *sys_brk(void *addr)
 static __attribute__((unused))
 int brk(void *addr)
 {
-	void *ret = sys_brk(addr);
-
-	if (!ret) {
-		SET_ERRNO(ENOMEM);
-		return -1;
-	}
-	return 0;
+	return __sysret(sys_brk(addr) ? 0 : -ENOMEM);
 }
 
 static __attribute__((unused))
@@ -112,13 +106,7 @@ int sys_chdir(const char *path)
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
+	return __sysret(sys_chdir(path));
 }
 
 
@@ -141,13 +129,7 @@ int sys_chmod(const char *path, mode_t mode)
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
+	return __sysret(sys_chmod(path, mode));
 }
 
 
@@ -170,13 +152,7 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
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
+	return __sysret(sys_chown(path, owner, group));
 }
 
 
@@ -193,13 +169,7 @@ int sys_chroot(const char *path)
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
+	return __sysret(sys_chroot(path));
 }
 
 
@@ -216,13 +186,7 @@ int sys_close(int fd)
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
+	return __sysret(sys_close(fd));
 }
 
 
@@ -239,13 +203,7 @@ int sys_dup(int fd)
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
+	return __sysret(sys_dup(fd));
 }
 
 
@@ -268,13 +226,7 @@ int sys_dup2(int old, int new)
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
+	return __sysret(sys_dup2(old, new));
 }
 
 
@@ -292,13 +244,7 @@ int sys_dup3(int old, int new, int flags)
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
+	return __sysret(sys_dup3(old, new, flags));
 }
 #endif
 
@@ -316,13 +262,7 @@ int sys_execve(const char *filename, char *const argv[], char *const envp[])
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
+	return __sysret(sys_execve(filename, argv, envp));
 }
 
 
@@ -369,13 +309,7 @@ pid_t sys_fork(void)
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
+	return __sysret(sys_fork());
 }
 
 
@@ -392,13 +326,7 @@ int sys_fsync(int fd)
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
+	return __sysret(sys_fsync(fd));
 }
 
 
@@ -415,13 +343,7 @@ int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
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
+	return __sysret(sys_getdents64(fd, dirp, count));
 }
 
 
@@ -459,13 +381,7 @@ pid_t sys_getpgid(pid_t pid)
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
+	return __sysret(sys_getpgid(pid));
 }
 
 
@@ -545,15 +461,7 @@ static unsigned long getauxval(unsigned long key);
 static __attribute__((unused))
 long getpagesize(void)
 {
-	long ret;
-
-	ret = getauxval(AT_PAGESZ);
-	if (!ret) {
-		SET_ERRNO(ENOENT);
-		return -1;
-	}
-
-	return ret;
+	return __sysret(getauxval(AT_PAGESZ) ?: -ENOENT);
 }
 
 
@@ -574,13 +482,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
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
+	return __sysret(sys_gettimeofday(tv, tz));
 }
 
 
@@ -618,13 +520,7 @@ int sys_ioctl(int fd, unsigned long req, void *value)
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
+	return __sysret(sys_ioctl(fd, req, value));
 }
 
 /*
@@ -640,13 +536,7 @@ int sys_kill(pid_t pid, int signal)
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
+	return __sysret(sys_kill(pid, signal));
 }
 
 
@@ -669,13 +559,7 @@ int sys_link(const char *old, const char *new)
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
+	return __sysret(sys_link(old, new));
 }
 
 
@@ -696,13 +580,7 @@ off_t sys_lseek(int fd, off_t offset, int whence)
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
+	return __sysret(sys_lseek(fd, offset, whence));
 }
 
 
@@ -725,13 +603,7 @@ int sys_mkdir(const char *path, mode_t mode)
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
+	return __sysret(sys_mkdir(path, mode));
 }
 
 
@@ -754,13 +626,7 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
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
+	return __sysret(sys_mknod(path, mode, dev));
 }
 
 #ifndef MAP_SHARED
@@ -818,13 +684,7 @@ int sys_munmap(void *addr, size_t length)
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
+	return __sysret(sys_munmap(addr, length));
 }
 
 /*
@@ -844,13 +704,7 @@ int mount(const char *src, const char *tgt,
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
+	return __sysret(sys_mount(src, tgt, fst, flags, data));
 }
 
 
@@ -884,13 +738,7 @@ int open(const char *path, int flags, ...)
 		va_end(args);
 	}
 
-	ret = sys_open(path, flags, mode);
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return __sysret(sys_open(path, flags, mode));
 }
 
 
@@ -910,13 +758,7 @@ static __attribute__((unused))
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
+	return __sysret(sys_prctl(option, arg2, arg3, arg4, arg5));
 }
 
 
@@ -933,13 +775,7 @@ int sys_pivot_root(const char *new, const char *old)
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
+	return __sysret(sys_pivot_root(new, old));
 }
 
 
@@ -968,13 +804,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
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
+	return __sysret(sys_poll(fds, nfds, timeout));
 }
 
 
@@ -991,13 +821,7 @@ ssize_t sys_read(int fd, void *buf, size_t count)
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
+	return __sysret(sys_read(fd, buf, count));
 }
 
 
@@ -1015,13 +839,7 @@ ssize_t sys_reboot(int magic1, int magic2, int cmd, void *arg)
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
+	return __sysret(sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0));
 }
 
 
@@ -1038,13 +856,7 @@ int sys_sched_yield(void)
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
+	return __sysret(sys_sched_yield());
 }
 
 
@@ -1084,13 +896,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
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
+	return __sysret(sys_select(nfds, rfds, wfds, efds, timeout));
 }
 
 
@@ -1107,13 +913,7 @@ int sys_setpgid(pid_t pid, pid_t pgid)
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
+	return __sysret(sys_setpgid(pid, pgid));
 }
 
 
@@ -1130,13 +930,7 @@ pid_t sys_setsid(void)
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
+	return __sysret(sys_setsid());
 }
 
 #if defined(__NR_statx)
@@ -1153,13 +947,7 @@ int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct sta
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
+	return __sysret(sys_statx(fd, path, flags, mask, buf));
 }
 #endif
 
@@ -1239,13 +1027,7 @@ int sys_stat(const char *path, struct stat *buf)
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
+	return __sysret(sys_stat(path, buf));
 }
 
 
@@ -1268,13 +1050,7 @@ int sys_symlink(const char *old, const char *new)
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
+	return __sysret(sys_symlink(old, new));
 }
 
 
@@ -1308,13 +1084,7 @@ int sys_umount2(const char *path, int flags)
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
+	return __sysret(sys_umount2(path, flags));
 }
 
 
@@ -1337,13 +1107,7 @@ int sys_unlink(const char *path)
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
+	return __sysret(sys_unlink(path));
 }
 
 
@@ -1366,38 +1130,20 @@ pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
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
+	return __sysret(sys_wait4(-1, status, 0, NULL));
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
+	return __sysret(sys_wait4(pid, status, options, rusage));
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
+	return __sysret(sys_wait4(pid, status, options, NULL));
 }
 
 
@@ -1414,13 +1160,7 @@ ssize_t sys_write(int fd, const void *buf, size_t count)
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
+	return __sysret(sys_write(fd, buf, count));
 }
 
 
@@ -1437,13 +1177,7 @@ int sys_memfd_create(const char *name, unsigned int flags)
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
+	return __sysret(sys_memfd_create(name, flags));
 }
 
 /* make sure to include all global symbols */
-- 
2.25.1

