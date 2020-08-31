Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2E257AB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgHaNry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 09:47:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43642 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHaNr3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 09:47:29 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kCk8y-00062w-R6; Mon, 31 Aug 2020 13:46:44 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/4] pidfd: support PIDFD_NONBLOCK in pidfd_open()
Date:   Mon, 31 Aug 2020 15:45:48 +0200
Message-Id: <20200831134551.1599689-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
References: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce PIDFD_NONBLOCK to support non-blocking pidfd file descriptors.

Ever since the introduction of pidfds and more advanced async io various
programming languages such as Rust have grown support for async event
libraries. These libraries are created to help build epoll-based event loops
around file descriptors. A common pattern is to automatically make all file
descriptors they manage to O_NONBLOCK.

For such libraries the EAGAIN error code is treated specially. When a function
is called that returns EAGAIN the function isn't called again until the event
loop indicates the the file descriptor is ready. Supporting EAGAIN when
waiting on pidfds makes such libraries just work with little effort. In the
following patch we will extend waitid() internally to support non-blocking
pidfds.

Link: https://lore.kernel.org/lkml/20200811181236.GA18763@localhost/
Link: https://github.com/joshtriplett/async-pidfd
Cc: Kees Cook <keescook@chromium.org>
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/uapi/linux/pidfd.h | 12 ++++++++++++
 kernel/pid.c               | 12 +++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100644 include/uapi/linux/pidfd.h

diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
new file mode 100644
index 000000000000..5406fbc13074
--- /dev/null
+++ b/include/uapi/linux/pidfd.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_PIDFD_H
+#define _UAPI_LINUX_PIDFD_H
+
+#include <linux/types.h>
+#include <linux/fcntl.h>
+
+/* Flags for pidfd_open().  */
+#define PIDFD_NONBLOCK O_NONBLOCK
+
+#endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/pid.c b/kernel/pid.c
index b2562a7ce525..74ddbff1a6ba 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -43,6 +43,7 @@
 #include <linux/sched/task.h>
 #include <linux/idr.h>
 #include <net/sock.h>
+#include <uapi/linux/pidfd.h>
 
 struct pid init_struct_pid = {
 	.count		= REFCOUNT_INIT(1),
@@ -522,7 +523,8 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 /**
  * pidfd_create() - Create a new pid file descriptor.
  *
- * @pid:  struct pid that the pidfd will reference
+ * @pid:   struct pid that the pidfd will reference
+ * @flags: flags to pass
  *
  * This creates a new pid file descriptor with the O_CLOEXEC flag set.
  *
@@ -532,12 +534,12 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid)
+static int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
 	fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
-			      O_RDWR | O_CLOEXEC);
+			      flags | O_RDWR | O_CLOEXEC);
 	if (fd < 0)
 		put_pid(pid);
 
@@ -565,7 +567,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	int fd;
 	struct pid *p;
 
-	if (flags)
+	if (flags & ~PIDFD_NONBLOCK)
 		return -EINVAL;
 
 	if (pid <= 0)
@@ -576,7 +578,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 		return -ESRCH;
 
 	if (pid_has_task(p, PIDTYPE_TGID))
-		fd = pidfd_create(p);
+		fd = pidfd_create(p, flags);
 	else
 		fd = -EINVAL;
 
-- 
2.28.0

