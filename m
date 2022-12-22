Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467D3653B0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 04:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiLVDwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 22:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiLVDwb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 22:52:31 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972E1FCFA;
        Wed, 21 Dec 2022 19:52:29 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id C4CD981A1C;
        Thu, 22 Dec 2022 03:52:24 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671681149;
        bh=0oAsj4hR6tGtSZQUyeczrzwt8e+u+XyWFzo2fs4a44U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nad1zX656AwgsE9Fq0uKy0Jt4X/EVIrEq18oxqubn4ZO+VqLqmQ7w2HmWh1bZmEpj
         FiDuMJWuOszZNMEblqzx7t2B+yizrGJLNYWsMnol/ZpWqOkWsVkI9WXNRC5V+EJ0ci
         VKjMCb8+ZAqPEdhTFTwGCLFyhmmAuVYQmXEDQYWEPNsZUtrYYt+vs5TbZFcs995ocL
         t2rAUIoVjJta2v2PC+siE4BB1nJzZgoXwR645VTwm5h8gIJSWQrZyXo7NOlOzYq7J2
         Agqcofl741CQUeP9uPxFb0HNV5UVRl4Qv2i0rKUCM1/n+C7JP87Vg1R9RHNPxwRPal
         m38dmxGmBnRaQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v1 3/8] nolibc/sys: Implement `getpagesize(2)` function
Date:   Thu, 22 Dec 2022 10:51:29 +0700
Message-Id: <20221222035134.3467659-4-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222035134.3467659-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This commit adds getpagesize() function implementation.

The getpagesize() syscall doesn't always exist on the Linux syscall
table. Only specific architectures have this syscall.

Implementation detail:
Some architectures use a fixed page size, like x86. We can hard-code
the page size value on such architectures.

Some other architectures may use different page sizes. For example,
Linux aarch64 supports three values of page size: 4K, 16K, and 64K
which are selected at kernel compilation time. The kernel stores the
used page size in the auxiliary vector. The auxiliary vector can be
obtained from /proc/self/auxv at AT_PAGESZ key-value-pair.
/proc/self/auxv is available on all architectures.

Once we obtain the page size info, cache the value in a static
variable to avoid traversing the auxiliary vector again in the next
getpagesize() call. The page size should never change during kernel
uptime.

Link: https://lwn.net/Articles/519085
Link: https://github.com/torvalds/linux/blob/v6.1/fs/binfmt_elf.c#L260
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/sys.h | 114 +++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index ca348939eb50..e9e3640c36e1 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
+#include <linux/auxvec.h>
 
 #include "arch.h"
 #include "errno.h"
@@ -407,6 +408,119 @@ int getdents64(int fd, struct linux_dirent64 *dirp, int count)
 	return ret;
 }
 
+/*
+ * The getpagesize() syscall doesn't always exist on the Linux syscall
+ * table. Only specific architectures have this syscall.
+ *
+ * Implementation detail:
+ * Some architectures use a fixed page size, like x86. We can hard-code
+ * the page size value on such architectures.
+ *
+ * Some other architectures may use different page sizes. For example,
+ * Linux aarch64 supports three values of page size: 4K, 16K, and 64K
+ * which are selected at kernel compilation time. The kernel stores the
+ * used page size in the auxiliary vector. The auxiliary vector can be
+ * obtained from /proc/self/auxv at AT_PAGESZ key-val-pair.
+ * /proc/self/auxv is available on all architectures.
+ *
+ * Once we obtain the page size info, cache the value in a static
+ * variable to avoid traversing the auxiliary vector again in the next
+ * getpagesize() call. The page size should never change during kernel
+ * uptime.
+ *
+ * Link: https://lwn.net/Articles/519085
+ * Link: https://github.com/torvalds/linux/blob/v6.1/fs/binfmt_elf.c#L260
+ *
+ *
+ * long getpagesize(void);
+ *
+ */
+
+#if defined(__x86_64__) || defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__)
+__attribute__((unused))
+static inline long getpagesize(void)
+{
+	/*
+	 * x86 family is always 4K page. Don't bother
+	 * reading the auxiliary vector.
+	 */
+	return 4096;
+}
+#else
+static int sys_open(const char *path, int flags, mode_t mode);
+static ssize_t sys_read(int fd, void *buf, size_t count);
+
+/*
+ * This function works for all architectures.
+ */
+static long sys_getpagesize(void)
+{
+	uint64_t buf[2] = {0, 0};
+	long ret;
+	int fd;
+
+
+	fd = sys_open("/proc/self/auxv", O_RDONLY, 0);
+	if (fd < 0)
+		return fd;
+
+	while (1) {
+		ssize_t x;
+
+		x = sys_read(fd, buf, sizeof(buf));
+		if (x < 0) {
+			ret = x;
+			break;
+		}
+
+		if (__builtin_expect(x == 0, 0)) {
+			/*
+			 * We've reached the end of the auxiliary
+			 * vector, but can't find the AT_PAGESZ
+			 * entry.
+			 */
+			ret = -ENOENT;
+			break;
+		}
+
+		/*
+		 * buf[0] is the key.
+		 * buf[1] is the value.
+		 */
+		if (buf[0] == AT_PAGESZ) {
+			ret = buf[1];
+			break;
+		}
+	}
+
+	sys_close(fd);
+	return ret;
+}
+
+__attribute__((unused))
+static long getpagesize(void)
+{
+	static long cached;
+	long ret;
+
+	/*
+	 * No need to read the auxv for the second
+	 * getpagesize() call.
+	 */
+	if (__builtin_expect(cached != 0, 1))
+		return cached;
+
+	ret = sys_getpagesize();
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	} else {
+		cached = ret;
+	}
+	return ret;
+}
+#endif
+
 
 /*
  * pid_t getpgid(pid_t pid);
-- 
Ammar Faizi

