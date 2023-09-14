Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663717A0A24
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 18:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbjINQCN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbjINQCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 12:02:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385682726;
        Thu, 14 Sep 2023 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694707293;
        bh=rklkaKmuEop2mkqsY9+prLbWDx4KQ6pug1wWbwN/pUU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=l0Q201ayEAQrclQ0up4pYQXtSYdkzEK6uNrRoR2Ydz94iDRpFdRko733hWRKljKnX
         ek6mnVsHkN6wTlz9/mww7YXQUCAYev+O1cs3rkGQ/+0U4BHjqbkFa6enJpUr0UJXSr
         m4iTLUZQUUJE93+vAqr0qmdRE9D8GGyIxx+th+Tc=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 14 Sep 2023 18:01:18 +0200
Subject: [PATCH 2/4] tools/nolibc: avoid unused parameter warnings for
 ENOSYS fallbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230914-nolibc-syscall-nr-v1-2-e50df410da11@weissschuh.net>
References: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
In-Reply-To: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707292; l=3290;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rklkaKmuEop2mkqsY9+prLbWDx4KQ6pug1wWbwN/pUU=;
 b=3ASFNj+C1ZmK459CmYHIr9/+BQymJpv0Mz8eFVb1MBFyHEdV/HJa8qwuKaUDzvCrAjBT06SAh
 2EY0avaf7rvCgBGFJj+0E3x0xKlFz9hy/NC6XYAJ7QBGapHZ5vh9TUM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ENOSYS fallback code does not use its functions parameters.
This can lead to compiler warnings about unused parameters.

Explicitly avoid these warnings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b478750c9004..bc56310c6bdf 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -133,6 +133,8 @@ int sys_chmod(const char *path, mode_t mode)
 #elif defined(__NR_chmod)
 	return my_syscall2(__NR_chmod, path, mode);
 #else
+	(void)path;
+	(void)mode;
 	return -ENOSYS;
 #endif
 }
@@ -156,6 +158,9 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
 #elif defined(__NR_chown)
 	return my_syscall3(__NR_chown, path, owner, group);
 #else
+	(void)path;
+	(void)owner;
+	(void)group;
 	return -ENOSYS;
 #endif
 }
@@ -230,6 +235,8 @@ int sys_dup2(int old, int new)
 #elif defined(__NR_dup2)
 	return my_syscall2(__NR_dup2, old, new);
 #else
+	(void)old;
+	(void)new;
 	return -ENOSYS;
 #endif
 }
@@ -486,6 +493,8 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 #ifdef __NR_gettimeofday
 	return my_syscall2(__NR_gettimeofday, tv, tz);
 #else
+	(void)tv;
+	(void)tz;
 	return -ENOSYS;
 #endif
 }
@@ -563,6 +572,8 @@ int sys_link(const char *old, const char *new)
 #elif defined(__NR_link)
 	return my_syscall2(__NR_link, old, new);
 #else
+	(void)old;
+	(void)new;
 	return -ENOSYS;
 #endif
 }
@@ -584,6 +595,9 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 #ifdef __NR_lseek
 	return my_syscall3(__NR_lseek, fd, offset, whence);
 #else
+	(void)fd;
+	(void)offset;
+	(void)whence;
 	return -ENOSYS;
 #endif
 }
@@ -607,6 +621,8 @@ int sys_mkdir(const char *path, mode_t mode)
 #elif defined(__NR_mkdir)
 	return my_syscall2(__NR_mkdir, path, mode);
 #else
+	(void)path;
+	(void)mode;
 	return -ENOSYS;
 #endif
 }
@@ -629,6 +645,7 @@ int sys_rmdir(const char *path)
 #elif defined(__NR_unlinkat)
 	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, AT_REMOVEDIR);
 #else
+	(void)path;
 	return -ENOSYS;
 #endif
 }
@@ -652,6 +669,9 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
 #elif defined(__NR_mknod)
 	return my_syscall3(__NR_mknod, path, mode, dev);
 #else
+	(void)path;
+	(void)mode;
+	(void)dev;
 	return -ENOSYS;
 #endif
 }
@@ -742,6 +762,9 @@ int sys_open(const char *path, int flags, mode_t mode)
 #elif defined(__NR_open)
 	return my_syscall3(__NR_open, path, flags, mode);
 #else
+	(void)path;
+	(void)flags;
+	(void)mode;
 	return -ENOSYS;
 #endif
 }
@@ -842,6 +865,9 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else
+	(void)fds;
+	(void)nfds;
+	(void)timeout;
 	return -ENOSYS;
 #endif
 }
@@ -934,6 +960,11 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 #endif
 	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
 #else
+	(void)nfds;
+	(void)rfds;
+	(void)wfds;
+	(void)efds;
+	(void)timeout;
 	return -ENOSYS;
 #endif
 }

-- 
2.42.0

