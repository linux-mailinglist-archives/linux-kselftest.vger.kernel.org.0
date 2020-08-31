Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12CE257AC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgHaNs3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 09:48:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43637 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHaNr2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 09:47:28 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kCk8z-00062w-Hy; Mon, 31 Aug 2020 13:46:45 +0000
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 2/4] exit: support non-blocking pidfds
Date:   Mon, 31 Aug 2020 15:45:49 +0200
Message-Id: <20200831134551.1599689-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
References: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Passing a non-blocking pidfd to waitid() currently has no effect, i.e.
is not supported. There are users which would like to use waitid() on
pidfds that are O_NONBLOCK and mix it with pidfds that are blocking and
both pass them to waitid().
The expected behavior is to have waitid() return -EAGAIN for
non-blocking pidfds and to block for blocking pidfds without needing to
perform any additional checks for flags set on the pidfd before passing
it to waitid().
Non-blocking pidfds will return EAGAIN from waitid() when no child
process is ready yet. Returning -EAGAIN for non-blocking pidfds makes it
easier for event loops that handle EAGAIN specially.

It also makes the API more consistent and uniform. In essence, waitid()
is treated like a read on a non-blocking pidfd or a recvmsg() on a
non-blocking socket.
With the addition of support for non-blocking pidfds we support the same
functionality that sockets do. For sockets() recvmsg() supports
MSG_DONTWAIT for pidfds waitid() supports WNOHANG. Both flags are
per-call options. In contrast non-blocking pidfds and non-blocking
sockets are a setting on an open file description affecting all threads
in the calling process as well as other processes that hold file
descriptors referring to the same open file description. Both behaviors,
per call and per open file description, have genuine use-cases.

The implementation should be straightforward, we simply raise the
WNOHANG flag when a non-blocking pidfd is passed and introduce a
eagain_error member in struct wait_opts similar to the notask_error
member. The former is set to -EAGAIN for non-blocking pidfds and to zero
for all other cases. If no child process exists non-blocking pidfd users
will continue to see ECHILD but if child processes exist but have not
yet exited users will see EAGAIN.

A concrete use-case that was brought on-list was Josh's async pidfd
library. Ever since the introduction of pidfds and more advanced async
io various programming languages such as Rust have grown support for
async event libraries. These libraries are created to help build
epoll-based event loops around file descriptors. A common pattern is to
automatically make all file descriptors they manage to O_NONBLOCK.

For such libraries the EAGAIN error code is treated specially. When a
function is called that returns EAGAIN the function isn't called again
until the event loop indicates the the file descriptor is ready.
Supporting EAGAIN when waiting on pidfds makes such libraries just work
with little effort.

Link: https://lore.kernel.org/lkml/20200811181236.GA18763@localhost/
Link: https://github.com/joshtriplett/async-pidfd
Cc: Kees Cook <keescook@chromium.org>
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Suggested-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/exit.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f334e7..598f2fefd721 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -934,6 +934,7 @@ struct wait_opts {
 
 	wait_queue_entry_t		child_wait;
 	int			notask_error;
+	int			eagain_error;
 };
 
 static int eligible_pid(struct wait_opts *wo, struct task_struct *p)
@@ -1461,6 +1462,8 @@ static long do_wait(struct wait_opts *wo)
 
 notask:
 	retval = wo->notask_error;
+	if (!retval)
+		retval = wo->eagain_error;
 	if (!retval && !(wo->wo_flags & WNOHANG)) {
 		retval = -ERESTARTSYS;
 		if (!signal_pending(current)) {
@@ -1474,7 +1477,7 @@ static long do_wait(struct wait_opts *wo)
 	return retval;
 }
 
-static struct pid *pidfd_get_pid(unsigned int fd)
+static struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 {
 	struct fd f;
 	struct pid *pid;
@@ -1484,8 +1487,10 @@ static struct pid *pidfd_get_pid(unsigned int fd)
 		return ERR_PTR(-EBADF);
 
 	pid = pidfd_pid(f.file);
-	if (!IS_ERR(pid))
+	if (!IS_ERR(pid)) {
 		get_pid(pid);
+		*flags = f.file->f_flags;
+	}
 
 	fdput(f);
 	return pid;
@@ -1498,6 +1503,7 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 	struct pid *pid = NULL;
 	enum pid_type type;
 	long ret;
+	unsigned int f_flags = 0;
 
 	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED|
 			__WNOTHREAD|__WCLONE|__WALL))
@@ -1531,9 +1537,10 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 		if (upid < 0)
 			return -EINVAL;
 
-		pid = pidfd_get_pid(upid);
+		pid = pidfd_get_pid(upid, &f_flags);
 		if (IS_ERR(pid))
 			return PTR_ERR(pid);
+
 		break;
 	default:
 		return -EINVAL;
@@ -1544,6 +1551,11 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 	wo.wo_flags	= options;
 	wo.wo_info	= infop;
 	wo.wo_rusage	= ru;
+	wo.eagain_error = 0;
+	if (f_flags & O_NONBLOCK) {
+		wo.wo_flags	|= WNOHANG;
+		wo.eagain_error	= -EAGAIN;
+	}
 	ret = do_wait(&wo);
 
 	put_pid(pid);
@@ -1618,6 +1630,7 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
 	wo.wo_info	= NULL;
 	wo.wo_stat	= 0;
 	wo.wo_rusage	= ru;
+	wo.eagain_error	= 0;
 	ret = do_wait(&wo);
 	put_pid(pid);
 	if (ret > 0 && stat_addr && put_user(wo.wo_stat, stat_addr))
-- 
2.28.0

