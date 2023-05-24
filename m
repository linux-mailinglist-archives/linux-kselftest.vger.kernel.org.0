Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2970FD68
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjEXSDp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 14:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEXSDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 14:03:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C082B6;
        Wed, 24 May 2023 11:03:41 -0700 (PDT)
X-QQ-mid: bizesmtp78t1684951416tb3pz334
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 02:03:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKahN1m9MXihhsfaKEggHvIyA5/pTK2SaWBMBZDnB/qZVYB9hhaeW
        CtThDB38b2eIGVPxEtHTZ/aQx/m+LDrbyyqaUCEQjb3UrqG8e6vmoo+YN9ez5R3jAa+ctud
        hvf6+/GoNail8IsTWRntTm/VesMGwdeFQrjRCv9wgfeqGxpgfAXNzkEbm39kA+CQ13SCWiE
        iowUfkUtPUrUPEHv1pYfm9xxUrsV9UR/X3MRXjJ4GFhpHfjlERqt1laG9cY/MuPEBPIPVse
        G6RO3Z7tTbo4v1LfUw+MGPlMNWQaDMO/oUPriwjPaOHCEtWdRGHW+OdwyxBTwFSMSP/o1qi
        MlHUfX46tdBlGm7LLQfYMG6eXe10fkgOsXkruJqOw4zHZuAjYDpIHkDjpGh47G+lEvpB/RZ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13367086140274863961
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 13/13] tools/nolibc: sys_gettimeofday: riscv: use __NR_clock_gettime64 for rv32
Date:   Thu, 25 May 2023 02:03:32 +0800
Message-Id: <e35cf1de35fdb0a236064ff645ae4734d32bacd4.1684949845.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
__NR_gettimeofday and __NR_clock_gettime after kernel commit d4c08b9776b3
("riscv: Use latest system call ABI"), use __NR_clock_gettime64 instead.

This code is based on src/time/gettimeofday.c of musl and
sysdeps/unix/sysv/linux/clock_gettime.c of glibc.

Both __NR_clock_gettime and __NR_clock_gettime64 are added for
sys_gettimeofday() for they share most of the code.

Notes:

* Both tv and tz are not directly passed to kernel clock_gettime*
  syscalls, so, it isn't able to check the pointer automatically with the
  get_user/put_user helpers just like kernel gettimeofday syscall does.
  instead, we emulate (but not completely) such checks in our new
  __NR_clock_gettime* branch of nolibc.

* kernel clock_gettime* syscalls can not get tz info, just like musl and
  glibc do, we set tz to zero to avoid a random number.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 2642b380c6aa..ad38cc3856be 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -26,6 +26,7 @@
 
 #include "arch.h"
 #include "errno.h"
+#include "string.h"
 #include "types.h"
 
 
@@ -51,6 +52,11 @@
  * should not be placed here.
  */
 
+/*
+ * This is the first address past the end of the text segment (the program code).
+ */
+
+extern char etext;
 
 /*
  * int brk(void *addr);
@@ -554,7 +560,47 @@ long getpagesize(void)
 static __attribute__((unused))
 int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
+#ifdef __NR_gettimeofday
 	return my_syscall2(__NR_gettimeofday, tv, tz);
+#elif defined(__NR_clock_gettime) || defined(__NR_clock_gettime64)
+#ifdef __NR_clock_gettime
+	struct timespec ts;
+#else
+	struct timespec64 ts;
+#define __NR_clock_gettime __NR_clock_gettime64
+#endif
+	int ret;
+
+	/* make sure tv pointer is at least after code segment */
+	if (tv != NULL && (char *)tv <= &etext)
+		return -EFAULT;
+
+	/* set tz to zero to avoid random number */
+	if (tz != NULL) {
+		if ((char *)tz > &etext)
+			memset(tz, 0, sizeof(struct timezone));
+		else
+			return -EFAULT;
+	}
+
+	if (tv == NULL)
+		return 0;
+
+	ret = my_syscall2(__NR_clock_gettime, CLOCK_REALTIME, &ts);
+	if (ret)
+		return ret;
+
+	tv->tv_sec = (time_t) ts.tv_sec;
+#ifdef __NR_clock_gettime64
+	if (tv->tv_sec != ts.tv_sec)
+		return -EOVERFLOW;
+#endif
+
+	tv->tv_usec = ts.tv_nsec / 1000;
+	return 0;
+#else
+#error None of __NR_gettimeofday, __NR_clock_gettime and __NR_clock_gettime64 defined, cannot implement sys_gettimeofday()
+#endif
 }
 
 static __attribute__((unused))
-- 
2.25.1

