Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C3723B26
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjFFIR4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjFFIR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:17:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A782123;
        Tue,  6 Jun 2023 01:17:53 -0700 (PDT)
X-QQ-mid: bizesmtp87t1686039463tyigwi8k
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 16:17:42 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: F7SaWszrsrL6jDLoUmUajkY+RVr0d5UzNLhqfwzMPFLZ5nbKS5axwqN/67E3R
        fNwEwJtdcWRDVbCBrVAWNy+evzIKDFp/4o5+dV9u9+MbYgb3669ikWhskRedGhY+tzS136Z
        xZfoEXhZySVtLm91gIuU6Y3DsOds/XQbTtSkBGC4xtJg4Do9cztk1JsmxvEedN40vbjUYpM
        r/9++y9w0naHm5UXjTXiyZGPpcuUP78JsRJQQ0zKth6II6GJ8fFmkuacPIEpQboapg9ND32
        niw3IkNTiW2UMNFES4bq/SZDnPqli5kurdryNi02s4AtW13tsSsi2KtGoQDiHyoBKdpgdfO
        BPuxg1mIvbvMyfMR/jwAmsvZV0zdYQWLmudHDd9OgTcWMHmLag=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 989690427853110087
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Date:   Tue,  6 Jun 2023 16:17:38 +0800
Message-Id: <ee86e33d9f0031da5932b0de798f188535308dd7.1686036862.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686036862.git.falcon@tinylab.org>
References: <cover.1686036862.git.falcon@tinylab.org>
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
    1425
    $ git show HEAD:tools/include/nolibc/sys.h | wc -l
    1173
    $ echo "1425-1173" | bc -l
    252

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 336 +++++--------------------------------
 1 file changed, 42 insertions(+), 294 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index f6e3168b3e50..0cfc5157845a 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -108,13 +108,7 @@ int sys_chdir(const char *path)
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
 
 
@@ -137,13 +131,7 @@ int sys_chmod(const char *path, mode_t mode)
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
 
 
@@ -166,13 +154,7 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
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
 
 
@@ -189,13 +171,7 @@ int sys_chroot(const char *path)
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
 
 
@@ -212,13 +188,7 @@ int sys_close(int fd)
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
 
 
@@ -235,13 +205,7 @@ int sys_dup(int fd)
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
 
 
@@ -264,13 +228,7 @@ int sys_dup2(int old, int new)
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
 
 
@@ -288,13 +246,7 @@ int sys_dup3(int old, int new, int flags)
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
 
@@ -312,13 +264,7 @@ int sys_execve(const char *filename, char *const argv[], char *const envp[])
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
 
 
@@ -365,13 +311,7 @@ pid_t sys_fork(void)
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
 
 
@@ -388,13 +328,7 @@ int sys_fsync(int fd)
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
 
 
@@ -411,13 +345,7 @@ int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
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
 
 
@@ -455,13 +383,7 @@ pid_t sys_getpgid(pid_t pid)
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
 
 
@@ -562,13 +484,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
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
 
 
@@ -606,13 +522,7 @@ int sys_ioctl(int fd, unsigned long req, void *value)
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
@@ -628,13 +538,7 @@ int sys_kill(pid_t pid, int signal)
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
 
 
@@ -657,13 +561,7 @@ int sys_link(const char *old, const char *new)
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
 
 
@@ -684,13 +582,7 @@ off_t sys_lseek(int fd, off_t offset, int whence)
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
 
 
@@ -713,13 +605,7 @@ int sys_mkdir(const char *path, mode_t mode)
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
 
 
@@ -742,13 +628,7 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
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
@@ -806,13 +686,7 @@ int sys_munmap(void *addr, size_t length)
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
@@ -832,13 +706,7 @@ int mount(const char *src, const char *tgt,
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
 
 
@@ -872,13 +740,7 @@ int open(const char *path, int flags, ...)
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
 
 
@@ -898,13 +760,7 @@ static __attribute__((unused))
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
 
 
@@ -921,13 +777,7 @@ int sys_pivot_root(const char *new, const char *old)
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
 
 
@@ -956,13 +806,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
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
 
 
@@ -979,13 +823,7 @@ ssize_t sys_read(int fd, void *buf, size_t count)
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
 
 
@@ -1003,13 +841,7 @@ ssize_t sys_reboot(int magic1, int magic2, int cmd, void *arg)
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
 
 
@@ -1026,13 +858,7 @@ int sys_sched_yield(void)
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
 
 
@@ -1072,13 +898,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
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
 
 
@@ -1095,13 +915,7 @@ int sys_setpgid(pid_t pid, pid_t pgid)
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
 
 
@@ -1118,13 +932,7 @@ pid_t sys_setsid(void)
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
@@ -1141,13 +949,7 @@ int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct sta
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
 
@@ -1227,13 +1029,7 @@ int sys_stat(const char *path, struct stat *buf)
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
 
 
@@ -1256,13 +1052,7 @@ int sys_symlink(const char *old, const char *new)
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
 
 
@@ -1296,13 +1086,7 @@ int sys_umount2(const char *path, int flags)
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
 
 
@@ -1325,13 +1109,7 @@ int sys_unlink(const char *path)
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
 
 
@@ -1354,38 +1132,20 @@ pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
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
 
 
@@ -1402,13 +1162,7 @@ ssize_t sys_write(int fd, const void *buf, size_t count)
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
 
 
@@ -1425,13 +1179,7 @@ int sys_memfd_create(const char *name, unsigned int flags)
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

