Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015AA715018
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE2T4a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjE2T43 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:56:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5B92;
        Mon, 29 May 2023 12:56:26 -0700 (PDT)
X-QQ-mid: bizesmtp78t1685390175tmckq6oi
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:56:14 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: CRJwvrMA7Ii5QGhWTR7gAjDn/im3cUJTMJLrKCItiu9//IedHrZO8VPqve9CI
        JREbxHhECEfjcwj3iOLI7AtJRxZhcfwcuO1SA3a+CkIkUPFo9ONYVTiml7M01fxeghXu0CT
        vdthD4zOS6F9DsGvD+yFqUeF+tsLVoWmREiNsqk8v4emuWimsNWz2q3X91Rr5bTzuDeRHu1
        8SYxkOwE40helGX0uZm1e7sq9E+ub2TQrpXIWvhGbqB2tcaoNclftY75ysAHMxF/uv56ubI
        q3Ha1mhj6elqdQbHhlOWR2LgMgKeKz4aGx+iiiglqpb3OKP3Sh2pYWRiEYiiIwD3rL2aP6Z
        skaIKTfTv2vEIU7Boxl8Xp2wT5XTgRGw92F+cgkFVvRT1zRnHdRY8A885R47PP8mfLT54NQ
        3BjvdTpJLo4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14858657345865464071
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 08/13] tools/nolibc: add pure 64bit time structs
Date:   Tue, 30 May 2023 03:56:01 +0800
Message-Id: <c6bf754329eeb61a1ffe8f9e04ec70cb02e1a2ed.1685387484.git.falcon@tinylab.org>
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

There are still old "struct timeval" and "struct itimerval" in
include/uapi/linux/time.h, remove "#include <linux/time.h>" and add our
own pure 64bit ones.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/9e4064fc-f0c5-4dd3-941f-344d2150e1cd@app.fastmail.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h   |  2 --
 tools/include/nolibc/types.h | 49 +++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index d0720af84b6d..1b3675d4c5fc 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -17,7 +17,6 @@
 #include <asm/mman.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
-#include <linux/time.h>
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
@@ -28,7 +27,6 @@
 #include "errno.h"
 #include "types.h"
 
-
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
  * to pass a pointer to one of their instances. Each syscall exists in two
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 698d859fc6e2..4ff35b7ea2bb 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -8,10 +8,57 @@
 #define _NOLIBC_TYPES_H
 
 #include "std.h"
-#include <linux/time.h>
+#include <linux/time_types.h>
 #include <linux/stat.h>
 #include <linux/wait.h>
 
+/* based on linux/time.h but with pure 64bit time structs */
+#define timespec __kernel_timespec
+#define itimerspec __kernel_itimerspec
+
+/* timeval is only provided for users, not compatible with syscalls */
+struct timeval {
+	__kernel_time64_t tv_sec;	/* seconds */
+	__s64 tv_usec;			/* microseconds */
+};
+
+struct timezone {
+	int tz_minuteswest;		/* minutes west of Greenwich */
+	int tz_dsttime;			/* type of dst correction */
+};
+
+/* itimerval is only provided for users, not compatible with syscalls */
+struct itimerval {
+	struct timeval it_interval;	/* timer interval */
+	struct timeval it_value;	/* current value */
+};
+
+/*
+ * Names of the interval timers, and structure
+ * defining a timer setting:
+ */
+#define ITIMER_REAL			0
+#define ITIMER_VIRTUAL			1
+#define ITIMER_PROF			2
+
+/*
+ * The IDs of the various system clocks (for POSIX.1b interval timers):
+ */
+#define CLOCK_REALTIME			0
+#define CLOCK_MONOTONIC			1
+#define CLOCK_PROCESS_CPUTIME_ID	2
+#define CLOCK_THREAD_CPUTIME_ID		3
+#define CLOCK_MONOTONIC_RAW		4
+#define CLOCK_REALTIME_COARSE		5
+#define CLOCK_MONOTONIC_COARSE		6
+#define CLOCK_BOOTTIME			7
+#define CLOCK_REALTIME_ALARM		8
+#define CLOCK_BOOTTIME_ALARM		9
+
+/*
+ * The various flags for setting POSIX.1b interval timers:
+ */
+#define TIMER_ABSTIME			0x01
 
 /* Only the generic macros and types may be defined here. The arch-specific
  * ones such as the O_RDONLY and related macros used by fcntl() and open(), or
-- 
2.25.1

