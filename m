Return-Path: <linux-kselftest+bounces-15597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F2955CBE
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63151F21639
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85C4AECE;
	Sun, 18 Aug 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSc6UKja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BA1B978;
	Sun, 18 Aug 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723987138; cv=none; b=Oj54fgFXY27eS+nTyhVdbYokoYu+THfFeW0/FzzHTiZXMT2yD+Ipa+LKDtSczGDlBOJPKSKh934Uk/0DMwgiKpCNoAEKcaqZD2EoXiIXyQ1N2SWjAIxRlmJJ+CZqRSF3f7ZepaqY7V1swLe6N64yI/88qXdJO+X6buFZmd/BXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723987138; c=relaxed/simple;
	bh=fH0kpLtUOttFyGNx+llSY9Yf0sAa021adABVn3AZlG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOtNRvB089PAvDZ7iKIBwK49VrDDl5D6EsndZ7J4TcLnLDEmVWTtUOgxOBTgV8W6ykKIOZBlVKcJFw0ohMbvbCvocNz/uFVW4FdqzPbxTCF/Y1ChjD0MFzNkYxLIF9nisLExzgqSQi5pYN7EwidG5xbnoOU7cRkTmTB6J+UqEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSc6UKja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD3CC32786;
	Sun, 18 Aug 2024 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723987137;
	bh=fH0kpLtUOttFyGNx+llSY9Yf0sAa021adABVn3AZlG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSc6UKjawLkikgx1pojN6BDqvAGZ+dgxo1Dy/E0dtGT/7AN7/nwRHKkx4ak43X9J7
	 40FBhv6ldE0tcqX0j6m744goDIuuJj+VhZe40sWRct/7J7Qa5FsVxm/tkzwRKgeyNl
	 ciAaUxJH9xcyBX0HhCTkFYKeZ4evAjP7NN8uKZmUctrrD9IOqyKVrEwjsdw8hIv/Uc
	 9K4sfrERyIfw7MvL1n0sv1F7SiWjviTyxTk6upzaqvzYJR643bafyWm+FiOftTpT/O
	 Dw4GQn6iE/IBn7PkTiGAGMW4b9CePh5htBpmAy7eNirjjpMCSFzcfH/G19uQvqd5b6
	 En+gDMDqV2Mww==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 3/3] selftests/tracing: Add hist poll() support test
Date: Sun, 18 Aug 2024 22:18:53 +0900
Message-Id: <172398713342.295714.14169750905476040792.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172398710447.295714.4489282566285719918.stgit@devnote2>
References: <172398710447.295714.4489282566285719918.stgit@devnote2>
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
 Changes in v5:
  - Update comment about timeout.
 Changes in v4:
  - Use getopt() in poll.c (command options are changed)
  - Update test code according to the new command options.
 Changes in v2:
  - Update poll command to support both of POLLIN and POLLPRI, and timeout.
  - Identify unsupported stable kernel if poll-in returns soon.
  - Test both of POLLIN and POLLPRI.
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


