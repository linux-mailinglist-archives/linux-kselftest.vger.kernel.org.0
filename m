Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135407502A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGLJQt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGLJQs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:16:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043EFB;
        Wed, 12 Jul 2023 02:16:46 -0700 (PDT)
X-QQ-mid: bizesmtp83t1689153395tb1nck5x
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:16:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: CR3LFp2JE4nT8qdANOII8GmrjA+hnLAPGHEEPLoGCag9o2963Xr0GjrqWzWN9
        WMwzd4ekNHQopiESDkN6CjdwEqG1dzBb4hAVEVkUsUmD3M40h0cEbmhjALOHbkzNAJvWazw
        ahhwXDpAV80V4UjDa7MSsxeonEFdIo8r7sKTIQFDyYllue97Idwli52h6dMhl10a4+xujTc
        gjaa4r5jW5aJ9SUJGx6SXrTdQtETlTDxILaOZp9uSCn+Mxxz+FxfP7HpRt2LaWbjXO43LIH
        lsOxGoHOPzMFc4mnsvSLcQ8YOslEv3FEG8eZMNNlTLxl/U7Yn3zJ1sPDCofev1W5lG8aXfA
        SjYmEiWSGzcKRhnBcitYF57A10xXx9ZwdDsaK+AaH1oEg4tanXVQFnhmLXfNY7MeyzOvix9
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13879393070408931290
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 01/11] tools/nolibc: remove the old sys_stat support
Date:   Wed, 12 Jul 2023 17:16:34 +0800
Message-Id: <5319451b7e01f1d101b94dcecf195c734eb74ebc.1689150149.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689150149.git.falcon@tinylab.org>
References: <cover.1689150149.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 6227b77a4a09..1bf122cd5966 100644
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
index 4d4887a5f04b..ea723596ed23 100644
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
index 4c6b7c04e2e7..1d4b683bc2cd 100644
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
index a2bfdf57b957..ae40d5268793 100644
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
index cd958b2f4b1b..2b89ea59c5e4 100644
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
index a644ecd361c0..a40424ba043e 100644
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
index e69113742a99..e980ca5417d0 100644
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

