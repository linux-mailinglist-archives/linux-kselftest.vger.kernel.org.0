Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAC874B36F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjGGO7H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 10:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGGO7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 10:59:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27E42102;
        Fri,  7 Jul 2023 07:59:03 -0700 (PDT)
X-QQ-mid: bizesmtp66t1688741930t1u7j3pm
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 22:58:49 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: FVl8EHhfVR7yQpfZTGK8C+9c2sldMS7g8O8sphi3aZ3lVOgDE6mUBVA4cCQad
        kO/IXo2DyBCrzayugYXvTg5txrwWjTP6N5r+UZweLv4IkFD30FHcdjIK1+jFUtIiMik2QUG
        HkOw6coYGLIO8BZwYXLEer8oY/wY2g/gx+OMutEGwfozZE01xyhidcc6kipNJivkA5mMy65
        UnHb6lTgTTv4PYZwlBSpSFlUEZRRZUodLLdeG6EjdS+b7ZgBv7p0QsKptgKlaz4XVxN1lfe
        hqxBNYLi51fQB/4Dn+CFw55wcyWYxgLZI1J69Sfu59KNZ5n2roe4WNRY7A+Hh9E5VKKVYIX
        d8PyfxwRmSvJCcQjaXt45gwIFPDjpPhrRd5iCY9Cz3CJtT5N/Y1dOGPHqXeOgY+nAuBj+ds
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12986911038597649536
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 07/15] tools/nolibc: clean up mmap() routine
Date:   Fri,  7 Jul 2023 22:58:20 +0800
Message-Id: <5817aa30c97be3b4db794a1d35272e0f379b80f1.1688739492.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688739492.git.falcon@tinylab.org>
References: <cover.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Do several cleanups together:

- Since all supported architectures have my_syscall6() now, remove the
  #ifdef check.

- Move the mmap() related macros to tools/include/nolibc/types.h and
  reuse most of them from <linux/mman.h>

- Apply the new generic __sysret() to convert the calling of sys_map()
  to oneline code

Note, since MAP_FAILED is -1 on Linux, so we can use the generic
__sysret() which returns -1 upon error and still satisfy user land that
checks for MAP_FAILED.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230702192347.GJ16233@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h   | 29 ++++++-----------------------
 tools/include/nolibc/types.h |  6 ++++++
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 3479f54d7957..3d01a24e6f7a 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -636,26 +636,11 @@ int mknod(const char *path, mode_t mode, dev_t dev)
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
@@ -666,20 +651,18 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 #endif
 
 	return (void *)my_syscall6(n, addr, length, prot, flags, fd, offset);
-#endif
 }
 #endif
 
+/* Note that on Linux, MAP_FAILED is -1 so we can use the generic __sysret()
+ * which returns -1 upon error and still satisfy user land that checks for
+ * MAP_FAILED.
+ */
+
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
index f96e28bff4ba..5e1bac8509ec 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_TYPES_H
 
 #include "std.h"
+#include <linux/mman.h>
 #include <linux/time.h>
 #include <linux/stat.h>
 
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

