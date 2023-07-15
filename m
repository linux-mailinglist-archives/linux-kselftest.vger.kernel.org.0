Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A156754A9D
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjGOSUP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOSUP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:20:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949D326AF;
        Sat, 15 Jul 2023 11:20:12 -0700 (PDT)
X-QQ-mid: bizesmtp87t1689445202toqmpl8r
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:20:01 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: D2GZf6M6C/hENRXV3XkI+PdVdkIPSzGmBBJqKdXA6wY+q9LL/+Gzrn1JyzyBL
        fWcZ+IvsrvJD25X3SkH/C61eshZVWqoikN1P9Jn0q2dA70evWDGyujS+juP7IRd92m6qO45
        6GWeLmKlZPi4PTlRO1Hm5cuNcRegal6F2Iw1hgdyXnH+tGftjWImMk5+hKDVn0yGkrSRV9s
        Qwu+0FIZa2yL2B6yWoeOETGYr4MG8qCajM6OJXeFYT/Mheg4Pf5Ty7/Qh1QX696SESZA3i9
        wSq/XrAFEKCJvy+8zXSlBj+pfekH1/EIEKFfagcH2wtAF42o/5O2cMXsQL/R6QBfj0UZYOG
        89Q27GrcC1HkRAR5DPFmCuFK+ACycKoQY/a2o7Pw46gk/Guhsg1lFkVXpZr6YeVrsbJkPX6
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6319169823704416527
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 03/18] tools/nolibc: remove the old sys_stat support
Date:   Sun, 16 Jul 2023 02:20:01 +0800
Message-Id: <56f2be73a0badf3dbc8c5d58478f7b14dde57a05.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The statx manpage [1] shows that it has been supported from Linux 4.11
and glibc 2.28, the Linux support can be checked for all of the
architectures with this command:

    $ git grep -r statx v4.11 arch/ include/uapi/asm-generic/unistd.h \
      | grep -E "aarch64|arm|mips|s390|x86|:include/uapi"

Besides riscv and loongarch, all of the nolibc supported architectures
have added sys_statx from Linux v4.11. riscv is mainlined to v4.15,
loongarch is mainlined to v5.19, both of them use the generic unistd.h,
so, they have added sys_statx from their first mainline versions.

The current oldest stable branch is v4.14, only reserving sys_statx
still preserves compatibility with all of the supported stable branches,
So, let's remove the old arch related and dependent sys_stat support
completely.

This is friendly to the future new architecture porting.

[1]: https://man7.org/linux/man-pages/man2/statx.2.html

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-aarch64.h | 28 -------------
 tools/include/nolibc/arch-arm.h     | 37 -----------------
 tools/include/nolibc/arch-i386.h    | 26 ------------
 tools/include/nolibc/arch-mips.h    | 28 -------------
 tools/include/nolibc/arch-riscv.h   | 23 -----------
 tools/include/nolibc/arch-s390.h    | 25 ------------
 tools/include/nolibc/arch-x86_64.h  | 27 -------------
 tools/include/nolibc/sys.h          | 63 +++++------------------------
 tools/include/nolibc/types.h        |  4 +-
 9 files changed, 13 insertions(+), 248 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 21e9482a4235..3c0a5f47b3e8 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -9,34 +9,6 @@
 
 #include "compiler.h"
 
-/* The struct returned by the newfstatat() syscall. Differs slightly from the
- * x86_64's stat one by field ordering, so be careful.
- */
-struct sys_stat_struct {
-	unsigned long   st_dev;
-	unsigned long   st_ino;
-	unsigned int    st_mode;
-	unsigned int    st_nlink;
-	unsigned int    st_uid;
-	unsigned int    st_gid;
-
-	unsigned long   st_rdev;
-	unsigned long   __pad1;
-	long            st_size;
-	int             st_blksize;
-	int             __pad2;
-
-	long            st_blocks;
-	long            st_atime;
-	unsigned long   st_atime_nsec;
-	long            st_mtime;
-
-	unsigned long   st_mtime_nsec;
-	long            st_ctime;
-	unsigned long   st_ctime_nsec;
-	unsigned int    __unused[2];
-};
-
 /* Syscalls for AARCH64 :
  *   - registers are 64-bit
  *   - stack is 16-byte aligned
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 4451bef5f94d..a06dad789a22 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -9,43 +9,6 @@
 
 #include "compiler.h"
 
-/* The struct returned by the stat() syscall, 32-bit only, the syscall returns
- * exactly 56 bytes (stops before the unused array). In big endian, the format
- * differs as devices are returned as short only.
- */
-struct sys_stat_struct {
-#if defined(__ARMEB__)
-	unsigned short st_dev;
-	unsigned short __pad1;
-#else
-	unsigned long  st_dev;
-#endif
-	unsigned long  st_ino;
-	unsigned short st_mode;
-	unsigned short st_nlink;
-	unsigned short st_uid;
-	unsigned short st_gid;
-
-#if defined(__ARMEB__)
-	unsigned short st_rdev;
-	unsigned short __pad2;
-#else
-	unsigned long  st_rdev;
-#endif
-	unsigned long  st_size;
-	unsigned long  st_blksize;
-	unsigned long  st_blocks;
-
-	unsigned long  st_atime;
-	unsigned long  st_atime_nsec;
-	unsigned long  st_mtime;
-	unsigned long  st_mtime_nsec;
-
-	unsigned long  st_ctime;
-	unsigned long  st_ctime_nsec;
-	unsigned long  __unused[2];
-};
-
 /* Syscalls for ARM in ARM or Thumb modes :
  *   - registers are 32-bit
  *   - stack is 8-byte aligned
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 4c94a81e860f..fe0b73f032c3 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -9,32 +9,6 @@
 
 #include "compiler.h"
 
-/* The struct returned by the stat() syscall, 32-bit only, the syscall returns
- * exactly 56 bytes (stops before the unused array).
- */
-struct sys_stat_struct {
-	unsigned long  st_dev;
-	unsigned long  st_ino;
-	unsigned short st_mode;
-	unsigned short st_nlink;
-	unsigned short st_uid;
-	unsigned short st_gid;
-
-	unsigned long  st_rdev;
-	unsigned long  st_size;
-	unsigned long  st_blksize;
-	unsigned long  st_blocks;
-
-	unsigned long  st_atime;
-	unsigned long  st_atime_nsec;
-	unsigned long  st_mtime;
-	unsigned long  st_mtime_nsec;
-
-	unsigned long  st_ctime;
-	unsigned long  st_ctime_nsec;
-	unsigned long  __unused[2];
-};
-
 /* Syscalls for i386 :
  *   - mostly similar to x86_64
  *   - registers are 32-bit
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index d3f0bf4c4245..7242fc9de04f 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -9,34 +9,6 @@
 
 #include "compiler.h"
 
-/* The struct returned by the stat() syscall. 88 bytes are returned by the
- * syscall.
- */
-struct sys_stat_struct {
-	unsigned int  st_dev;
-	long          st_pad1[3];
-	unsigned long st_ino;
-	unsigned int  st_mode;
-	unsigned int  st_nlink;
-	unsigned int  st_uid;
-	unsigned int  st_gid;
-	unsigned int  st_rdev;
-	long          st_pad2[2];
-	long          st_size;
-	long          st_pad3;
-
-	long          st_atime;
-	long          st_atime_nsec;
-	long          st_mtime;
-	long          st_mtime_nsec;
-
-	long          st_ctime;
-	long          st_ctime_nsec;
-	long          st_blksize;
-	long          st_blocks;
-	long          st_pad4[14];
-};
-
 /* Syscalls for MIPS ABI O32 :
  *   - WARNING! there's always a delayed slot!
  *   - WARNING again, the syntax is different, registers take a '$' and numbers
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 322c96f4acdb..d49f5ecbf815 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -9,29 +9,6 @@
 
 #include "compiler.h"
 
-struct sys_stat_struct {
-	unsigned long	st_dev;		/* Device.  */
-	unsigned long	st_ino;		/* File serial number.  */
-	unsigned int	st_mode;	/* File mode.  */
-	unsigned int	st_nlink;	/* Link count.  */
-	unsigned int	st_uid;		/* User ID of the file's owner.  */
-	unsigned int	st_gid;		/* Group ID of the file's group. */
-	unsigned long	st_rdev;	/* Device number, if device.  */
-	unsigned long	__pad1;
-	long		st_size;	/* Size of file, in bytes.  */
-	int		st_blksize;	/* Optimal block size for I/O.  */
-	int		__pad2;
-	long		st_blocks;	/* Number 512-byte blocks allocated. */
-	long		st_atime;	/* Time of last access.  */
-	unsigned long	st_atime_nsec;
-	long		st_mtime;	/* Time of last modification.  */
-	unsigned long	st_mtime_nsec;
-	long		st_ctime;	/* Time of last status change.  */
-	unsigned long	st_ctime_nsec;
-	unsigned int	__unused4;
-	unsigned int	__unused5;
-};
-
 #if   __riscv_xlen == 64
 #define PTRLOG "3"
 #define SZREG  "8"
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 587cc91295fa..3b94ae0cb1d1 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -10,31 +10,6 @@
 
 #include "compiler.h"
 
-/* The struct returned by the stat() syscall, equivalent to stat64(). The
- * syscall returns 116 bytes and stops in the middle of __unused.
- */
-
-struct sys_stat_struct {
-	unsigned long	st_dev;
-	unsigned long	st_ino;
-	unsigned long	st_nlink;
-	unsigned int	st_mode;
-	unsigned int	st_uid;
-	unsigned int	st_gid;
-	unsigned int	__pad1;
-	unsigned long	st_rdev;
-	unsigned long	st_size;
-	unsigned long	st_atime;
-	unsigned long	st_atime_nsec;
-	unsigned long	st_mtime;
-	unsigned long	st_mtime_nsec;
-	unsigned long	st_ctime;
-	unsigned long	st_ctime_nsec;
-	unsigned long	st_blksize;
-	long		st_blocks;
-	unsigned long	__unused[3];
-};
-
 /* Syscalls for s390:
  *   - registers are 64-bit
  *   - syscall number is passed in r1
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 5e950a04bc77..6b494ca471ef 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -9,33 +9,6 @@
 
 #include "compiler.h"
 
-/* The struct returned by the stat() syscall, equivalent to stat64(). The
- * syscall returns 116 bytes and stops in the middle of __unused.
- */
-struct sys_stat_struct {
-	unsigned long st_dev;
-	unsigned long st_ino;
-	unsigned long st_nlink;
-	unsigned int  st_mode;
-	unsigned int  st_uid;
-
-	unsigned int  st_gid;
-	unsigned int  __pad0;
-	unsigned long st_rdev;
-	long          st_size;
-	long          st_blksize;
-
-	long          st_blocks;
-	unsigned long st_atime;
-	unsigned long st_atime_nsec;
-	unsigned long st_mtime;
-
-	unsigned long st_mtime_nsec;
-	unsigned long st_ctime;
-	unsigned long st_ctime_nsec;
-	long          __unused[3];
-};
-
 /* Syscalls for x86_64 :
  *   - registers are 64-bit
  *   - syscall number is passed in rax
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index dee56894a811..8bfe7db20b80 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -943,15 +943,19 @@ pid_t setsid(void)
 	return __sysret(sys_setsid());
 }
 
-#if defined(__NR_statx)
 /*
  * int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf);
+ * int stat(const char *path, struct stat *buf);
  */
 
 static __attribute__((unused))
 int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
 {
+#ifdef __NR_statx
 	return my_syscall5(__NR_statx, fd, path, flags, mask, buf);
+#else
+	return -ENOSYS;
+#endif
 }
 
 static __attribute__((unused))
@@ -959,24 +963,18 @@ int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *
 {
 	return __sysret(sys_statx(fd, path, flags, mask, buf));
 }
-#endif
 
-/*
- * int stat(const char *path, struct stat *buf);
- * Warning: the struct stat's layout is arch-dependent.
- */
 
-#if defined(__NR_statx) && !defined(__NR_newfstatat) && !defined(__NR_stat)
-/*
- * Maybe we can just use statx() when available for all architectures?
- */
 static __attribute__((unused))
-int sys_stat(const char *path, struct stat *buf)
+int stat(const char *path, struct stat *buf)
 {
 	struct statx statx;
 	long ret;
 
-	ret = sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx);
+	ret = __sysret(sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx));
+	if (ret == -1)
+		return ret;
+
 	buf->st_dev          = ((statx.stx_dev_minor & 0xff)
 			       | (statx.stx_dev_major << 8)
 			       | ((statx.stx_dev_minor & ~0xff) << 12));
@@ -997,47 +995,8 @@ int sys_stat(const char *path, struct stat *buf)
 	buf->st_mtim.tv_nsec = statx.stx_mtime.tv_nsec;
 	buf->st_ctim.tv_sec  = statx.stx_ctime.tv_sec;
 	buf->st_ctim.tv_nsec = statx.stx_ctime.tv_nsec;
-	return ret;
-}
-#else
-static __attribute__((unused))
-int sys_stat(const char *path, struct stat *buf)
-{
-	struct sys_stat_struct stat;
-	long ret;
-
-#ifdef __NR_newfstatat
-	/* only solution for arm64 */
-	ret = my_syscall4(__NR_newfstatat, AT_FDCWD, path, &stat, 0);
-#elif defined(__NR_stat)
-	ret = my_syscall2(__NR_stat, path, &stat);
-#else
-	return -ENOSYS;
-#endif
-	buf->st_dev          = stat.st_dev;
-	buf->st_ino          = stat.st_ino;
-	buf->st_mode         = stat.st_mode;
-	buf->st_nlink        = stat.st_nlink;
-	buf->st_uid          = stat.st_uid;
-	buf->st_gid          = stat.st_gid;
-	buf->st_rdev         = stat.st_rdev;
-	buf->st_size         = stat.st_size;
-	buf->st_blksize      = stat.st_blksize;
-	buf->st_blocks       = stat.st_blocks;
-	buf->st_atim.tv_sec  = stat.st_atime;
-	buf->st_atim.tv_nsec = stat.st_atime_nsec;
-	buf->st_mtim.tv_sec  = stat.st_mtime;
-	buf->st_mtim.tv_nsec = stat.st_mtime_nsec;
-	buf->st_ctim.tv_sec  = stat.st_ctime;
-	buf->st_ctim.tv_nsec = stat.st_ctime_nsec;
-	return ret;
-}
-#endif
 
-static __attribute__((unused))
-int stat(const char *path, struct stat *buf)
-{
-	return __sysret(sys_stat(path, buf));
+	return 0;
 }
 
 
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 23963e48d8ee..8cfc4c860fa4 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -15,8 +15,8 @@
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
- * ones such as the O_RDONLY and related macros used by fcntl() and open(), or
- * the layout of sys_stat_struct must not be defined here.
+ * ones such as the O_RDONLY and related macros used by fcntl() and open()
+ * must not be defined here.
  */
 
 /* stat flags (WARNING, octal here). We need to check for an existing
-- 
2.25.1

