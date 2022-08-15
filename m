Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8166E592F51
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiHOND5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiHONDz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:03:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E6140B6
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9078FB80D2C
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843A4C433D7;
        Mon, 15 Aug 2022 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660568631;
        bh=Ce8Klt/kEtuagMyITMGPYOUI62td+08Sr8sOiA8wulY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjrvtjDWyD37dPq5cbie2Jj4uX0cBTRcXXBt/FjwTWBz1YeXfUqnRbE3w/D9nS90u
         MDhntl0aPGKJg8nO0I+9Z2ceOh5nn6sb2bDr7Sm7PnFRSESMC6spXoeZ/hynxALNcP
         5fzSNO6J8xkK1E8SrJkEn5esbQzFZw7p5pjOHga4WN7AwfsJp2GdIxJEZxCiIBCXqz
         cNoXrqjIFD2yZTj5rOqtYd7uNk4xNq5wYPE+zaWjU+p7dCLZN9J2hQ5QtZdwb6EHVk
         MptzBV/jLgYLDoyhqBViBjtJzE5SglCT9S/Zzug2fmvrB0N2F5zuJRuMdkPU/KVtkt
         NeyUVNtSYuqgg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/4] kselftest/arm64: kselftest harness for FP stress tests
Date:   Mon, 15 Aug 2022 14:02:02 +0100
Message-Id: <20220815130202.204725-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815130202.204725-1-broonie@kernel.org>
References: <20220815130202.204725-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16312; i=broonie@kernel.org; h=from:subject; bh=Ce8Klt/kEtuagMyITMGPYOUI62td+08Sr8sOiA8wulY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kPJHEWZOwP5UeITgvIjEf8sVpTxLHPltGdYUMaf UU8qB7iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpDyQAKCRAk1otyXVSH0BJbB/ 9h354ac+054CjfEMU2aEU6BVu8EzLOdZcWaeLlxgNWkk+XbgZcenf8UES864+T/qfhG+pJvLbXrkkW lcuriwLLJe6z60m0tslmNDCLvC3YQ0YfcP+kX7Pft2JrgVqYJQ8k136TlJ+ezGpUW3UpJUSapPuUOK CL0AvuKlxZK3gjIiH/67KUt4xCh2plXiG7Twp8SsA+9PrDwc5UDqnUU4L/5NpR55kBqzj/nLZZd7Pg lgFN/POrmGTzjlFpm6XZrzXVu+IUNPsKzoXwV0sAWA4OfcR+WxSj1C43iZZYfh27ayLiHA1Tec5SKo 6D2byUTB/Sq2TCMJoDgzM9Re60mPTV
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the stress test programs for floating point context switching are
run by hand, there are extremely simplistic harnesses which run some copies
of each test individually but they are not integrated into kselftest and
with SVE and SME they only run with whatever vector length the process has
by default. This is hassle when running the tests and means that they're
not being run at all by CI systems picking up kselftest.

In order to improve our coverage and provide a more convenient interface
provide a harness program which starts enough stress test programs up to
cause context switching and runs them for a set period. If only FPSIMD is
available in the system we start two copies of the FPSIMD stress test per
CPU, otherwise we start one copy of the FPSIMD and then start the SVE,
streaming SVE and ZA tests once per CPU for each available VL they have
to run on.  We then run for a set period monitoring for any errors
reported by the test programs before cleanly terminating them.

In order to provide additional coverage of signal handling and some extra
noise in the scheduling we send a SIGUSR2 to the stress tests once a
second, the tests will count the number of signals they get.

Since kselftest is generally expected to run quickly we by default only run
for ten seconds. This is enough to show if there is anything cripplingly
wrong but not exactly a thorough soak test, for interactive and more
focused use a command line option -t N is provided which overrides the
length of time to run for (specified in seconds) and if 0 is specified then
there is no timeout and the test must be manually terminated. The timeout
is counted in seconds with no output, this is done to account for the
potentially slow startup time for the test programs on virtual platforms
which tend to struggle during startup as they are both slow and tend to
support a wide range of vector lengths.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore  |   1 +
 tools/testing/selftests/arm64/fp/Makefile    |   5 +-
 tools/testing/selftests/arm64/fp/fp-stress.c | 532 +++++++++++++++++++
 3 files changed, 537 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/fp-stress.c

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index ea947af63882..df79d29664a1 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -1,4 +1,5 @@
 fp-pidbench
+fp-stress
 fpsimd-test
 rdvl-sme
 rdvl-sve
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index a7c2286bf65b..36db61358ed5 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -5,7 +5,10 @@ top_srcdir = $(realpath ../../../../../)
 
 CFLAGS += -I$(top_srcdir)/usr/include/
 
-TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg za-fork za-ptrace
+TEST_GEN_PROGS := fp-stress \
+	sve-ptrace sve-probe-vls \
+	vec-syscfg \
+	za-fork za-ptrace
 TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	rdvl-sme rdvl-sve \
 	sve-test \
diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
new file mode 100644
index 000000000000..34dfee0c52af
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 ARM Limited.
+ */
+
+#define _GNU_SOURCE
+#define _POSIX_C_SOURCE 199309L
+
+#include <errno.h>
+#include <getopt.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/epoll.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <asm/hwcap.h>
+
+#include "../../kselftest.h"
+
+#define MAX_VLS 16
+
+struct child_data {
+	char *name, *output;
+	pid_t pid;
+	int stdout;
+	bool output_seen;
+	bool exited;
+	int exit_status;
+};
+
+static int epoll_fd;
+static struct child_data *children;
+static int num_children;
+static bool terminate;
+
+static void drain_output(bool flush);
+
+static int num_processors(void)
+{
+	long nproc = sysconf(_SC_NPROCESSORS_CONF);
+	if (nproc < 0) {
+		perror("Unable to read number of processors\n");
+		exit(EXIT_FAILURE);
+	}
+
+	return nproc;
+}
+
+static void child_start(struct child_data *child, const char *program)
+{
+	int ret, pipefd[2], i;
+	struct epoll_event ev;
+
+	ret = pipe(pipefd);
+	if (ret != 0)
+		ksft_exit_fail_msg("Failed to create stdout pipe: %s (%d)\n",
+				   strerror(errno), errno);
+
+	child->pid = fork();
+	if (child->pid == -1)
+		ksft_exit_fail_msg("fork() failed: %s (%d)\n",
+				   strerror(errno), errno);
+
+	if (!child->pid) {
+		/*
+		 * In child, replace stdout with the pipe, errors to
+		 * stderr from here as kselftest prints to stdout.
+		 */
+		ret = dup2(pipefd[1], 1);
+		if (ret == -1) {
+			fprintf(stderr, "dup2() %d\n", errno);
+			exit(EXIT_FAILURE);
+		}
+
+		/*
+		 * Very dumb mechanism to clean open FDs other than
+		 * stdio. We don't want O_CLOEXEC for the pipes...
+		 */
+		for (i = 3; i < 8192; i++)
+			close(i);
+
+		ret = execl(program, program, NULL);
+		fprintf(stderr, "execl(%s) failed: %d (%s)\n",
+			program, errno, strerror(errno));
+
+		exit(EXIT_FAILURE);
+	} else {
+		/*
+		 * In parent, remember the child and close our copy of the
+		 * write side of stdout.
+		 */
+		close(pipefd[1]);
+		child->stdout = pipefd[0];
+		child->output = NULL;
+		child->exited = false;
+		child->output_seen = false;
+
+		ev.events = EPOLLIN | EPOLLHUP;
+		ev.data.ptr = child;
+
+		ret = epoll_ctl(epoll_fd, EPOLL_CTL_ADD, child->stdout, &ev);
+		if (ret < 0) {
+			ksft_exit_fail_msg("%s EPOLL_CTL_ADD failed: %s (%d)\n",
+					   child->name, strerror(errno), errno);
+		}
+
+		/*
+		 * Keep output flowing during child startup so logs
+		 * are more timely, can help debugging.
+		 */
+		drain_output(false);
+	}
+}
+
+static void child_output(struct child_data *child, uint32_t events,
+			 bool flush)
+{
+	char read_data[1024];
+	char work[1024];
+	int ret, len, cur_work, cur_read;
+
+	if (events & EPOLLIN) {
+		ret = read(child->stdout, read_data, sizeof(read_data));
+		if (ret < 0) {
+			ksft_print_msg("%s: read() failed: %s (%d)\n",
+				       child->name, strerror(errno), errno);
+			return;
+		}
+		len = ret;
+
+		child->output_seen = true;
+
+		/* Pick up any partial read */
+		if (child->output) {
+			strncpy(work, child->output, sizeof(work) - 1);
+			cur_work = strnlen(work, sizeof(work));
+			free(child->output);
+			child->output = NULL;
+		} else {
+			cur_work = 0;
+		}
+
+		cur_read = 0;
+		while (cur_read < len) {
+			work[cur_work] = read_data[cur_read++];
+
+			if (work[cur_work] == '\n') {
+				work[cur_work] = '\0';
+				ksft_print_msg("%s: %s\n", child->name, work);
+				cur_work = 0;
+			} else {
+				cur_work++;
+			}
+		}
+
+		if (cur_work) {
+			work[cur_work] = '\0';
+			ret = asprintf(&child->output, "%s", work);
+			if (ret == -1)
+				ksft_exit_fail_msg("Out of memory\n");
+		}
+	}
+
+	if (events & EPOLLHUP) {
+		close(child->stdout);
+		child->stdout = -1;
+		flush = true;
+	}
+
+	if (flush && child->output) {
+		ksft_print_msg("%s: %s<EOF>\n", child->name, child->output);
+		free(child->output);
+		child->output = NULL;
+	}
+}
+
+static void child_tickle(struct child_data *child)
+{
+	if (child->output_seen && !child->exited)
+		kill(child->pid, SIGUSR2);
+}
+
+static void child_stop(struct child_data *child)
+{
+	if (!child->exited)
+		kill(child->pid, SIGTERM);
+}
+
+static void child_cleanup(struct child_data *child)
+{
+	pid_t ret;
+	int status;
+	bool fail = false;
+
+	if (!child->exited) {
+		do {
+			ret = waitpid(child->pid, &status, 0);
+			if (ret == -1 && errno == EINTR)
+				continue;
+
+			if (ret == -1) {
+				ksft_print_msg("waitpid(%d) failed: %s (%d)\n",
+					       child->pid, strerror(errno),
+					       errno);
+				fail = true;
+				break;
+			}
+		} while (!WIFEXITED(status));
+		child->exit_status = WEXITSTATUS(status);
+	}
+
+	if (!child->output_seen) {
+		ksft_print_msg("%s no output seen\n", child->name);
+		fail = true;
+	}
+
+	if (child->exit_status != 0) {
+		ksft_print_msg("%s exited with error code %d\n",
+			       child->name, child->exit_status);
+		fail = true;
+	}
+
+	ksft_test_result(!fail, "%s\n", child->name);
+}
+
+static void handle_child_signal(int sig, siginfo_t *info, void *context)
+{
+	int i;
+	bool found = false;
+
+	for (i = 0; i < num_children; i++) {
+		if (children[i].pid == info->si_pid) {
+			children[i].exited = true;
+			children[i].exit_status = info->si_status;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		ksft_print_msg("SIGCHILD for unknown PID %d with status %d\n",
+			       info->si_pid, info->si_status);
+}
+
+static void handle_exit_signal(int sig, siginfo_t *info, void *context)
+{
+	int i;
+
+	ksft_print_msg("Got signal, exiting...\n");
+
+	terminate = true;
+
+	/*
+	 * This should be redundant, the main loop should clean up
+	 * after us, but for safety stop everything we can here.
+	 */
+	for (i = 0; i < num_children; i++)
+		child_stop(&children[i]);
+}
+
+static void start_fpsimd(struct child_data *child, int cpu, int copy)
+{
+	int ret;
+
+	child_start(child, "./fpsimd-test");
+
+	ret = asprintf(&child->name, "FPSIMD-%d-%d", cpu, copy);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
+	ksft_print_msg("Started %s\n", child->name);
+}
+
+static void start_sve(struct child_data *child, int vl, int cpu)
+{
+	int ret;
+
+	ret = prctl(PR_SVE_SET_VL, vl | PR_SVE_VL_INHERIT);
+	if (ret < 0)
+		ksft_exit_fail_msg("Failed to set SVE VL %d\n", vl);
+
+	child_start(child, "./sve-test");
+
+	ret = asprintf(&child->name, "SVE-VL-%d-%d", vl, cpu);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
+	ksft_print_msg("Started %s\n", child->name);
+}
+
+static void start_ssve(struct child_data *child, int vl, int cpu)
+{
+	int ret;
+
+	ret = prctl(PR_SME_SET_VL, vl | PR_SME_VL_INHERIT);
+	if (ret < 0)
+		ksft_exit_fail_msg("Failed to set SME VL %d\n", ret);
+
+	child_start(child, "./ssve-test");
+
+	ret = asprintf(&child->name, "SSVE-VL-%d-%d", vl, cpu);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
+	ksft_print_msg("Started %s\n", child->name);
+}
+
+static void start_za(struct child_data *child, int vl, int cpu)
+{
+	int ret;
+
+	ret = prctl(PR_SME_SET_VL, vl | PR_SVE_VL_INHERIT);
+	if (ret < 0)
+		ksft_exit_fail_msg("Failed to set SME VL %d\n", ret);
+
+	child_start(child, "./za-test");
+
+	ret = asprintf(&child->name, "ZA-VL-%d-%d", vl, cpu);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
+	ksft_print_msg("Started %s\n", child->name);
+}
+
+static void probe_vls(int vls[], int *vl_count, int set_vl)
+{
+	unsigned int vq;
+	int vl;
+
+	*vl_count = 0;
+
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(set_vl, vq * 16);
+		if (vl == -1)
+			ksft_exit_fail_msg("SET_VL failed: %s (%d)\n",
+					   strerror(errno), errno);
+
+		vl &= PR_SVE_VL_LEN_MASK;
+
+		vq = sve_vq_from_vl(vl);
+
+		vls[*vl_count] = vl;
+		*vl_count += 1;
+	}
+}
+
+/* Handle any pending output without blocking */
+static void drain_output(bool flush)
+{
+	struct epoll_event ev;
+	int ret = 1;
+
+	while (ret > 0) {
+		ret = epoll_wait(epoll_fd, &ev, 1, 0);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			ksft_print_msg("epoll_wait() failed: %s (%d)\n",
+				       strerror(errno), errno);
+		}
+
+		if (ret == 1)
+			child_output(ev.data.ptr, ev.events, flush);
+	}
+}
+
+static const struct option options[] = {
+	{ "timeout",	required_argument, NULL, 't' },
+	{ }
+};
+
+int main(int argc, char **argv)
+{
+	int ret;
+	int timeout = 10;
+	int cpus, tests, i, j, c;
+	int sve_vl_count, sme_vl_count, fpsimd_per_cpu;
+	int sve_vls[MAX_VLS], sme_vls[MAX_VLS];
+	struct epoll_event ev;
+	struct sigaction sa;
+
+	while ((c = getopt_long(argc, argv, "t:", options, NULL)) != -1) {
+		switch (c) {
+		case 't':
+			ret = sscanf(optarg, "%d", &timeout);
+			if (ret != 1)
+				ksft_exit_fail_msg("Failed to parse timeout %s\n",
+						   optarg);
+			break;
+		default:
+			ksft_exit_fail_msg("Unknown argument\n");
+		}
+	}
+
+	cpus = num_processors();
+	tests = 0;
+
+	if (getauxval(AT_HWCAP) & HWCAP_SVE) {
+		probe_vls(sve_vls, &sve_vl_count, PR_SVE_SET_VL);
+		tests += sve_vl_count * cpus;
+	} else {
+		sve_vl_count = 0;
+	}
+
+	if (getauxval(AT_HWCAP2) & HWCAP2_SME) {
+		probe_vls(sme_vls, &sme_vl_count, PR_SME_SET_VL);
+		tests += sme_vl_count * cpus * 2;
+	} else {
+		sme_vl_count = 0;
+	}
+
+	/* Force context switching if we only have FPSIMD */
+	if (!sve_vl_count && !sme_vl_count)
+		fpsimd_per_cpu = 2;
+	else
+		fpsimd_per_cpu = 1;
+	tests += cpus * fpsimd_per_cpu;
+
+	ksft_print_header();
+	ksft_set_plan(tests);
+
+	if (timeout > 0)
+		ksft_print_msg("Will run for %ds\n", timeout);
+	else
+		ksft_print_msg("Will run until terminated\n");
+
+	children = calloc(sizeof(*children), tests);
+	if (!children)
+		ksft_exit_fail_msg("Unable to allocate child data\n");
+
+	ret = epoll_create1(EPOLL_CLOEXEC);
+	if (ret < 0)
+		ksft_exit_fail_msg("epoll_create1() failed: %s (%d)\n",
+				   strerror(errno), ret);
+	epoll_fd = ret;
+
+	/* Get signal handers ready before we start any children */
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handle_exit_signal;
+	sa.sa_flags = SA_RESTART | SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	ret = sigaction(SIGINT, &sa, NULL);
+	if (ret < 0)
+		ksft_print_msg("Failed to install SIGINT handler: %s (%d)\n",
+			       strerror(errno), errno);
+	ret = sigaction(SIGTERM, &sa, NULL);
+	if (ret < 0)
+		ksft_print_msg("Failed to install SIGTEM handler: %s (%d)\n",
+			       strerror(errno), errno);
+	sa.sa_sigaction = handle_child_signal;
+	ret = sigaction(SIGCHLD, &sa, NULL);
+	if (ret < 0)
+		ksft_print_msg("Failed to install SIGCHLD handler: %s (%d)\n",
+			       strerror(errno), errno);
+
+	for (i = 0; i < cpus; i++) {
+		for (j = 0; j < fpsimd_per_cpu; j++)
+			start_fpsimd(&children[num_children++], i, j);
+
+		for (j = 0; j < sve_vl_count; j++)
+			start_sve(&children[num_children++], sve_vls[j], i);
+
+		for (j = 0; j < sme_vl_count; j++) {
+			start_ssve(&children[num_children++], sme_vls[j], i);
+			start_za(&children[num_children++], sme_vls[j], i);
+		}
+	}
+
+	for (;;) {
+		/* Did we get a signal asking us to exit? */
+		if (terminate)
+			break;
+
+		/*
+		 * Timeout is counted in seconds with no output, the
+		 * tests print during startup then are silent when
+		 * running so this should ensure they all ran enough
+		 * to install the signal handler, this is especially
+		 * useful in emulation where we will both be slow and
+		 * likely to have a large set of VLs.
+		 */
+		ret = epoll_wait(epoll_fd, &ev, 1, 1000);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			ksft_exit_fail_msg("epoll_wait() failed: %s (%d)\n",
+					   strerror(errno), errno);
+		}
+
+		/* Output? */
+		if (ret == 1) {
+			child_output(ev.data.ptr, ev.events, false);
+			continue;
+		}
+
+		/* Otherwise epoll_wait() timed out */
+
+		for (i = 0; i < num_children; i++)
+			child_tickle(&children[i]);
+
+		/* Negative timeout means run indefinitely */
+		if (timeout < 0)
+			continue;
+		if (--timeout == 0)
+			break;
+	}
+
+	ksft_print_msg("Finishing up...\n");
+
+	for (i = 0; i < tests; i++)
+		child_stop(&children[i]);
+
+	drain_output(false);
+
+	for (i = 0; i < tests; i++)
+		child_cleanup(&children[i]);
+
+	drain_output(true);
+
+	ksft_print_cnts();
+
+	return 0;
+}
-- 
2.30.2

