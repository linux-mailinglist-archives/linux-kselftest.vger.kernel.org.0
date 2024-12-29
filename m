Return-Path: <linux-kselftest+bounces-23781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876F39FDEF7
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Dec 2024 14:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A78416166D
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Dec 2024 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604BE157E88;
	Sun, 29 Dec 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Min7WSts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BF586324;
	Sun, 29 Dec 2024 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735478684; cv=none; b=MYOTQQrvb1QKmc9d35G6taIr55au27OQsgyHqO1vRg6Zkc6ftVx98d6uSl9MVraOXcqOP0awNBZyFoDQ8wVK8yr78u56lNgSVwsftAa4lb5uDRYMbVOAPpmfab4ncPMHrwwN+4LR7HR8ainAuliBJEPWDtV2qr2O+o1uW6082GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735478684; c=relaxed/simple;
	bh=DXMckv7uN/qfJfpaK+Frhfkm6EEO/Jkx8V9vMAfQro0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXOhZ5bqbVdFmcV79tN+R1KOS0v62QJ+ynUod0d6bjehHOjdy3IvfaoLPIurD9gCp7bjgBNj7DU56YoA5BHYSGGl/pC8nLBPyzu0rxoGe07Ulu/LoHzHcc4+OVP4BwWCMjg3l5GnWIZeC77lMyT8TY3mLX75Dwa2iUOpCuWrB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Min7WSts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E27C4CED1;
	Sun, 29 Dec 2024 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735478683;
	bh=DXMckv7uN/qfJfpaK+Frhfkm6EEO/Jkx8V9vMAfQro0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Min7WStssgb1KtkCISVNRd2dH9bNd2Up42toSaQlqabT3YIRIBrth39ov5JrHdgH/
	 P4FYvMfWOIwZaAZu/+VKeEnsTrWpm/UfZ6B5RBiQk0ReJSAYkhzkV+pCQ7rj4DQ7CE
	 /rweVXKa7ri7J/kOYrPpPhPnuqu7AcDrIWiS5LQaY9uVxm3RR+XsVRdpIFsZ2/G2yH
	 OIxEeXTGT/liNDA0UHzQaRfKxGFQwj2iSPfp47i1TjyKrvEaEdL7OXXQCNCJVxb+Fa
	 AQnnxnXDXzio489b2YtO4CplgqbL4FknNPYSGHJViHerJYaL5HYFuRI64qjuJg33U0
	 8IkS0fXLaDQ6Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7.1 3/3] selftests/tracing: Add hist poll() support test
Date: Sun, 29 Dec 2024 22:24:39 +0900
Message-ID: <173547867935.569911.10127126796879854182.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173527249794.464571.10924229554900263368.stgit@devnote2>
References: <173527249794.464571.10924229554900263368.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a testcase for poll() on hist file. This introduces a helper binary
to the ftracetest, because there is no good way to reliably execute
poll() on hist file.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Changes in v7:
  - Add comm histogram filter for specifying test sleep command.
---
 tools/testing/selftests/ftrace/Makefile            |    2 +
 tools/testing/selftests/ftrace/poll.c              |   74 ++++++++++++++++++++
 .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   74 ++++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/poll.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc

diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index a1e955d2de4c..49d96bb16355 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -6,4 +6,6 @@ TEST_PROGS := ftracetest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
+TEST_GEN_PROGS = poll
+
 include ../lib.mk
diff --git a/tools/testing/selftests/ftrace/poll.c b/tools/testing/selftests/ftrace/poll.c
new file mode 100644
index 000000000000..53258f7515e7
--- /dev/null
+++ b/tools/testing/selftests/ftrace/poll.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple poll on a file.
+ *
+ * Copyright (c) 2024 Google LLC.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#define BUFSIZE 4096
+
+/*
+ * Usage:
+ *  poll [-I|-P] [-t timeout] FILE
+ */
+int main(int argc, char *argv[])
+{
+	struct pollfd pfd = {.events = POLLIN};
+	char buf[BUFSIZE];
+	int timeout = -1;
+	int ret, opt;
+
+	while ((opt = getopt(argc, argv, "IPt:")) != -1) {
+		switch (opt) {
+		case 'I':
+			pfd.events = POLLIN;
+			break;
+		case 'P':
+			pfd.events = POLLPRI;
+			break;
+		case 't':
+			timeout = atoi(optarg);
+			break;
+		default:
+			fprintf(stderr, "Usage: %s [-I|-P] [-t timeout] FILE\n",
+				argv[0]);
+			return -1;
+		}
+	}
+	if (optind >= argc) {
+		fprintf(stderr, "Error: Polling file is not specified\n");
+		return -1;
+	}
+
+	pfd.fd = open(argv[optind], O_RDONLY);
+	if (pfd.fd < 0) {
+		fprintf(stderr, "failed to open %s", argv[optind]);
+		perror("open");
+		return -1;
+	}
+
+	/* Reset poll by read if POLLIN is specified. */
+	if (pfd.events & POLLIN)
+		do {} while (read(pfd.fd, buf, BUFSIZE) == BUFSIZE);
+
+	ret = poll(&pfd, 1, timeout);
+	if (ret < 0 && errno != EINTR) {
+		perror("poll");
+		return -1;
+	}
+	close(pfd.fd);
+
+	/* If timeout happned (ret == 0), exit code is 1 */
+	if (ret == 0)
+		return 1;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
new file mode 100644
index 000000000000..8d275e3238d9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
@@ -0,0 +1,74 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test poll wait on histogram
+# requires: set_event events/sched/sched_process_free/trigger events/sched/sched_process_free/hist
+# flags: instance
+
+POLL=${FTRACETEST_ROOT}/poll
+
+if [ ! -x ${POLL} ]; then
+  echo "poll program is not compiled!"
+  exit_unresolved
+fi
+
+EVENT=events/sched/sched_process_free/
+
+# Check poll ops is supported. Before implementing poll on hist file, it
+# returns soon with POLLIN | POLLOUT, but not POLLPRI.
+
+# This must wait >1 sec and return 1 (timeout).
+set +e
+${POLL} -I -t 1000 ${EVENT}/hist
+ret=$?
+set -e
+if [ ${ret} != 1 ]; then
+  echo "poll on hist file is not supported"
+  exit_unsupported
+fi
+
+# Test POLLIN
+echo > trace
+echo 'hist:key=comm if comm =="sleep"' > ${EVENT}/trigger
+echo 1 > ${EVENT}/enable
+
+# This sleep command will exit after 2 seconds.
+sleep 2 &
+BGPID=$!
+# if timeout happens, poll returns 1.
+${POLL} -I -t 4000 ${EVENT}/hist
+echo 0 > tracing_on
+
+if [ -d /proc/${BGPID} ]; then
+  echo "poll exits too soon"
+  kill -KILL ${BGPID} ||:
+  exit_fail
+fi
+
+if ! grep -qw "sleep" trace; then
+  echo "poll exits before event happens"
+  exit_fail
+fi
+
+# Test POLLPRI
+echo > trace
+echo 1 > tracing_on
+
+# This sleep command will exit after 2 seconds.
+sleep 2 &
+BGPID=$!
+# if timeout happens, poll returns 1.
+${POLL} -P -t 4000 ${EVENT}/hist
+echo 0 > tracing_on
+
+if [ -d /proc/${BGPID} ]; then
+  echo "poll exits too soon"
+  kill -KILL ${BGPID} ||:
+  exit_fail
+fi
+
+if ! grep -qw "sleep" trace; then
+  echo "poll exits before event happens"
+  exit_fail
+fi
+
+exit_pass


