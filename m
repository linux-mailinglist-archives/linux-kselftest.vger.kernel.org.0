Return-Path: <linux-kselftest+bounces-15287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A99510ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 02:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B48B20F70
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 00:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12DD197;
	Wed, 14 Aug 2024 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnG9KMjJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598F8460;
	Wed, 14 Aug 2024 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594307; cv=none; b=oWOH8CCfRO5AT3iQf49uchQjLlgkrqu4vQVY2nHcIBQ513JV3eA2rjk1Ay5UX07A9NGPXCwagr+R1kdw6XD33u2fVCHLURR99JYw5eknGHVrpsQG1DHOtxIA5RoDVs0YC6kW0ddNUFlEq1mrA1sLUtnY7RlIgRfnxkIwmvmdCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594307; c=relaxed/simple;
	bh=qMUrvkxecOx/v3yAVcd4bfohhjch6A/wjtM7rqSvV/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OE6nAyluyv6OaF04ED7ZJkLTpUmVQGcQjVP3daTdzfWBART+PRBMjybOB74y+Y4B0dKFefV8KUhv+MSOtAt8Z+Kq5f9bwQ5/sKJqwaKd8kyn2wl5VGrCjbLVzR3LNF1RvcOfJVrAIsm4yd3aTCaSds43UeT0UL721X1KuBeyiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnG9KMjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A123DC32782;
	Wed, 14 Aug 2024 00:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723594307;
	bh=qMUrvkxecOx/v3yAVcd4bfohhjch6A/wjtM7rqSvV/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnG9KMjJ42Oc4ohmoc45h9to5g8LhrCZUah5TyAFfAyVVXNtHVR/TSnYqddsfCKdd
	 ayS5izpO2Y9lUysZO8+5stYd3JmImH5yatDY4Q1IcPOdEXw9k4CArycy2KFp2mJ+Xv
	 Max0JENKQWPyhkuhQGZ/hyraIEmPKSZSfudjtOqcoela64fLx6CYQ79rYjwFPfzbZT
	 QzVTOFrFiUGhw1r4XYKlYuZGYOJuWWXzRz0tzDRGGpfOVjzn0h0fGmb7MhQQZ0eTfj
	 vGjpMpaUzZvqMN3namnzgQg0zVotiQXnpQCqY0nVnrcPuTyhccnhOOzsk7V9l/Y7Ed
	 lJNfMDeda2r0Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/3] selftests/tracing: Add hist poll() support test
Date: Wed, 14 Aug 2024 09:11:43 +0900
Message-Id: <172359430351.323666.9768554440535494357.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172359427367.323666.6446548762874507863.stgit@devnote2>
References: <172359427367.323666.6446548762874507863.stgit@devnote2>
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
---
 Changes in v2:
  - Update poll command to support both of POLLIN and POLLPRI, and timeout.
  - Identify unsupported stable kernel if poll-in returns soon.
  - Test both of POLLIN and POLLPRI.
---
 tools/testing/selftests/ftrace/Makefile            |    2 +
 tools/testing/selftests/ftrace/poll.c              |   62 +++++++++++++++++
 .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   74 ++++++++++++++++++++
 3 files changed, 138 insertions(+)
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
index 000000000000..8003a59fe042
--- /dev/null
+++ b/tools/testing/selftests/ftrace/poll.c
@@ -0,0 +1,62 @@
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
+ *  poll <in|pri> <FILE> [timeout]
+ */
+int main(int argc, char *argv[])
+{
+	struct pollfd pfd;
+	char buf[BUFSIZE];
+	int timeout = -1;
+	int ret;
+
+	if (argc < 3)
+		return -1;
+
+	if (!strcmp(argv[1], "in"))
+		pfd.events = POLLIN;
+	else if (!strcmp(argv[1], "pri"))
+		pfd.events = POLLPRI;
+
+	pfd.fd = open(argv[2], O_RDONLY);
+	if (pfd.fd < 0) {
+		perror("open");
+		return -1;
+	}
+
+	if (argc == 4)
+		timeout = atoi(argv[3]);
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
+	/* If timeout happned, return code is 0 */
+	if (ret == 0)
+		return 1;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
new file mode 100644
index 000000000000..53bea74e2234
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
+${POLL} in ${EVENT}/hist 1000
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
+${POLL} in ${EVENT}/hist 4000
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
+${POLL} pri ${EVENT}/hist 4000
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


