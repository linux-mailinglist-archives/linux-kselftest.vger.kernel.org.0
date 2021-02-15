Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEA731BC57
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 16:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBOP0k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 10:26:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60150 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBOPZn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 10:25:43 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id F10AE1F44F15
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 05/13] futex2: Add compatibility entry point for x86_x32 ABI
Date:   Mon, 15 Feb 2021 12:23:56 -0300
Message-Id: <20210215152404.250281-6-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210215152404.250281-1-andrealmeid@collabora.com>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

New syscalls should use the same entry point for x86_64 and x86_x32
paths. Add a wrapper for x32 calls to use parse functions that assumes
32bit pointers.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex2.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/kernel/futex2.c b/kernel/futex2.c
index bad8c183cf9f..8a8b45f98d3b 100644
--- a/kernel/futex2.c
+++ b/kernel/futex2.c
@@ -23,6 +23,10 @@
 #include <linux/syscalls.h>
 #include <uapi/linux/futex.h>
 
+#ifdef CONFIG_X86_64
+#include <linux/compat.h>
+#endif
+
 /**
  * struct futex_key - Components to build unique key for a futex
  * @pointer: Pointer to current->mm or inode's UUID for file backed futexes
@@ -875,7 +879,16 @@ SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
 	futexv->hint = false;
 	futexv->task = current;
 
-	ret = futex_parse_waitv(futexv, waiters, nr_futexes);
+#ifdef CONFIG_X86_X32_ABI
+	if (in_x32_syscall()) {
+		ret = compat_futex_parse_waitv(futexv, (struct compat_futex_waitv *)waiters,
+					       nr_futexes);
+	} else
+#endif
+	{
+		ret = futex_parse_waitv(futexv, waiters, nr_futexes);
+	}
+
 	if (!ret)
 		ret = futex_set_timer_and_wait(futexv, nr_futexes, timo, flags);
 
@@ -1181,13 +1194,28 @@ SYSCALL_DEFINE6(futex_requeue, struct futex_requeue __user *, uaddr1,
 	if (flags)
 		return -EINVAL;
 
-	ret = futex_parse_requeue(&rq1, uaddr1, &shared1);
-	if (ret)
-		return ret;
+#ifdef CONFIG_X86_X32_ABI
+	if (in_x32_syscall()) {
+		ret = compat_futex_parse_requeue(&rq1, (struct compat_futex_requeue *)uaddr1,
+						 &shared1);
+		if (ret)
+			return ret;
 
-	ret = futex_parse_requeue(&rq2, uaddr2, &shared2);
-	if (ret)
-		return ret;
+		ret = compat_futex_parse_requeue(&rq2, (struct compat_futex_requeue *)uaddr2,
+						 &shared2);
+		if (ret)
+			return ret;
+	} else
+#endif
+	{
+		ret = futex_parse_requeue(&rq1, uaddr1, &shared1);
+		if (ret)
+			return ret;
+
+		ret = futex_parse_requeue(&rq2, uaddr2, &shared2);
+		if (ret)
+			return ret;
+	}
 
 	return __futex_requeue(rq1, rq2, nr_wake, nr_requeue, cmpval, shared1, shared2);
 }
-- 
2.30.1

