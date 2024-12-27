Return-Path: <linux-kselftest+bounces-23768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6769FD004
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 05:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEEC1880649
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 04:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FEE487A5;
	Fri, 27 Dec 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlR/Vp6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963912BF24;
	Fri, 27 Dec 2024 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735272503; cv=none; b=S9rZm7OACz3qimGui5S8AwTw1odWAevwPV2HDoKx/UKM/Bl41EbbwxWOMkzTy9AWqjGvj6BZrXK1E+Y2n3F5nqHWPftwhpp4Xwn9XCcXhdjR/7KzZewnykWL5RFMc3wq9FgKA2ol4jfkUEedBHcTz9xoXYNxzKFDvn8ZsxTj0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735272503; c=relaxed/simple;
	bh=TLRRJpSlyRF7o1BYWCZ2PSNtTMR3NYJ6wwaKz5Sm11U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfOS4hM+TzLjUP2HujiPpNzoCRMEO6U2uZCxnQuppFwIbCjQIvq5TOHcsIKlDhZsX0OEh/6FHsVl5MjL+C51M62D2v2CkHMsz+fJLC6mIKoWI0JJX6vEZ+52V50WbdQjXeRq1hcoJwtn07moZVF5KsLiHCc5SuVWFnYeZE6WXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlR/Vp6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E89C4CED0;
	Fri, 27 Dec 2024 04:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735272502;
	bh=TLRRJpSlyRF7o1BYWCZ2PSNtTMR3NYJ6wwaKz5Sm11U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SlR/Vp6uFIdGZOQMAAxMqvIgDR47DO1tJ6UXASnBzeFDqqmzgCtYPbjn1TJf0QvcD
	 GLu0EYOTDUi8vUo3AUGpM550NWcRWZZf4atsQ+tqiqqf5nlJf3K2j/xB0MxsTNnfoq
	 ya2u3qKsAenbNYKixMDZQ/XD5dndeJGjjqgPOkJrPu/PVJsqhrymaOZF+NJwOTWOtY
	 /9RCcF+x4UfXo4D48zQkOsW2cvoWn2EJOpWdn26BjWX+zq80yC8HOf4ZvtdWj83oAc
	 iwD908fQqW2N4S/6JukseFPL8feeK1eaxWsYhz3TMn9E6hga9YZUcPWod0iTLTBDpo
	 FHECiZaRWsgPQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 3/3] selftests/tracing: Add hist poll() support test
Date: Fri, 27 Dec 2024 13:08:18 +0900
Message-ID: <173527249794.464571.10924229554900263368.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173527246726.464571.11533527581374142406.stgit@devnote2>
References: <173527246726.464571.11533527581374142406.stgit@devnote2>
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
index 000000000000..cbd01a71ecad
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
+echo "hist:key=comm" > ${EVENT}/trigger
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


