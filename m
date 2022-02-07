Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D414ABF7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382630AbiBGM20 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 07:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382754AbiBGMYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 07:24:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0E2C002B4E;
        Mon,  7 Feb 2022 04:18:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 262E8210FA;
        Mon,  7 Feb 2022 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644236293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WP6Xgo2ws98hPpXKeUU962VqHQ+2ksGNpkLhWTonht4=;
        b=TGINR8F84BeIkQgoA51gSRY3TQArk02/ttVciZuSUTaE915VzbI2t5jJbBPIy7qcRntcI8
        Y+Lgxh5qk9zh+ztIJwYwFqwMHqJpiQIC3MdiFPcJEZbx5mRbfsl2oS0DgxqXR76IRO88o/
        14AYuFnOo3RVUkVt/oFbsuSTrFiN5g8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0472B13BE6;
        Mon,  7 Feb 2022 12:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qGCSAAUOAWLMegAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 07 Feb 2022 12:18:13 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [RFC PATCH 5/6] selftests: Challenge RLIMIT_NPROC in user namespaces
Date:   Mon,  7 Feb 2022 13:17:59 +0100
Message-Id: <20220207121800.5079-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207121800.5079-1-mkoutny@suse.com>
References: <20220207121800.5079-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The services are started in descendant user namepaces, each of them
should honor the RLIMIT_NPROC that's passed during user namespace
creation.

	main [user_ns_0]
	  ` service [user_ns_1]
	    ` worker 1
	    ` worker 2
	    ...
	    ` worker k
	  ...
	  ` service [user_ns_n]
	    ` worker 1
	    ` worker 2
	    ...
	    ` worker k

Test uses explicit synchronization, to make sure original parent's limit
does not interfere with descendants.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 .../selftests/rlimits/rlimits-per-userns.c    | 154 ++++++++++++++----
 1 file changed, 125 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
index 26dc949e93ea..54c1b345e42b 100644
--- a/tools/testing/selftests/rlimits/rlimits-per-userns.c
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns.c
@@ -9,7 +9,9 @@
 #include <sys/resource.h>
 #include <sys/prctl.h>
 #include <sys/stat.h>
+#include <sys/socket.h>
 
+#include <assert.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -21,38 +23,74 @@
 #include <errno.h>
 #include <err.h>
 
-#define NR_CHILDS 2
+#define THE_LIMIT 4
+#define NR_CHILDREN 5
+
+static_assert(NR_CHILDREN >= THE_LIMIT-1, "Need slots for limit-1 children.");
 
 static char *service_prog;
 static uid_t user   = 60000;
 static uid_t group  = 60000;
+static struct rlimit saved_limit;
+
+/* Two uses: main and service */
+static pid_t child[NR_CHILDREN];
+static pid_t pid;
 
 static void setrlimit_nproc(rlim_t n)
 {
-	pid_t pid = getpid();
 	struct rlimit limit = {
 		.rlim_cur = n,
 		.rlim_max = n
 	};
-
-	warnx("(pid=%d): Setting RLIMIT_NPROC=%ld", pid, n);
+	if (getrlimit(RLIMIT_NPROC, &saved_limit) < 0)
+		err(EXIT_FAILURE, "(pid=%d): getrlimit(RLIMIT_NPROC)", pid);
 
 	if (setrlimit(RLIMIT_NPROC, &limit) < 0)
 		err(EXIT_FAILURE, "(pid=%d): setrlimit(RLIMIT_NPROC)", pid);
+
+	warnx("(pid=%d): Set RLIMIT_NPROC=%ld", pid, n);
+}
+
+static void restore_rlimit_nproc(void)
+{
+	if (setrlimit(RLIMIT_NPROC, &saved_limit) < 0)
+		err(EXIT_FAILURE, "(pid=%d): setrlimit(RLIMIT_NPROC, saved)", pid);
+	warnx("(pid=%d) Restored RLIMIT_NPROC", pid);
 }
 
-static pid_t fork_child(void)
+enum msg_sync {
+	UNSHARE,
+	RLIMIT_RESTORE,
+};
+
+static void sync_notify(int fd, enum msg_sync m)
 {
-	pid_t pid = fork();
+	char tmp = m;
+
+	if (write(fd, &tmp, 1) < 0)
+		warnx("(pid=%d): failed sync-write", pid);
+}
 
-	if (pid < 0)
+static void sync_wait(int fd, enum msg_sync m)
+{
+	char tmp;
+
+	if (read(fd, &tmp, 1) < 0)
+		warnx("(pid=%d): failed sync-read", pid);
+}
+
+static pid_t fork_child(int control_fd)
+{
+	pid_t new_pid = fork();
+
+	if (new_pid < 0)
 		err(EXIT_FAILURE, "fork");
 
-	if (pid > 0)
-		return pid;
+	if (new_pid > 0)
+		return new_pid;
 
 	pid = getpid();
-
 	warnx("(pid=%d): New process starting ...", pid);
 
 	if (prctl(PR_SET_PDEATHSIG, SIGKILL) < 0)
@@ -73,6 +111,9 @@ static pid_t fork_child(void)
 	if (unshare(CLONE_NEWUSER) < 0)
 		err(EXIT_FAILURE, "unshare(CLONE_NEWUSER)");
 
+	sync_notify(control_fd, UNSHARE);
+	sync_wait(control_fd, RLIMIT_RESTORE);
+
 	char *const argv[] = { "service", NULL };
 	char *const envp[] = { "I_AM_SERVICE=1", NULL };
 
@@ -82,37 +123,92 @@ static pid_t fork_child(void)
 	err(EXIT_FAILURE, "(pid=%d): execve", pid);
 }
 
+static void run_service(void)
+{
+	size_t i;
+	int ret = EXIT_SUCCESS;
+	struct rlimit limit;
+	char user_ns[PATH_MAX];
+
+	if (getrlimit(RLIMIT_NPROC, &limit) < 0)
+		err(EXIT_FAILURE, "(pid=%d) failed getrlimit", pid);
+	if (readlink("/proc/self/ns/user", user_ns, PATH_MAX) < 0)
+		err(EXIT_FAILURE, "(pid=%d) failed readlink", pid);
+
+	warnx("(pid=%d) Service instance attempts %i children, limit %lu:%lu, ns=%s",
+	      pid, THE_LIMIT, limit.rlim_cur, limit.rlim_max, user_ns);
+
+	/* test rlimit inside the service, effectively THE_LIMIT-1 becaue of service itself */
+	for (i = 0; i < THE_LIMIT; i++) {
+		child[i] = fork();
+		if (child[i] == 0) {
+			/* service child */
+			pause();
+			exit(EXIT_SUCCESS);
+		}
+		if (child[i] < 0) {
+			warnx("(pid=%d) service fork %lu failed, errno = %i", pid, i+1, errno);
+			if (!(i == THE_LIMIT-1 && errno == EAGAIN))
+				ret = EXIT_FAILURE;
+		} else if (i == THE_LIMIT-1) {
+			warnx("(pid=%d) RLIMIT_NPROC not honored", pid);
+			ret = EXIT_FAILURE;
+		}
+	}
+
+	/* service cleanup */
+	for (i = 0; i < THE_LIMIT; i++)
+		if (child[i] > 0)
+			kill(child[i], SIGUSR1);
+
+	for (i = 0; i < THE_LIMIT; i++)
+		if (child[i] > 0)
+			waitpid(child[i], NULL, WNOHANG);
+
+	if (ret)
+		exit(ret);
+	pause();
+}
+
 int main(int argc, char **argv)
 {
 	size_t i;
-	pid_t child[NR_CHILDS];
-	int wstatus[NR_CHILDS];
-	int childs = NR_CHILDS;
-	pid_t pid;
+	int control_fd[NR_CHILDREN];
+	int wstatus[NR_CHILDREN];
+	int children = NR_CHILDREN;
+	int sockets[2];
+
+	pid = getpid();
 
 	if (getenv("I_AM_SERVICE")) {
-		pause();
-		exit(EXIT_SUCCESS);
+		run_service();
+		exit(EXIT_FAILURE);
 	}
 
 	service_prog = argv[0];
-	pid = getpid();
 
 	warnx("(pid=%d) Starting testcase", pid);
 
-	/*
-	 * This rlimit is not a problem for root because it can be exceeded.
-	 */
-	setrlimit_nproc(1);
-
-	for (i = 0; i < NR_CHILDS; i++) {
-		child[i] = fork_child();
+	setrlimit_nproc(THE_LIMIT);
+	for (i = 0; i < NR_CHILDREN; i++) {
+		if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0, sockets) < 0)
+			err(EXIT_FAILURE, "(pid=%d) socketpair failed", pid);
+		control_fd[i] = sockets[0];
+		child[i] = fork_child(sockets[1]);
 		wstatus[i] = 0;
+	}
+
+	for (i = 0; i < NR_CHILDREN; i++)
+		sync_wait(control_fd[i], UNSHARE);
+	restore_rlimit_nproc();
+
+	for (i = 0; i < NR_CHILDREN; i++) {
+		sync_notify(control_fd[i], RLIMIT_RESTORE);
 		usleep(250000);
 	}
 
 	while (1) {
-		for (i = 0; i < NR_CHILDS; i++) {
+		for (i = 0; i < NR_CHILDREN; i++) {
 			if (child[i] <= 0)
 				continue;
 
@@ -126,22 +222,22 @@ int main(int argc, char **argv)
 				warn("(pid=%d): waitpid(%d)", pid, child[i]);
 
 			child[i] *= -1;
-			childs -= 1;
+			children -= 1;
 		}
 
-		if (!childs)
+		if (!children)
 			break;
 
 		usleep(250000);
 
-		for (i = 0; i < NR_CHILDS; i++) {
+		for (i = 0; i < NR_CHILDREN; i++) {
 			if (child[i] <= 0)
 				continue;
 			kill(child[i], SIGUSR1);
 		}
 	}
 
-	for (i = 0; i < NR_CHILDS; i++) {
+	for (i = 0; i < NR_CHILDREN; i++) {
 		if (WIFEXITED(wstatus[i]))
 			warnx("(pid=%d): pid %d exited, status=%d",
 				pid, -child[i], WEXITSTATUS(wstatus[i]));
-- 
2.34.1

