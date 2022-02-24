Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E004C3513
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 19:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiBXSxv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 13:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiBXSxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 13:53:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C350724FBAF;
        Thu, 24 Feb 2022 10:53:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D756210DD;
        Thu, 24 Feb 2022 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645728795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKWMsS6sa9pr4b962HzJmnog8wb1RmSR1H6HXfKUbgY=;
        b=E3BRJPBqn8nfYq324owMV/H/82NSmgxlZzCz+z089TWAjjYemwPFtbqjQUWvlDoQ4fkCJU
        Yvnsnip4+g0r+y2S/Ln5uuttqERu5f5h112lgod34mJS6Oj7v5SXPW3r4nT1s1oi4HyPBi
        pMD9sgY5Yh+0Y1JR84357uJkLqPCe7A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3B9F13B27;
        Thu, 24 Feb 2022 18:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DCATMxrUF2IINQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 24 Feb 2022 18:53:14 +0000
Date:   Thu, 24 Feb 2022 19:53:13 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Security Officers <security@kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>, NeilBrown <neilb@suse.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <linus@torvalds.org>
Subject: Re: [PATCH] ucounts: Fix systemd LimigtNPROC with private users
 regression
Message-ID: <20220224185313.GA28697@blackbody.suse.cz>
References: <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
 <20220215101150.GD21589@blackbody.suse.cz>
 <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
 <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
 <878ru1qcos.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgW8+vmqhx4t+uFiZL==8Ac5VWTqCm_oshA0e47B73qPw@mail.gmail.com>
 <87tucpko7d.fsf@email.froward.int.ebiederm.org>
 <87sfs8jmpz.fsf_-_@email.froward.int.ebiederm.org>
 <202202240826.E31BADF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202202240826.E31BADF@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 24, 2022 at 08:28:41AM -0800, Kees Cook <keescook@chromium.org> wrote:
> I'd really love some kind of selftest that exercises the edge cases; do
> you have your tests in some form that could be converted?

There's the original
tools/testing/selftests/rlimits/rlimits-per-userns.c selftest.

I've been rewriting it to cover more situations, I'm sending it as one
monster patch (I'd need spend more time reordering my commits into some
logical patch order) if anyone wishes to try it.

I've tried it on 5c1ee569660d4a205dced9cb4d0306b907fb7599 + this Eric's
patch.

The test rlimit-per-userns-root passes
- together with that I claim this patch

Reviewed-by: Michal Koutný <mkoutny@suse.com>

The test rlimit-per-userns-nonroot fails. It's similar off-by-one
mistake as was in the fork path, but it's in the do_execveat_common():

        if ((current->flags & PF_NPROC_EXCEEDED) &&
            is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
                retval = -EAGAIN;
                goto out_ret;
        }

(If RLIMIT_NPROC should be strictly honored, setuid+execve should fail
when given uid's ucount is at the limit already.)

Funnily, the original
tools/testing/selftests/rlimits/rlimits-per-userns.c passes thanks to
the off-by-one check even though it should not pass because unshare(2)
is called after setuid(2).

Michal

-- >8 --
From be67d903f1f179f585bf302f6c2d2446f24263d7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Date: Thu, 20 Jan 2022 19:32:54 +0100
Subject: [RFC PATCH] selftests: Rewrite RLIMIT_NPROC checks (in user
 namespaces)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds two test programs:
- rlimit-per-userns-root -- creates user namespaces owned by root,
- rlimit-per-userns-nonroot -- creates user namespaces owned by non-root.

The forking tree:

    main [init_user_ns]
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

Expectations rlimit-per-userns-root:

    n > RLIMIT_NPROC		privileged user can spawn mutliple services in different user namespaces
    (k+1) <= RLIMIT_NPROC	limit is honored within user namespace
    k >= RLIMIT_NPROC-1		separate per-user namespace counters

Expectations rlimit-per-userns-nonroot:

    n <= RLIMIT_NPROC		global RLIMIT_NPROC is honored
    (k+1) <= RLIMIT_NPROC	limit is honored within user namespace

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/rlimits/Makefile      |   6 +-
 .../rlimits/rlimits-per-userns-nonroot.c      |  37 ++
 .../rlimits/rlimits-per-userns-root.c         |  34 ++
 .../selftests/rlimits/rlimits-per-userns.c    | 161 -------
 .../selftests/rlimits/service_common.c        | 400 ++++++++++++++++++
 .../selftests/rlimits/service_common.h        |  24 ++
 6 files changed, 500 insertions(+), 162 deletions(-)
 create mode 100644 tools/testing/selftests/rlimits/rlimits-per-userns-nonroot.c
 create mode 100644 tools/testing/selftests/rlimits/rlimits-per-userns-root.c
 delete mode 100644 tools/testing/selftests/rlimits/rlimits-per-userns.c
 create mode 100644 tools/testing/selftests/rlimits/service_common.c
 create mode 100644 tools/testing/selftests/rlimits/service_common.h

diff --git a/tools/testing/selftests/rlimits/Makefile b/tools/testing/selftests/rlimits/Makefile
index 03aadb406212..8ccb92020206 100644
--- a/tools/testing/selftests/rlimits/Makefile
+++ b/tools/testing/selftests/rlimits/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 CFLAGS += -Wall -O2 -g
-TEST_GEN_PROGS := rlimits-per-userns
+TEST_GEN_PROGS := rlimits-per-userns-root
+TEST_GEN_PROGS += rlimits-per-userns-nonroot
 
 include ../lib.mk
+
+$(OUTPUT)/rlimits-per-userns-root: service_common.c
+$(OUTPUT)/rlimits-per-userns-nonroot: service_common.c
diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns-nonroot.c b/tools/testing/selftests/rlimits/rlimits-per-userns-nonroot.c
new file mode 100644
index 000000000000..ccf021769f88
--- /dev/null
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns-nonroot.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
+ * Author: Michal Koutný <mkoutny@suse.com>
+ */
+#include <err.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "service_common.h"
+
+int main(int argc, char **argv)
+{
+	struct services_ctx *ctx;
+	pid = getpid();
+
+	if (getenv(ENV_PARAM))
+		return run_service(atoi(getenv(ENV_PARAM)));
+
+	if (getuid() > 0)
+		errx(KSFT_SKIP, "This selftest must start as (global) root user.");
+
+	warnx("(pid=%d) Starting testcase", pid);
+
+	ctx = start_services(argv[0], UM_UNSHARE);
+	stop_services(ctx);
+
+	if (count_services(ctx) > THE_LIMIT)
+		errx(KSFT_FAIL, "(pid=%d): Test failed, exec'd services > RLIMIT_NPROC", pid);
+
+	if (check_services(ctx) < count_services(ctx))
+		errx(KSFT_FAIL, "(pid=%d): Test failed, failed services", pid);
+
+	warnx("(pid=%d): Test passed", pid);
+	exit(KSFT_PASS);
+}
diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns-root.c b/tools/testing/selftests/rlimits/rlimits-per-userns-root.c
new file mode 100644
index 000000000000..3bf0149ac93d
--- /dev/null
+++ b/tools/testing/selftests/rlimits/rlimits-per-userns-root.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
+ * Author: Michal Koutný <mkoutny@suse.com>
+ */
+#include <err.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "service_common.h"
+
+int main(int argc, char **argv)
+{
+	struct services_ctx *ctx;
+	pid = getpid();
+
+	if (getenv(ENV_PARAM))
+		return run_service(atoi(getenv(ENV_PARAM)));
+
+	if (getuid() > 0)
+		errx(KSFT_SKIP, "This selftest must start as (global) root user.");
+
+	warnx("(pid=%d) Starting testcase", pid);
+
+	ctx = start_services(argv[0], UM_CLONE_NEWUSER);
+	stop_services(ctx);
+
+	if (check_services(ctx) != NR_SERVICES)
+		errx(KSFT_FAIL, "(pid=%d): Test failed, unexpected terminations", pid);
+
+	warnx("(pid=%d): Test passed", pid);
+	exit(KSFT_PASS);
+}
diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
deleted file mode 100644
index 26dc949e93ea..000000000000
--- a/tools/testing/selftests/rlimits/rlimits-per-userns.c
+++ /dev/null
@@ -1,161 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
- */
-#define _GNU_SOURCE
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <sys/prctl.h>
-#include <sys/stat.h>
-
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <sched.h>
-#include <signal.h>
-#include <limits.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <err.h>
-
-#define NR_CHILDS 2
-
-static char *service_prog;
-static uid_t user   = 60000;
-static uid_t group  = 60000;
-
-static void setrlimit_nproc(rlim_t n)
-{
-	pid_t pid = getpid();
-	struct rlimit limit = {
-		.rlim_cur = n,
-		.rlim_max = n
-	};
-
-	warnx("(pid=%d): Setting RLIMIT_NPROC=%ld", pid, n);
-
-	if (setrlimit(RLIMIT_NPROC, &limit) < 0)
-		err(EXIT_FAILURE, "(pid=%d): setrlimit(RLIMIT_NPROC)", pid);
-}
-
-static pid_t fork_child(void)
-{
-	pid_t pid = fork();
-
-	if (pid < 0)
-		err(EXIT_FAILURE, "fork");
-
-	if (pid > 0)
-		return pid;
-
-	pid = getpid();
-
-	warnx("(pid=%d): New process starting ...", pid);
-
-	if (prctl(PR_SET_PDEATHSIG, SIGKILL) < 0)
-		err(EXIT_FAILURE, "(pid=%d): prctl(PR_SET_PDEATHSIG)", pid);
-
-	signal(SIGUSR1, SIG_DFL);
-
-	warnx("(pid=%d): Changing to uid=%d, gid=%d", pid, user, group);
-
-	if (setgid(group) < 0)
-		err(EXIT_FAILURE, "(pid=%d): setgid(%d)", pid, group);
-	if (setuid(user) < 0)
-		err(EXIT_FAILURE, "(pid=%d): setuid(%d)", pid, user);
-
-	warnx("(pid=%d): Service running ...", pid);
-
-	warnx("(pid=%d): Unshare user namespace", pid);
-	if (unshare(CLONE_NEWUSER) < 0)
-		err(EXIT_FAILURE, "unshare(CLONE_NEWUSER)");
-
-	char *const argv[] = { "service", NULL };
-	char *const envp[] = { "I_AM_SERVICE=1", NULL };
-
-	warnx("(pid=%d): Executing real service ...", pid);
-
-	execve(service_prog, argv, envp);
-	err(EXIT_FAILURE, "(pid=%d): execve", pid);
-}
-
-int main(int argc, char **argv)
-{
-	size_t i;
-	pid_t child[NR_CHILDS];
-	int wstatus[NR_CHILDS];
-	int childs = NR_CHILDS;
-	pid_t pid;
-
-	if (getenv("I_AM_SERVICE")) {
-		pause();
-		exit(EXIT_SUCCESS);
-	}
-
-	service_prog = argv[0];
-	pid = getpid();
-
-	warnx("(pid=%d) Starting testcase", pid);
-
-	/*
-	 * This rlimit is not a problem for root because it can be exceeded.
-	 */
-	setrlimit_nproc(1);
-
-	for (i = 0; i < NR_CHILDS; i++) {
-		child[i] = fork_child();
-		wstatus[i] = 0;
-		usleep(250000);
-	}
-
-	while (1) {
-		for (i = 0; i < NR_CHILDS; i++) {
-			if (child[i] <= 0)
-				continue;
-
-			errno = 0;
-			pid_t ret = waitpid(child[i], &wstatus[i], WNOHANG);
-
-			if (!ret || (!WIFEXITED(wstatus[i]) && !WIFSIGNALED(wstatus[i])))
-				continue;
-
-			if (ret < 0 && errno != ECHILD)
-				warn("(pid=%d): waitpid(%d)", pid, child[i]);
-
-			child[i] *= -1;
-			childs -= 1;
-		}
-
-		if (!childs)
-			break;
-
-		usleep(250000);
-
-		for (i = 0; i < NR_CHILDS; i++) {
-			if (child[i] <= 0)
-				continue;
-			kill(child[i], SIGUSR1);
-		}
-	}
-
-	for (i = 0; i < NR_CHILDS; i++) {
-		if (WIFEXITED(wstatus[i]))
-			warnx("(pid=%d): pid %d exited, status=%d",
-				pid, -child[i], WEXITSTATUS(wstatus[i]));
-		else if (WIFSIGNALED(wstatus[i]))
-			warnx("(pid=%d): pid %d killed by signal %d",
-				pid, -child[i], WTERMSIG(wstatus[i]));
-
-		if (WIFSIGNALED(wstatus[i]) && WTERMSIG(wstatus[i]) == SIGUSR1)
-			continue;
-
-		warnx("(pid=%d): Test failed", pid);
-		exit(EXIT_FAILURE);
-	}
-
-	warnx("(pid=%d): Test passed", pid);
-	exit(EXIT_SUCCESS);
-}
diff --git a/tools/testing/selftests/rlimits/service_common.c b/tools/testing/selftests/rlimits/service_common.c
new file mode 100644
index 000000000000..043c59828a03
--- /dev/null
+++ b/tools/testing/selftests/rlimits/service_common.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Alexey Gladkov <gladkov.alexey@gmail.com>
+ * Author: Michal Koutný <mkoutny@suse.com>
+ */
+/*
+ * The forking tree:
+ *
+ *     main [init_user_ns]
+ *     ` service [user_ns_1]
+ *       ` worker 1
+ *       ` worker 2
+ *       ...
+ *       ` worker k
+ *     ...
+ *     ` service [user_ns_n]
+ *       ` worker 1
+ *       ` worker 2
+ *       ...
+ *       ` worker k
+ *
+ * Sequence (synchronization) diagram:
+ *   main			service
+ *   ----			-------
+ *   setrlimit()
+ *   service=clone([CLONE_NEWUSER])
+ *   define_maps()
+ *   	  	MAP_DEFINE ->
+ *   	  			setuid()
+ *   	  			[unshare(CLONE_NEWUSER)]
+ *   		<- UNSHARE
+ *   rlimit_restore()
+ *   		RLIMIT_RESTORE ->
+ *   				execve()
+ *   		POST_EXEC ->
+ *
+ * Expectations UM_UNSHARE:
+ *
+ *     n <= RLIMIT_NPROC	global RLIMIT_NPROC is honored
+ *     (k+1) <= RLIMIT_NPROC	limit is honored within user namespace
+ *
+ * Expectations UM_CLONE_NEWUSER:
+ *
+ *     n > RLIMIT_NPROC		privileged user can spawn mutliple services in different user namespaces
+ *     k >= RLIMIT_NPROC-1	separate per-user namespace counters
+ *     (k+1) <= RLIMIT_NPROC	limit is honored within user namespace
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/resource.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "service_common.h"
+
+#define STACK_SIZE (2 * (1<<20))
+#define SERVICE_RUNTIME	250000 /* μs */
+
+static_assert(NR_SERVICES > THE_LIMIT, "Services must exceed THE_LIMIT for effective test.");
+static_assert(NR_WORKERS > THE_LIMIT-1, "Need enough workers to challenge THE_LIIMT.");
+
+static struct services_ctx {
+	int control_fd[NR_SERVICES];
+	pid_t child[NR_SERVICES];
+	int wstatus[NR_SERVICES];
+	int fork_ed;
+	int exec_ed;
+} services_ctx;
+
+static uid_t user   = 60000;
+static uid_t group  = 60000;
+static struct rlimit saved_limit;
+
+static struct {
+	int control_fd;
+	const char *pathname;
+	enum userns_mode um;
+} child_args;
+
+pid_t pid;
+
+static void setrlimit_nproc(rlim_t n)
+{
+	struct rlimit limit = {
+		.rlim_cur = n,
+		.rlim_max = n
+	};
+	if (getrlimit(RLIMIT_NPROC, &saved_limit) < 0)
+		err(KSFT_FAIL, "(pid=%d): getrlimit(RLIMIT_NPROC)", pid);
+
+	if (setrlimit(RLIMIT_NPROC, &limit) < 0)
+		err(KSFT_FAIL, "(pid=%d): setrlimit(RLIMIT_NPROC)", pid);
+
+	warnx("(pid=%d): Set RLIMIT_NPROC=%ld", pid, n);
+}
+
+static void restore_rlimit_nproc(void)
+{
+	if (setrlimit(RLIMIT_NPROC, &saved_limit) < 0)
+		err(KSFT_FAIL, "(pid=%d): setrlimit(RLIMIT_NPROC, saved)", pid);
+	warnx("(pid=%d) Restored RLIMIT_NPROC", pid);
+}
+
+enum msg_sync {
+	MAP_DEFINE,
+	UNSHARE,
+	RLIMIT_RESTORE,
+	POST_EXEC,
+};
+
+static int _sync_notify(int fd, enum msg_sync m)
+{
+	char tmp = m;
+
+	return write(fd, &tmp, 1);
+}
+static void sync_notify(int fd, enum msg_sync m)
+{
+	if (_sync_notify(fd, m) < 0)
+		warnx("(pid=%d): failed sync-write", pid);
+}
+
+static void sync_wait(int fd, enum msg_sync m)
+{
+	char tmp;
+
+	if (read(fd, &tmp, 1) < 0)
+		warn("(pid=%d): failed sync-read", pid);
+	else if (tmp != m)
+		warnx("(pid=%d): unexpected sync", pid);
+}
+
+static int define_maps(pid_t child_pid, enum userns_mode um)
+{
+	FILE *f;
+	char filename[PATH_MAX];
+
+	if (um != UM_CLONE_NEWUSER)
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
+
+static int setup_and_exec(void *arg)
+{
+	int control_fd = child_args.control_fd;
+
+	pid = getpid();
+	warnx("(pid=%d): New process starting ...", pid);
+
+	signal(SIGUSR1, SIG_DFL);
+
+	sync_wait(control_fd, MAP_DEFINE);
+	warnx("(pid=%d): Changing to uid=%d, gid=%d", pid, user, group);
+
+	if (setgid(group) < 0)
+		err(EXIT_FAILURE, "(pid=%d): setgid(%d)", pid, group);
+	if (setuid(user) < 0)
+		err(EXIT_FAILURE, "(pid=%d): setuid(%d)", pid, user);
+
+	warnx("(pid=%d): Service running ...", pid);
+
+	if (child_args.um == UM_UNSHARE) {
+		warnx("(pid=%d): Unshare user namespace", pid);
+		if (unshare(CLONE_NEWUSER) < 0)
+			err(EXIT_FAILURE, "unshare(CLONE_NEWUSER)");
+	}
+
+	sync_notify(control_fd, UNSHARE);
+	sync_wait(control_fd, RLIMIT_RESTORE);
+
+	char *param = NULL;
+	asprintf(&param, ENV_PARAM "=%i", child_args.um);
+	char *const argv[] = { "service", NULL };
+	char *const envp[] = { param, NULL };
+
+	warnx("(pid=%d): Executing real service ...", pid);
+
+	execve(child_args.pathname, argv, envp);
+
+	/* stay around until parent notifies/signals */
+	warn("(pid=%d): execve failed", pid);
+	sync_wait(control_fd, POST_EXEC);
+	pause();
+	return 0;
+}
+
+static pid_t start_child(const char *pathname, int control_fd, enum userns_mode um)
+{
+	char *stack = malloc(STACK_SIZE);
+	int flags = um == UM_CLONE_NEWUSER ? CLONE_NEWUSER : 0;
+	pid_t new_pid;
+
+	/* Pass via global variable to child */
+	child_args.control_fd = control_fd;
+	child_args.pathname = pathname;
+	child_args.um = um;
+
+	new_pid = clone(setup_and_exec, stack+STACK_SIZE-1, flags, NULL);
+
+	free(stack);
+	close(control_fd);
+	return new_pid;
+}
+
+static void dump_context(size_t n_workers)
+{
+	struct rlimit limit;
+	char user_ns[PATH_MAX];
+	ssize_t len;
+
+	if (getrlimit(RLIMIT_NPROC, &limit) < 0)
+		err(EXIT_FAILURE, "(pid=%d) failed getrlimit", pid);
+	if ((len = readlink("/proc/self/ns/user", user_ns, PATH_MAX)) < 0)
+		err(EXIT_FAILURE, "(pid=%d) failed readlink", pid);
+	user_ns[len] = 0;
+
+	warnx("(pid=%d) Service instance attempts %lu workers, limit %lu:%lu, ns=%s",
+	      pid, n_workers, limit.rlim_cur, limit.rlim_max, user_ns);
+}
+
+int run_service(enum userns_mode um)
+{
+	size_t i;
+	pid_t worker[NR_WORKERS];
+	int ret = EXIT_SUCCESS;
+
+	dump_context(NR_WORKERS);
+
+	/* test RLIMIT_NPROC inside the service, last worker should fail because of service itself */
+	for (i = 0; i < NR_WORKERS; i++) {
+		worker[i] = fork();
+		if (worker[i] == 0) {
+			/* service worker */
+			pause();
+			exit(EXIT_SUCCESS);
+		}
+		if (worker[i] < 0) {
+			warn("(pid=%d) service fork %lu failed", pid, i+1);
+			if (um == UM_CLONE_NEWUSER && !(i >= (THE_LIMIT-1) && errno == EAGAIN))
+				ret = EXIT_FAILURE;
+		} else if (i >= (THE_LIMIT-1)) {
+			warnx("(pid=%d) RLIMIT_NPROC not honored", pid);
+			ret = EXIT_FAILURE;
+		}
+	}
+
+	/* service cleanup */
+	for (i = 0; i < NR_WORKERS; i++)
+		if (worker[i] > 0)
+			kill(worker[i], SIGUSR1);
+
+	for (i = 0; i < NR_WORKERS; i++)
+		if (worker[i] > 0)
+			waitpid(worker[i], NULL, WNOHANG);
+
+	if (ret) {
+		warnx("(pid=%d) service failed, ret=%i", pid, ret);
+		return ret;
+	}
+	/* we must get here before SERVICE_RUNTIME elapses */
+	pause();
+	return EXIT_FAILURE;
+}
+
+struct services_ctx *start_services(const char *pathname, enum userns_mode um)
+{
+	size_t i;
+	int sockets[2];
+	struct services_ctx *ctx = &services_ctx;
+
+	signal(SIGPIPE, SIG_IGN);
+	setrlimit_nproc(THE_LIMIT);
+	ctx->fork_ed = 0;
+	ctx->exec_ed = 0;
+	for (i = 0; i < NR_SERVICES; i++) {
+		if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0, sockets) < 0)
+			err(KSFT_FAIL, "(pid=%d) socketpair failed", pid);
+		ctx->control_fd[i] = sockets[0];
+		ctx->child[i] = start_child(pathname, sockets[1], um);
+		ctx->wstatus[i] = 0;
+		if (ctx->child[i] < 0)
+			continue;
+		ctx->fork_ed++;
+
+		if (define_maps(ctx->child[i], um) < 0)
+			err(KSFT_FAIL, "(pid=%d) user_ns maps definition failed", pid);
+		sync_notify(ctx->control_fd[i], MAP_DEFINE);
+	}
+
+	for (i = 0; i < NR_SERVICES; i++)
+		sync_wait(ctx->control_fd[i], UNSHARE);
+	restore_rlimit_nproc();
+
+	for (i = 0; i < NR_SERVICES; i++) {
+		sync_notify(ctx->control_fd[i], RLIMIT_RESTORE);
+	}
+
+	return ctx;
+}
+
+void stop_services(struct services_ctx *ctx)
+{
+	size_t i;
+	int children = ctx->fork_ed;
+
+	/* Well behaved service would pause() and wait for our SIGUSR1, if it
+	 * failed check it early.
+	 */
+	while (1) {
+		for (i = 0; i < NR_SERVICES; i++) {
+			if (ctx->child[i] <= 0)
+				continue;
+
+			errno = 0;
+			pid_t ret = waitpid(ctx->child[i], &ctx->wstatus[i], WNOHANG | __WALL);
+
+			if (!ret)
+				continue;
+
+			if (ret < 0 && errno != ECHILD)
+				warn("(pid=%d): waitpid(%d)", pid, ctx->child[i]);
+
+			ctx->child[i] *= -1;
+			children -= 1;
+		}
+
+		if (!children)
+			break;
+
+		usleep(SERVICE_RUNTIME);
+
+		for (i = 0; i < NR_SERVICES; i++) {
+			if (ctx->child[i] <= 0)
+				continue;
+			if (_sync_notify(ctx->control_fd[i], POST_EXEC) < 0 &&
+			    (errno == EPIPE || errno == ECONNREFUSED))
+				ctx->exec_ed++;
+			close(ctx->control_fd[i]);
+			kill(ctx->child[i], SIGUSR1);
+		}
+	}
+
+	warnx("(pid=%d): stats: fork_ed=%i exec_ed=%i", pid, ctx->fork_ed, ctx->exec_ed);
+}
+
+int count_services(struct services_ctx *ctx)
+{
+	return ctx->exec_ed;
+}
+
+int check_services(struct services_ctx *ctx)
+{
+	size_t i;
+	int correct = 0;
+	
+	for (i = 0; i < NR_SERVICES; i++) {
+		if (WIFEXITED(ctx->wstatus[i]))
+			warnx("(pid=%d): pid %d exited, status=%d",
+				pid, -ctx->child[i], WEXITSTATUS(ctx->wstatus[i]));
+		else if (WIFSIGNALED(ctx->wstatus[i]))
+			warnx("(pid=%d): pid %d killed by signal %d",
+				pid, -ctx->child[i], WTERMSIG(ctx->wstatus[i]));
+
+		/* The only acceptable service termination */
+		if (WIFSIGNALED(ctx->wstatus[i]) && WTERMSIG(ctx->wstatus[i]) == SIGUSR1)
+			correct++;
+	}
+
+	return correct;
+}
+
+
diff --git a/tools/testing/selftests/rlimits/service_common.h b/tools/testing/selftests/rlimits/service_common.h
new file mode 100644
index 000000000000..4a3cd929d865
--- /dev/null
+++ b/tools/testing/selftests/rlimits/service_common.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <sys/types.h>
+
+#define THE_LIMIT 4
+#define NR_SERVICES 5
+#define NR_WORKERS 5
+
+#define ENV_PARAM "I_AM_SERVICE"
+
+enum userns_mode {
+	UM_UNSHARE,		/* setrlimit,clone(0),setuid,unshare,execve */
+	UM_CLONE_NEWUSER,	/* setrlimit,clone(NEWUSER),setuid,execve */
+};
+
+struct services_ctx;
+
+/* Cache current pid */
+extern pid_t pid;
+
+int run_service(enum userns_mode um);
+struct services_ctx *start_services(const char *pathname, enum userns_mode um);
+void stop_services(struct services_ctx *ctx);
+int count_services(struct services_ctx *ctx);
+int check_services(struct services_ctx *ctx);
-- 
2.34.1

