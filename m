Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746524ABF97
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiBGN1k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 08:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445599AbiBGMmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 07:42:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D177E033DB1;
        Mon,  7 Feb 2022 04:33:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 46FD41F38F;
        Mon,  7 Feb 2022 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644236293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQBjXVV6nPDxhegxhJuo1rX8QnvdXvXCHXEHajMjE/k=;
        b=F7vAbavv5+DmmcYqc+EmNYdMceHNSmxYSAN9d0tSWb0chC3D3hfAkjuJXtTsRP9K1btMvr
        A8jT8Uy54seXjkBVVreXC3HuvigVWh/RwAFUv+ReMCNKF7QqlpMsEl79kgMbBBhrkEMZVk
        oeL3Pc2ZMCI/XWD7PFQ/NPciWtTEzcI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2581413BBC;
        Mon,  7 Feb 2022 12:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wMqjCAUOAWLMegAAMHmgww
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
Subject: [RFC PATCH 6/6] selftests: Test RLIMIT_NPROC in clone-created user namespaces
Date:   Mon,  7 Feb 2022 13:18:00 +0100
Message-Id: <20220207121800.5079-7-mkoutny@suse.com>
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

Verify RLIMIT_NPROC observance in user namespaces also in the
clone(CLONE_NEWUSER) path.
Note the such a user_ns is created by the privileged user.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 .../selftests/rlimits/rlimits-per-userns.c    | 141 +++++++++++++-----
 1 file changed, 101 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
index 54c1b345e42b..46f4cff36b30 100644
--- a/tools/testing/selftests/rlimits/rlimits-per-userns.c
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
+ * Author: Michal Koutný <mkoutny@suse.com>
  */
 #define _GNU_SOURCE
 #include <sys/types.h>
@@ -25,16 +26,25 @@
 
 #define THE_LIMIT 4
 #define NR_CHILDREN 5
+#define STACK_SIZE (2 * (1<<20))
 
-static_assert(NR_CHILDREN >= THE_LIMIT-1, "Need slots for limit-1 children.");
+static_assert(NR_CHILDREN >= THE_LIMIT-1, "Need slots for THE_LIMIT-1 children.");
 
-static char *service_prog;
 static uid_t user   = 60000;
 static uid_t group  = 60000;
 static struct rlimit saved_limit;
 
-/* Two uses: main and service */
-static pid_t child[NR_CHILDREN];
+enum userns_mode {
+	UM_UNSHARE,		/* setrlimit,clone(0),setuid,unshare,execve */
+	UM_CLONE_NEWUSER,	/* setrlimit,clone(NEWUSER),setuid,execve */
+};
+static struct {
+	int control_fd;
+	char *pathname;
+	enum userns_mode mode;
+} child_args;
+
+/* Cache current pid */
 static pid_t pid;
 
 static void setrlimit_nproc(rlim_t n)
@@ -60,6 +70,7 @@ static void restore_rlimit_nproc(void)
 }
 
 enum msg_sync {
+	MAP_DEFINE,
 	UNSHARE,
 	RLIMIT_RESTORE,
 };
@@ -80,15 +91,32 @@ static void sync_wait(int fd, enum msg_sync m)
 		warnx("(pid=%d): failed sync-read", pid);
 }
 
-static pid_t fork_child(int control_fd)
+static int define_maps(pid_t child_pid)
 {
-	pid_t new_pid = fork();
+	FILE *f;
+	char filename[PATH_MAX];
 
-	if (new_pid < 0)
-		err(EXIT_FAILURE, "fork");
+	if (child_args.mode != UM_CLONE_NEWUSER)
+		return 0;
+
+	snprintf(filename, PATH_MAX, "/proc/%i/uid_map", child_pid);
+	f = fopen(filename, "w");
+	if (fprintf(f, "%i %i 1\n", user, user) < 0)
+		return -1;
+	fclose(f);
+
+	snprintf(filename, PATH_MAX, "/proc/%i/gid_map", child_pid);
+	f = fopen(filename, "w");
+	if (fprintf(f, "%i %i 1\n", group, group) < 0)
+		return -1;
+	fclose(f);
+
+	return 0;
+}
 
-	if (new_pid > 0)
-		return new_pid;
+static int setup_and_exec(void *arg)
+{
+	int control_fd = child_args.control_fd;
 
 	pid = getpid();
 	warnx("(pid=%d): New process starting ...", pid);
@@ -98,6 +126,7 @@ static pid_t fork_child(int control_fd)
 
 	signal(SIGUSR1, SIG_DFL);
 
+	sync_wait(control_fd, RLIMIT_RESTORE);
 	warnx("(pid=%d): Changing to uid=%d, gid=%d", pid, user, group);
 
 	if (setgid(group) < 0)
@@ -107,9 +136,11 @@ static pid_t fork_child(int control_fd)
 
 	warnx("(pid=%d): Service running ...", pid);
 
-	warnx("(pid=%d): Unshare user namespace", pid);
-	if (unshare(CLONE_NEWUSER) < 0)
-		err(EXIT_FAILURE, "unshare(CLONE_NEWUSER)");
+	if (child_args.mode == UM_UNSHARE) {
+		warnx("(pid=%d): Unshare user namespace", pid);
+		if (unshare(CLONE_NEWUSER) < 0)
+			err(EXIT_FAILURE, "unshare(CLONE_NEWUSER)");
+	}
 
 	sync_notify(control_fd, UNSHARE);
 	sync_wait(control_fd, RLIMIT_RESTORE);
@@ -119,14 +150,30 @@ static pid_t fork_child(int control_fd)
 
 	warnx("(pid=%d): Executing real service ...", pid);
 
-	execve(service_prog, argv, envp);
+	execve(child_args.pathname, argv, envp);
 	err(EXIT_FAILURE, "(pid=%d): execve", pid);
 }
 
-static void run_service(void)
+static pid_t start_child(char *pathname, int control_fd)
+{
+	char *stack = malloc(STACK_SIZE);
+	int flags = child_args.mode == UM_CLONE_NEWUSER ? CLONE_NEWUSER : 0;
+	pid_t new_pid;
+
+	child_args.control_fd = control_fd;
+	child_args.pathname = pathname;
+
+	new_pid = clone(setup_and_exec, stack+STACK_SIZE-1, flags, NULL);
+	if (new_pid < 0)
+		err(EXIT_FAILURE, "clone");
+
+	free(stack);
+	close(control_fd);
+	return new_pid;
+}
+
+static void dump_context(size_t n_workers)
 {
-	size_t i;
-	int ret = EXIT_SUCCESS;
 	struct rlimit limit;
 	char user_ns[PATH_MAX];
 
@@ -135,44 +182,55 @@ static void run_service(void)
 	if (readlink("/proc/self/ns/user", user_ns, PATH_MAX) < 0)
 		err(EXIT_FAILURE, "(pid=%d) failed readlink", pid);
 
-	warnx("(pid=%d) Service instance attempts %i children, limit %lu:%lu, ns=%s",
-	      pid, THE_LIMIT, limit.rlim_cur, limit.rlim_max, user_ns);
+	warnx("(pid=%d) Service instance attempts %lu workers, limit %lu:%lu, ns=%s",
+	      pid, n_workers, limit.rlim_cur, limit.rlim_max, user_ns);
+}
+
+static int run_service(void)
+{
+	size_t i, n_workers = THE_LIMIT;
+	pid_t worker[NR_CHILDREN];
+	int ret = EXIT_SUCCESS;
 
-	/* test rlimit inside the service, effectively THE_LIMIT-1 becaue of service itself */
-	for (i = 0; i < THE_LIMIT; i++) {
-		child[i] = fork();
-		if (child[i] == 0) {
-			/* service child */
+	dump_context(n_workers);
+
+	/* test rlimit inside the service, last worker should fail because of service itself */
+	for (i = 0; i < n_workers; i++) {
+		worker[i] = fork();
+		if (worker[i] == 0) {
+			/* service worker */
 			pause();
 			exit(EXIT_SUCCESS);
 		}
-		if (child[i] < 0) {
+		if (worker[i] < 0) {
 			warnx("(pid=%d) service fork %lu failed, errno = %i", pid, i+1, errno);
-			if (!(i == THE_LIMIT-1 && errno == EAGAIN))
+			if (!(i == n_workers-1 && errno == EAGAIN))
 				ret = EXIT_FAILURE;
-		} else if (i == THE_LIMIT-1) {
+		} else if (i == n_workers-1) {
 			warnx("(pid=%d) RLIMIT_NPROC not honored", pid);
 			ret = EXIT_FAILURE;
 		}
 	}
 
 	/* service cleanup */
-	for (i = 0; i < THE_LIMIT; i++)
-		if (child[i] > 0)
-			kill(child[i], SIGUSR1);
+	for (i = 0; i < n_workers; i++)
+		if (worker[i] > 0)
+			kill(worker[i], SIGUSR1);
 
-	for (i = 0; i < THE_LIMIT; i++)
-		if (child[i] > 0)
-			waitpid(child[i], NULL, WNOHANG);
+	for (i = 0; i < n_workers; i++)
+		if (worker[i] > 0)
+			waitpid(worker[i], NULL, WNOHANG);
 
 	if (ret)
-		exit(ret);
+		return ret;
 	pause();
+	return EXIT_FAILURE;
 }
 
 int main(int argc, char **argv)
 {
 	size_t i;
+	pid_t child[NR_CHILDREN];
 	int control_fd[NR_CHILDREN];
 	int wstatus[NR_CHILDREN];
 	int children = NR_CHILDREN;
@@ -180,12 +238,11 @@ int main(int argc, char **argv)
 
 	pid = getpid();
 
-	if (getenv("I_AM_SERVICE")) {
-		run_service();
-		exit(EXIT_FAILURE);
-	}
+	if (getenv("I_AM_SERVICE"))
+		return run_service();
 
-	service_prog = argv[0];
+	if (argc > 1 && *argv[1] == 'c')
+		child_args.mode = UM_CLONE_NEWUSER;
 
 	warnx("(pid=%d) Starting testcase", pid);
 
@@ -194,8 +251,12 @@ int main(int argc, char **argv)
 		if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0, sockets) < 0)
 			err(EXIT_FAILURE, "(pid=%d) socketpair failed", pid);
 		control_fd[i] = sockets[0];
-		child[i] = fork_child(sockets[1]);
+		child[i] = start_child(argv[0], sockets[1]);
 		wstatus[i] = 0;
+
+		if (define_maps(child[i]) < 0)
+			err(EXIT_FAILURE, "(pid=%d) user_ns maps definition failed", pid);
+		sync_notify(control_fd[i], MAP_DEFINE);
 	}
 
 	for (i = 0; i < NR_CHILDREN; i++)
-- 
2.34.1

