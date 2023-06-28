Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456674184E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjF1Swo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:52:44 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:38608 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjF1SwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:52:25 -0400
X-QQ-mid: bizesmtp67t1687978334t02f1mza
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 02:52:13 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: Xz3VOcA7Mr3gM7j2N3URL6OULX8Nwl8kP/OduJla9sUz4N4Rq2L64QPEi4OLN
        IzHLEmbg5hoGslKAm4D2iHE8kn5y2r00VH6R9Ywjjd37yrrL9Nryze8CCQIMQI9S6Af4GXj
        B2B41Ti5fHWQj4qLOe76pBbaYQaRmXSstZ0y6Xz6Zt041C9s3P8gURVH4FeRILaLvzn0yEv
        rdOM2sIhfkhEA0C3aXmF2IE1/BkZCD5mbhJGUR1fEHbKd88QATM25tUV6LhLKjImw3q/WEo
        iYTUzKw8aRBCXs3w0Mzq46yiilid8F8X9zukTKMN+24xG3GpLBjiUvkVQ1BUYJacLyEt4KE
        +PQdwUJGUUPDMOcfitP9AGFx4oG5CI6AHfK8vCp47Aiz7g5F3jojLSDqheWgw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11973228627114072650
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 01/11] tools/nolibc: remove old arch specific stat support
Date:   Thu, 29 Jun 2023 02:51:52 +0800
Message-Id: <77442e760bec4a99946db64ad4e17dbc353b8979.1687976753.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687976753.git.falcon@tinylab.org>
References: <cover.1687976753.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

__NR_statx has been added from v4.10:

    commit a528d35e8bfc ("statx: Add a system call to make enhanced file info available")

It has been supported by all of the platforms since at least from v4.20
and glibc 2.28.

Let's remove the old arch specific stat support completely.

This is friendly to the future new architecture porting.

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
index e30056f996db..4a8a6f386865 100644
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
index 7a64290fc518..a2ea5756cef2 100644
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
index c2e75ba91b6b..418554435545 100644
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
index a8b33d6914a4..ecf912a1938f 100644
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
index 4f21e862b412..7f4abcc15206 100644
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
index 8cff5b05e841..5139e0e37e56 100644
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
index 1dc8b60f5153..4c0192815a59 100644
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
index e0ac95a4bfa1..2c302f3feb71 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -914,15 +914,19 @@ pid_t setsid(void)
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
@@ -930,24 +934,18 @@ int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *
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
@@ -968,47 +966,8 @@ int sys_stat(const char *path, struct stat *buf)
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
index bed62da7877c..7c794ec21b46 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -14,8 +14,8 @@
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
- * ones such as the O_RDONLY and related macros used by fcntl() and open(), or
- * the layout of sys_stat_struct must not be defined here.
+ * ones such as the O_RDONLY and related macros used by fcntl() and open()
+ * must not be defined here.
  */
 
 /* stat flags (WARNING, octal here). We need to check for an existing
-- 
2.25.1

