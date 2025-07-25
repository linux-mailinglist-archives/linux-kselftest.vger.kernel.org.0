Return-Path: <linux-kselftest+bounces-37995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E670B1220E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD43B564613
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710D2EF9B2;
	Fri, 25 Jul 2025 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nixdorf.dev header.i=@nixdorf.dev header.b="va3MpInR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from shadowice.org (shadowice.org [95.216.8.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644AA2EE97B;
	Fri, 25 Jul 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.8.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461116; cv=none; b=GZHSIBh0GcBOIal2j9DnnE7yTJLy6Wnncqb5ZRuvW/zH1P4qLE6phf7hx941JbLrItGDvxQdiVIe9Uq1BPbLONF0XWlTL+GVTc0R7O+ge1hbLsu6RdaTTYdfWC29xWMmXFvB65lUzXzJiT7w11SKsS7WCEM0nOQ3Wkrv7zX4914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461116; c=relaxed/simple;
	bh=hDmbRW3zz/0YLNsUObf/IWESbvBcteoW7UzuedfnR64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXdG6x7PDjrJteqijbOGn5zrM6ItPWkl1hytge8ffsjyupry3VE06PDLtfLr4WK/3cNj5beF8Cv8lDzur363ydn0JcqiwlT8sC6H0ylitsMwlkFUuTh8N/9udpz48xeddTpJqhnsX0D5awtvUNpUhG97U/+zHH5h56sWkLJvHn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nixdorf.dev; spf=none smtp.mailfrom=nixdorf.dev; dkim=fail (0-bit key) header.d=nixdorf.dev header.i=@nixdorf.dev header.b=va3MpInR reason="key not found in DNS"; arc=none smtp.client-ip=95.216.8.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nixdorf.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nixdorf.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=hDmbRW3zz/0Y
	LNsUObf/IWESbvBcteoW7UzuedfnR64=; h=cc:to:in-reply-to:references:
	subject:date:from; d=nixdorf.dev; b=va3MpInRWbE9JfduRIp/DtcS8tnSRvxHJD
	Wn8iZcRErHvsaUzOC09/H6b+gOAhh3XG5LCLbylY/T5LU9u0M36iexMkl9eGYUkFbX1/o0
	PjxSL3rTccP9mqIcSBnCSDwwniOyZaEToUvDEdZIhvAjeIAnKETvxnKs0VRjX7P/Ddk=
Received: from [127.0.0.1] (p4fc61662.dip0.t-ipconnect.de [79.198.22.98])
	by shadowice.org (OpenSMTPD) with ESMTPSA id 4da8dc46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 25 Jul 2025 18:31:42 +0200 (CEST)
From: Johannes Nixdorf <johannes@nixdorf.dev>
Date: Fri, 25 Jul 2025 18:31:19 +0200
Subject: [PATCH v2 2/2] selftests/seccomp: Add a test for the
 WAIT_KILLABLE_RECV fast reply race
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-seccomp-races-v2-2-cf8b9d139596@nixdorf.dev>
References: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
In-Reply-To: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Sargun Dhillon <sargun@sargun.me>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ali Polatel <alip@chesswob.org>, 
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
 Johannes Nixdorf <johannes@nixdorf.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753461100; l=5633;
 i=johannes@nixdorf.dev; s=20250722; h=from:subject:message-id;
 bh=hDmbRW3zz/0YLNsUObf/IWESbvBcteoW7UzuedfnR64=;
 b=IHqyetDCVDnPPfDjQ9CjfsnYJlu/q+HgM3eYlQuf6AIMdkrtjZse0J2+P5IlUirryjLWt0l+o
 0Wso+Mjwe1oAV4/eYROKTDI5WRBMy8KAMoFupbcMt899M5A/b2cRhxh
X-Developer-Key: i=johannes@nixdorf.dev; a=ed25519;
 pk=6Mv9a34ZxWm/f3K6MdzLRKgty83xawuXPS5bMkbLzWs=

If WAIT_KILLABLE_RECV was specified, and an event is received, the
tracee's syscall is not supposed to be interruptible. This was not properly
ensured if the reply was sent too fast, and an interrupting signal was
received before the reply was processed on the tracee side.

Add a test for this, that consists of:

 - a tracee with a timer that keeps sending it signals while repeatedly
   running a traced syscall in a loop,
 - a tracer that repeatedly handles all syscalls from the tracee in a
   loop, and
 - a shared pipe between both, on which the tracee sends one byte per
   syscall attempted and the tracer reads one byte per syscall handled.

If the syscall for the tracee is restarted after the tracer received the
event for it due to this bug, the tracee will not have sent a second
token on the pipe, which the tracer will notice and fail the test.

The tests also uses SECCOMP_IOCTL_NOTIF_ADDFD with SECCOMP_ADDFD_FLAG_SEND
for the reply, as the fix for the bug has an additional code path
change for handling addfd, which would not be exercised by a simple
SECCOMP_IOCTL_NOTIF_SEND, and it is possible to fix the bug while leaving
the same race intact for the addfd case.

This test is not guaranteed to reproduce the bug on every run, but the
parameters (signal frequency and number of repeated syscalls) have been
chosen so that on my machine this test:

 - takes ~0.8s in the good case (+1s in the failure case), and
 - detects the bug in 999 of 1000 runs.

Signed-off-by: Johannes Nixdorf <johannes@nixdorf.dev>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 130 ++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaaf87b180c8dff2324a02282356fcd..b24d0cbe88b4499a7635c6a075bfc6a660409792 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3547,6 +3547,10 @@ static void signal_handler(int signal)
 		perror("write from signal");
 }
 
+static void signal_handler_nop(int signal)
+{
+}
+
 TEST(user_notification_signal)
 {
 	pid_t pid;
@@ -4819,6 +4823,132 @@ TEST(user_notification_wait_killable_fatal)
 	EXPECT_EQ(SIGTERM, WTERMSIG(status));
 }
 
+/* Ensure signals after the reply do not interrupt */
+TEST(user_notification_wait_killable_after_reply)
+{
+	int i, max_iter = 100000;
+	int listener, status;
+	int pipe_fds[2];
+	pid_t pid;
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret)
+	{
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_notif_syscall(
+		__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER |
+			  SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
+	ASSERT_GE(listener, 0);
+
+	/*
+	 * Used to count invocations. One token is transferred from the child
+	 * to the parent per syscall invocation, the parent tries to take
+	 * one token per successful RECV. If the syscall is restarted after
+	 * RECV the parent will try to get two tokens while the child only
+	 * provided one.
+	 */
+	ASSERT_EQ(pipe(pipe_fds), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct sigaction new_action = {
+			.sa_handler = signal_handler_nop,
+			.sa_flags = SA_RESTART,
+		};
+		struct itimerval timer = {
+			.it_value = { .tv_usec = 1000 },
+			.it_interval = { .tv_usec = 1000 },
+		};
+		char c = 'a';
+
+		close(pipe_fds[0]);
+
+		/* Setup the sigaction with SA_RESTART */
+		if (sigaction(SIGALRM, &new_action, NULL)) {
+			perror("sigaction");
+			exit(1);
+		}
+
+		/*
+		 * Kill with SIGALRM repeatedly, to try to hit the race when
+		 * handling the syscall.
+		 */
+		if (setitimer(ITIMER_REAL, &timer, NULL) < 0)
+			perror("setitimer");
+
+		for (i = 0; i < max_iter; ++i) {
+			int fd;
+
+			/* Send one token per iteration to catch repeats. */
+			if (write(pipe_fds[1], &c, sizeof(c)) != 1) {
+				perror("write");
+				exit(1);
+			}
+
+			fd = syscall(__NR_dup, 0);
+			if (fd < 0) {
+				perror("dup");
+				exit(1);
+			}
+			close(fd);
+		}
+
+		exit(0);
+	}
+
+	close(pipe_fds[1]);
+
+	for (i = 0; i < max_iter; ++i) {
+		struct seccomp_notif req = {};
+		struct seccomp_notif_addfd addfd = {};
+		struct pollfd pfd = {
+			.fd = pipe_fds[0],
+			.events = POLLIN,
+		};
+		char c;
+
+		/*
+		 * Try to receive one token. If it failed, one child syscall
+		 * was restarted after RECV and needed to be handled twice.
+		 */
+		ASSERT_EQ(poll(&pfd, 1, 1000), 1)
+			kill(pid, SIGKILL);
+
+		ASSERT_EQ(read(pipe_fds[0], &c, sizeof(c)), 1)
+			kill(pid, SIGKILL);
+
+		/*
+		 * Get the notification, reply to it as fast as possible to test
+		 * whether the child wrongly skips going into the non-preemptible
+		 * (TASK_KILLABLE) state.
+		 */
+		do
+			ret = ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req);
+		while (ret < 0 && errno == ENOENT); /* Accept interruptions before RECV */
+		ASSERT_EQ(ret, 0)
+			kill(pid, SIGKILL);
+
+		addfd.id = req.id;
+		addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
+		addfd.srcfd = 0;
+		ASSERT_GE(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), 0)
+			kill(pid, SIGKILL);
+	}
+
+	/*
+	 * Wait for the process to exit, and make sure the process terminated
+	 * with a zero exit code..
+	 */
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 struct tsync_vs_thread_leader_args {
 	pthread_t leader;
 };

-- 
2.50.1


