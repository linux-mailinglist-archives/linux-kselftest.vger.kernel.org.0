Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AEF7412CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjF1NoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:44:13 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:10251 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjF1NoJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:44:09 -0400
X-QQ-mid: bizesmtp71t1687959834tnnavfbr
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:43:53 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: Y6Kc/cQg3lZMtgn2kxiU6zmEGNcj28TJS0EgbFpP4twIX+T9y2B6p0bOn3MWv
        kwvUR4P1W5/nG5q1ysHmSUWyO41+7CgGe/G/5Cr9uT7VV9/dHhRkxOPPx8eQM51V/NExjV5
        NnAojSJ9NLly/nYfbygC8y0tCztiSKCNMJjl2tyv6UelKR7tTEonhyqEbq5SY9F/isScf+J
        CVkN9WiXJ7yUkVDmYOdChCbet5bOziyBbcdV46eQkF+gQF230AShRQ//qpPP/8+FrE3HBc/
        mlOEG2WWVXjDZZyYRWG4u/NjvjF3ZNtMw1lVdF+2tC8WkonX/j1Ou8lbp3JZSN6w1SZ/N1F
        UT+xC1U6JoBtLl8IkZcz//WavDz3ZKXZZWvncWZbo14gwTYVbmwEqrTyZWtdg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10849030665645760256
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 11/14] tools/nolibc: clean up mmap() support
Date:   Wed, 28 Jun 2023 21:41:13 +0800
Message-Id: <f054cd45de26bccb330ad842bc2b3b708b2a429d.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Do several cleanups together:

- Since all supported architectures have my_syscall6() now, remove the
  #ifdef check.

- Move the mmap() related macros to tools/include/nolibc/types.h and
  reuse most of them from <linux/mman.h>

- Apply the new __sysret() to convert the calling of sys_map() to
  oneline code

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h   | 24 +-----------------------
 tools/include/nolibc/types.h |  6 ++++++
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b6125e600dc2..e0ac95a4bfa1 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -632,26 +632,11 @@ int mknod(const char *path, mode_t mode, dev_t dev)
 	return __sysret(sys_mknod(path, mode, dev));
 }
 
-#ifndef MAP_SHARED
-#define MAP_SHARED		0x01	/* Share changes */
-#define MAP_PRIVATE		0x02	/* Changes are private */
-#define MAP_SHARED_VALIDATE	0x03	/* share + validate extension flags */
-#endif
-
-#ifndef MAP_FAILED
-#define MAP_FAILED ((void *)-1)
-#endif
-
 #ifndef sys_mmap
 static __attribute__((unused))
 void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	       off_t offset)
 {
-#ifndef my_syscall6
-	/* Function not implemented. */
-	return (void *)-ENOSYS;
-#else
-
 	int n;
 
 #if defined(__NR_mmap2)
@@ -662,20 +647,13 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 #endif
 
 	return (void *)my_syscall6(n, addr, length, prot, flags, fd, offset);
-#endif
 }
 #endif
 
 static __attribute__((unused))
 void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 {
-	void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
-
-	if ((unsigned long)ret >= -4095UL) {
-		SET_ERRNO(-(long)ret);
-		ret = MAP_FAILED;
-	}
-	return ret;
+	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
 }
 
 static __attribute__((unused))
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index f96e28bff4ba..bed62da7877c 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -10,6 +10,7 @@
 #include "std.h"
 #include <linux/time.h>
 #include <linux/stat.h>
+#include <linux/mman.h>
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
@@ -81,6 +82,11 @@
 #define MAXPATHLEN     (PATH_MAX)
 #endif
 
+/* flags for mmap */
+#ifndef MAP_FAILED
+#define MAP_FAILED ((void *)-1)
+#endif
+
 /* whence values for lseek() */
 #define SEEK_SET       0
 #define SEEK_CUR       1
-- 
2.25.1

