Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD731BC66
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBOP2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 10:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhBOP12 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 10:27:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37BC0613D6;
        Mon, 15 Feb 2021 07:25:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 23AB81F44F31
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
Subject: [RFC PATCH 13/13] kernel: Enable waitpid() for futex2
Date:   Mon, 15 Feb 2021 12:24:04 -0300
Message-Id: <20210215152404.250281-14-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210215152404.250281-1-andrealmeid@collabora.com>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To make pthreads works as expected if they are using futex2, wake
clear_child_tid with futex2 as well. This is make applications that uses
waitpid() (and clone(CLONE_CHILD_SETTID)) wake while waiting for the
child to terminate. Given that apps should not mix futex() and futex2(),
any correct app will trigger a harmless noop wakeup on the interface
that it isn't using.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---

This commit is here for the intend to show what we need to do in order
to get a full NPTL working on top of futex2. It should be merged after
we talk to glibc folks on the details around the futex_wait() side. For
instance, we could use this as an opportunity to use private futexes or
8bit sized futexes, but both sides need to use the exactly same flags.
---
 include/linux/syscalls.h |  2 ++
 kernel/fork.c            |  2 ++
 kernel/futex2.c          | 30 ++++++++++++++++++------------
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 06823bc7ef9d..38c2fc50ada9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1312,6 +1312,8 @@ int ksys_ipc(unsigned int call, int first, unsigned long second,
 	unsigned long third, void __user * ptr, long fifth);
 int compat_ksys_ipc(u32 call, int first, int second,
 	u32 third, u32 ptr, u32 fifth);
+long ksys_futex_wake(void __user *uaddr, unsigned long nr_wake,
+		     unsigned int flags);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..e39846a73a43 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1308,6 +1308,8 @@ static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 			put_user(0, tsk->clear_child_tid);
 			do_futex(tsk->clear_child_tid, FUTEX_WAKE,
 					1, NULL, NULL, 0, 0);
+			ksys_futex_wake(tsk->clear_child_tid, 1,
+					FUTEX_32 | FUTEX_SHARED_FLAG);
 		}
 		tsk->clear_child_tid = NULL;
 	}
diff --git a/kernel/futex2.c b/kernel/futex2.c
index 8a8b45f98d3b..a810b7f5c3a0 100644
--- a/kernel/futex2.c
+++ b/kernel/futex2.c
@@ -942,18 +942,8 @@ static inline bool futex_match(struct futex_key key1, struct futex_key key2)
 		key1.offset == key2.offset);
 }
 
-/**
- * sys_futex_wake - Wake a number of futexes waiting on an address
- * @uaddr:   Address of futex to be woken up
- * @nr_wake: Number of futexes waiting in uaddr to be woken up
- * @flags:   Flags for size and shared
- *
- * Wake `nr_wake` threads waiting at uaddr.
- *
- * Returns the number of woken threads on success, error code otherwise.
- */
-SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
-		unsigned int, flags)
+long ksys_futex_wake(void __user *uaddr, unsigned long nr_wake,
+		     unsigned int flags)
 {
 	bool shared = (flags & FUTEX_SHARED_FLAG) ? true : false;
 	unsigned int size = flags & FUTEX_SIZE_MASK;
@@ -990,6 +980,22 @@ SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
 	return ret;
 }
 
+/**
+ * sys_futex_wake - Wake a number of futexes waiting on an address
+ * @uaddr:   Address of futex to be woken up
+ * @nr_wake: Number of futexes waiting in uaddr to be woken up
+ * @flags:   Flags for size and shared
+ *
+ * Wake `nr_wake` threads waiting at uaddr.
+ *
+ * Returns the number of woken threads on success, error code otherwise.
+ */
+SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
+		unsigned int, flags)
+{
+	return ksys_futex_wake(uaddr, nr_wake, flags);
+}
+
 static void futex_double_unlock(struct futex_bucket *b1, struct futex_bucket *b2)
 {
 	spin_unlock(&b1->lock);
-- 
2.30.1

