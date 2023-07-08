Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE174BE2E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGHP3I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGHP3H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:29:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E41709;
        Sat,  8 Jul 2023 08:29:04 -0700 (PDT)
X-QQ-mid: bizesmtp67t1688830134tnbci13y
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:28:53 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: wbizDlKcf6k2E2Tlh93dI0gtZr19CNzGMJQHCuHAOD58RfG1bYwL5a3TOroCj
        p7gWNciZgMLgnQAnBGlH3zMrTYN1shrLRItJf6iLT4tYKET4UJSAIMUzPeB7x71oqVQcl+V
        IqGvfxRk+vvruHGtb4QUPlcf1iNghiDdmmSELpV39e7EQ802u1tdrBoAfhJLFz5xA6/uMM+
        tVskNr3coNMxLKaOcRgCP80aFmfy+c5JNV5jelcm5nzcTqKK4PSLsCQv+3/9VxVCnU86FF/
        TdtTMtWp2MUctNypr9haTACDXKIi0UhF5M4Rbt0XAs6RWgTbx0ZGk6u13m3iQ3vBgxMDjBs
        +LQ3C1Jv8JGsIDWE/FLMZvbmWwJPHveEAismH+/mP6+zhJUxtbhSGDRhU/Puchw4wXHD8NM
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8368633829245986870
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 03/12] tools/nolibc: sys.h: remove the old sys_stat support
Date:   Sat,  8 Jul 2023 23:28:53 +0800
Message-Id: <759c5674a2a354312729893116168637135ac173.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

__NR_statx has been added from v4.10:

    commit a528d35e8bfc ("statx: Add a system call to make enhanced file info available")

It has been supported by all of the platforms since at least from v4.20
and glibc 2.28.

Let's remove the old arch related and dependent sys_stat support
completely.

This is friendly to the future new architecture porting.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/aarch64/sys.h | 28 -------------
 tools/include/nolibc/arm/sys.h     | 37 ------------------
 tools/include/nolibc/i386/sys.h    | 26 ------------
 tools/include/nolibc/mips/sys.h    | 28 -------------
 tools/include/nolibc/riscv/sys.h   | 23 -----------
 tools/include/nolibc/s390/sys.h    | 25 ------------
 tools/include/nolibc/sys.h         | 63 ++++++------------------------
 tools/include/nolibc/types.h       |  4 +-
 tools/include/nolibc/x86_64/sys.h  | 27 -------------
 9 files changed, 13 insertions(+), 248 deletions(-)

diff --git a/tools/include/nolibc/aarch64/sys.h b/tools/include/nolibc/aarch64/sys.h
index b79d6a35ec37..43df164b8796 100644
--- a/tools/include/nolibc/aarch64/sys.h
+++ b/tools/include/nolibc/aarch64/sys.h
@@ -7,34 +7,6 @@
 #ifndef _NOLIBC_AARCH64_SYS_H
 #define _NOLIBC_AARCH64_SYS_H
 
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
diff --git a/tools/include/nolibc/arm/sys.h b/tools/include/nolibc/arm/sys.h
index 79173f860948..db8846ff3eda 100644
--- a/tools/include/nolibc/arm/sys.h
+++ b/tools/include/nolibc/arm/sys.h
@@ -7,43 +7,6 @@
 #ifndef _NOLIBC_ARM_SYS_H
 #define _NOLIBC_ARM_SYS_H
 
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
diff --git a/tools/include/nolibc/i386/sys.h b/tools/include/nolibc/i386/sys.h
index c626cf2b145a..d2d0eeccb8fc 100644
--- a/tools/include/nolibc/i386/sys.h
+++ b/tools/include/nolibc/i386/sys.h
@@ -7,32 +7,6 @@
 #ifndef _NOLIBC_I386_SYS_H
 #define _NOLIBC_I386_SYS_H
 
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
diff --git a/tools/include/nolibc/mips/sys.h b/tools/include/nolibc/mips/sys.h
index 13dfbf3e6a3d..c3c245682e5d 100644
--- a/tools/include/nolibc/mips/sys.h
+++ b/tools/include/nolibc/mips/sys.h
@@ -7,34 +7,6 @@
 #ifndef _NOLIBC_MIPS_SYS_H
 #define _NOLIBC_MIPS_SYS_H
 
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
diff --git a/tools/include/nolibc/riscv/sys.h b/tools/include/nolibc/riscv/sys.h
index aa15b86c919f..682bf9c0165b 100644
--- a/tools/include/nolibc/riscv/sys.h
+++ b/tools/include/nolibc/riscv/sys.h
@@ -7,29 +7,6 @@
 #ifndef _NOLIBC_RISCV_SYS_H
 #define _NOLIBC_RISCV_SYS_H
 
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
 /* Syscalls for RISCV :
  *   - stack is 16-byte aligned
  *   - syscall number is passed in a7
diff --git a/tools/include/nolibc/s390/sys.h b/tools/include/nolibc/s390/sys.h
index 041f4ecb7922..4373c4dc1e8a 100644
--- a/tools/include/nolibc/s390/sys.h
+++ b/tools/include/nolibc/s390/sys.h
@@ -8,31 +8,6 @@
 #include <asm/signal.h>
 #include <asm/unistd.h>
 
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
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index e84ed57f3a63..8c7fc9f5abd1 100644
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
diff --git a/tools/include/nolibc/x86_64/sys.h b/tools/include/nolibc/x86_64/sys.h
index c761c97dccf8..ac3e8811b7d1 100644
--- a/tools/include/nolibc/x86_64/sys.h
+++ b/tools/include/nolibc/x86_64/sys.h
@@ -7,33 +7,6 @@
 #ifndef _NOLIBC_X86_64_SYS_H
 #define _NOLIBC_X86_64_SYS_H
 
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
-- 
2.25.1

