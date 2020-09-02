Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A625A94E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBKXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 06:23:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49494 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIBKXV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 06:23:21 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDPvC-00069F-UV; Wed, 02 Sep 2020 10:23:19 +0000
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
Subject: [PATCH v2 2/4] exit: support non-blocking pidfds
Date:   Wed,  2 Sep 2020 12:21:28 +0200
Message-Id: <20200902102130.147672-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902102130.147672-1-christian.brauner@ubuntu.com>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Passing a non-blocking pidfd to waitid() currently has no effect, i.e.  is not
supported. There are users which would like to use waitid() on pidfds that are
O_NONBLOCK and mix it with pidfds that are blocking and both pass them to
waitid().
The expected behavior is to have waitid() return -EAGAIN for non-blocking
pidfds and to block for blocking pidfds without needing to perform any
additional checks for flags set on the pidfd before passing it to waitid().
Non-blocking pidfds will return EAGAIN from waitid() when no child process is
ready yet. Returning -EAGAIN for non-blocking pidfds makes it easier for event
loops that handle EAGAIN specially.

It also makes the API more consistent and uniform. In essence, waitid() is
treated like a read on a non-blocking pidfd or a recvmsg() on a non-blocking
socket.
With the addition of support for non-blocking pidfds we support the same
functionality that sockets do. For sockets() recvmsg() supports MSG_DONTWAIT
for pidfds waitid() supports WNOHANG. Both flags are per-call options. In
contrast non-blocking pidfds and non-blocking sockets are a setting on an open
file description affecting all threads in the calling process as well as other
processes that hold file descriptors referring to the same open file
description. Both behaviors, per call and per open file description, have
genuine use-cases.

The implementation should be straightforward, we simply raise the WNOHANG flag
when a non-blocking pidfd is passed and when do_wait() returns without finding
an eligible task and the pidfd is non-blocking we set EAGAIN.  If no child
process exists non-blocking pidfd users will continue to see ECHILD but if
child processes exist but have not yet exited users will see EAGAIN.

A concrete use-case that was brought on-list was Josh's async pidfd library.
Ever since the introduction of pidfds and more advanced async io various
programming languages such as Rust have grown support for async event
libraries. These libraries are created to help build epoll-based event loops
around file descriptors. A common pattern is to automatically make all file
descriptors they manage to O_NONBLOCK.

For such libraries the EAGAIN error code is treated specially. When a function
is called that returns EAGAIN the function isn't called again until the event
loop indicates the the file descriptor is ready.  Supporting EAGAIN when
waiting on pidfds makes such libraries just work with little effort.

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
/* v2 */
- Oleg Nesterov <oleg@redhat.com>:
  - Remove the eagain_error and simple set to EAGAIN in kernel_waitid() if
    pidfd is non-blocking and no child process has yet exited.
---
 kernel/exit.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f334e7..254ea3efe954 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1474,7 +1474,7 @@ static long do_wait(struct wait_opts *wo)
 	return retval;
 }
 
-static struct pid *pidfd_get_pid(unsigned int fd)
+static struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 {
 	struct fd f;
 	struct pid *pid;
@@ -1484,8 +1484,10 @@ static struct pid *pidfd_get_pid(unsigned int fd)
 		return ERR_PTR(-EBADF);
 
 	pid = pidfd_pid(f.file);
-	if (!IS_ERR(pid))
+	if (!IS_ERR(pid)) {
 		get_pid(pid);
+		*flags = f.file->f_flags;
+	}
 
 	fdput(f);
 	return pid;
@@ -1498,6 +1500,7 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 	struct pid *pid = NULL;
 	enum pid_type type;
 	long ret;
+	unsigned int f_flags = 0;
 
 	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED|
 			__WNOTHREAD|__WCLONE|__WALL))
@@ -1531,9 +1534,10 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
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
@@ -1544,7 +1548,12 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 	wo.wo_flags	= options;
 	wo.wo_info	= infop;
 	wo.wo_rusage	= ru;
+	if (f_flags & O_NONBLOCK)
+		wo.wo_flags |= WNOHANG;
+
 	ret = do_wait(&wo);
+	if (!ret && (f_flags & O_NONBLOCK))
+		ret = -EAGAIN;
 
 	put_pid(pid);
 	return ret;
-- 
2.28.0

