Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2F735B8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjFSPvo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFSPvn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:51:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AD0A4;
        Mon, 19 Jun 2023 08:51:41 -0700 (PDT)
X-QQ-mid: bizesmtp64t1687189887tg4fzjsv
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:51:26 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 5q30pvLz2icBH/caXxT27x4f9FBSJcYyNdLV7m3J8v2Ry7takMP0mXa7DT1i3
        jQwPJO38Q3Zvqx2UcT3WQjrB96lfe6DY5IP8gMxXL0flRy+x+YiGwXSCxfPaniPbV/rHyxs
        yoCZLQy3AZVEbwKpQFcTc9cslDqmauQUwqfn8v36BVI4qnUnlhFcGWHj9fDtwxI8XCdfYIv
        i9fBc5Z6q3dWlxGEJI1/wI4qq4HDv2X/movyUNAkL1VkfOgx0kA6MUkYC6oLN4eefLH/mRc
        tao0Zr/YcNcFkXKtnmghIGRbaKk31qEouoCTsHb4mhVL4uhexQC/kBtEQnAz7gZoTN4Yoz5
        6O2NyuOrm0FK53k38XqBR3Z/A38eOqjxexOj5nmTN6RQsEeT+lQZW4+A4mKEA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6198696245822752568
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v4 07/10] tools/nolibc: clean up mmap() support
Date:   Mon, 19 Jun 2023 23:51:20 +0800
Message-Id: <b1162bc16ce5c397e99925e49317756c110e6f1a.1687187451.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687187451.git.falcon@tinylab.org>
References: <cover.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
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

- Move the mmap() related macros to tools/include/nolibc/types.h

- Apply the new __sysret() to convert the calling of sys_map() to
  oneline code

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h   | 24 +-----------------------
 tools/include/nolibc/types.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8a6e16472d54..1c02cec3bcd9 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -624,26 +624,11 @@ int mknod(const char *path, mode_t mode, dev_t dev)
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
@@ -654,20 +639,13 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
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
index f96e28bff4ba..f889d4e0ac7e 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -81,6 +81,17 @@
 #define MAXPATHLEN     (PATH_MAX)
 #endif
 
+/* flags for mmap */
+#ifndef MAP_SHARED
+#define MAP_SHARED		0x01	/* Share changes */
+#define MAP_PRIVATE		0x02	/* Changes are private */
+#define MAP_SHARED_VALIDATE	0x03	/* share + validate extension flags */
+#endif
+
+#ifndef MAP_FAILED
+#define MAP_FAILED ((void *)-1)
+#endif
+
 /* whence values for lseek() */
 #define SEEK_SET       0
 #define SEEK_CUR       1
-- 
2.25.1

