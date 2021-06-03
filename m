Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9638639AB55
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 22:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFCUCg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 16:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFCUCe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 16:02:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85570C061756;
        Thu,  3 Jun 2021 13:00:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id EC0F01F4350E
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
        Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v4 06/15] futex2: Add compatibility entry point for x86_x32 ABI
Date:   Thu,  3 Jun 2021 16:59:15 -0300
Message-Id: <20210603195924.361327-7-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603195924.361327-1-andrealmeid@collabora.com>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
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
 kernel/futex2.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/futex2.c b/kernel/futex2.c
index 1e97e5f2e793..5fd0b3d73b53 100644
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
@@ -910,7 +914,16 @@ SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
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
 		ret = __futex_waitv(futexv, nr_futexes, timo, flags);
 
@@ -1215,6 +1228,27 @@ SYSCALL_DEFINE6(futex_requeue, struct futex_requeue __user *, uaddr1,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_X86_X32_ABI
+	if (in_x32_syscall()) {
+		ret = compat_futex_parse_requeue(&rq1, (struct compat_futex_requeue *)uaddr1);
+		if (ret)
+			return ret;
+
+		ret = compat_futex_parse_requeue(&rq2, (struct compat_futex_requeue *)uaddr2);
+		if (ret)
+			return ret;
+	} else
+#endif
+	{
+		ret = futex_parse_requeue(&rq1, uaddr1);
+		if (ret)
+			return ret;
+
+		ret = futex_parse_requeue(&rq2, uaddr2);
+		if (ret)
+			return ret;
+	}
+
 	return __futex_requeue(rq1, rq2, nr_wake, nr_requeue, cmpval);
 }
 
-- 
2.31.1

