Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E4715023
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjE2UAQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2UAQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 16:00:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C6CF;
        Mon, 29 May 2023 13:00:14 -0700 (PDT)
X-QQ-mid: bizesmtp72t1685390404tm1hc6lq
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 04:00:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: hHcwae2JLGcWbJfH39kHmo4snlKcsDyQqojZPXS964VUI/pU9KgvLuypS0Ah7
        jYeyVqCZsExVvRBfJlr+CiyoUz3vLCHyLwxLp/d64KPpdGb9bB8hSTxi9nDGIkG3T5CUXWl
        ekxz82XJnF4H40ogAAvy1iEdLCLqKp94Eo1uPbII44VKTBekWYtZMOzFa+Wod+3vQNiiWRa
        pmueuBHNfNVM2iNDyqMzp8NUw7yYOifbwx+HQ6iREaLTCMyhglMI3jTjepktljlKAjdC2hf
        jMvzw5hE1hfVlh/86OfbTnombI5g+dpuv2aAWpJsjdxXMJWC5lNwPtoAaHQHMzhAXCLpTAV
        qXV0/H7I/oJg8xtfQg/yElw+Z0v+AGL/OWV9+iaWjDFf9RP0kwU+XVcK9A5Tn7Vqx0UKNeT
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3843116070107166378
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 11/13] tools/nolibc: sys_gettimeofday: add pure 64bit gettimeofday
Date:   Tue, 30 May 2023 03:59:57 +0800
Message-Id: <6d293f3957c43e60319af94b3e5463b376a86752.1685387484.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685387484.git.falcon@tinylab.org>
References: <cover.1685387484.git.falcon@tinylab.org>
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

It's time to provide 64bit time structs for all platforms, for y2038 is
near.

clock_gettime64 has been added from at least v5.0.0.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/afc4944f-9494-4367-906d-06ac47648ab7@app.fastmail.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index ca802627e88f..533233094733 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -25,6 +25,7 @@
 
 #include "arch.h"
 #include "errno.h"
+#include "string.h"
 #include "types.h"
 
 /* Functions in this file only describe syscalls. They're declared static so
@@ -552,7 +553,34 @@ long getpagesize(void)
 static __attribute__((unused))
 int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-	return my_syscall2(__NR_gettimeofday, tv, tz);
+#if defined(__NR_clock_gettime) || defined(__NR_clock_gettime64)
+#ifdef __NR_clock_gettime64
+	const long nr_clock_gettime = __NR_clock_gettime64;
+#elif __SIZEOF_LONG__ == 8
+	const long nr_clock_gettime = __NR_clock_gettime;
+#else
+#error No __NR_clock_gettime64 defined, cannot implement time64 sys_gettimeofday()
+#endif
+	struct timespec ts;
+	int ret;
+
+	/* set tz to zero to avoid random number */
+	if (tz != NULL)
+		memset(tz, 0, sizeof(struct timezone));
+
+	if (tv == NULL)
+		return 0;
+
+	ret = my_syscall2(nr_clock_gettime, CLOCK_REALTIME, &ts);
+	if (ret)
+		return ret;
+
+	tv->tv_sec = ts.tv_sec;
+	tv->tv_usec = (unsigned int)ts.tv_nsec / 1000;
+	return 0;
+#else
+#error Neither __NR_clock_gettime nor __NR_clock_gettime64 defined, cannot implement sys_gettimeofday()
+#endif
 }
 
 static __attribute__((unused))
-- 
2.25.1

