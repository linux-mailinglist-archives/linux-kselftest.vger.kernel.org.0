Return-Path: <linux-kselftest+bounces-13107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D46F925300
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 07:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8651F26FEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 05:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490905027F;
	Wed,  3 Jul 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmN8nv6G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B561FD4;
	Wed,  3 Jul 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984784; cv=none; b=uRTzLcCRtS/UUXPWRmWZcGa/zf+6bwMpZKWF7q2IpqoBuy1y44WgquXpLlxGWc6K2dOxGcDqyzHGXiw02XRodPVHXt2rsSrYXbcDkxUiDB0eiq8DmEEs9Ajdfm1a5qHjJXmusjG4DlTSCeHhgEiGltDVgjsiFScJmKXCjhsWmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984784; c=relaxed/simple;
	bh=qMUrvkxecOx/v3yAVcd4bfohhjch6A/wjtM7rqSvV/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q72NAyPYEEn3k/18kOMniJU9vEB7SU4g2Dt+WpFtjlFOGochgLdonzx1ja9B1CIPDobZAj2NH/poeXLFOztIbQVV28qI+9KG21N/cTpPWGKAWXJy9Us0nAzmJ6qG184qjrLU2zZy3l/WPo/3e+3xOf4fpDxybon1O+1u8gyznDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmN8nv6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17BEC32781;
	Wed,  3 Jul 2024 05:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719984783;
	bh=qMUrvkxecOx/v3yAVcd4bfohhjch6A/wjtM7rqSvV/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmN8nv6GXyGbXfjwXwc48AHyl38EgSsWzC9dgCS9wYpXax6U4pS5QDd6lUd22jRTV
	 hJgOaGyrvV2f9AZFzd2reezTb00n5gEdwSx+8zwRJeEeQu+bkDDZtH/j0WMEM3udzN
	 k7ojdCv4DQPEzb7Pk3utvYNPmvCDLyn1zPDbaI+NF/AJoVvT51WNTK3BKF4brWdZg+
	 cEEOvKfQPDxWCYNbTwxaWMZ2/lY5kaErdr0Pav2ECGIkYChEvLw1aZbzYmV7zCKtna
	 4/0u8XFLoaRLUUafh/3liWYctMoE773XA4t3bEKq9Hdl/e4wQemBUJiXAOYdXpp7kv
	 kGqVH/Tbnk2Mw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/3] selftests/tracing: Add hist poll() support test
Date: Wed,  3 Jul 2024 14:33:00 +0900
Message-Id: <171998477999.54594.16011632695593086016.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171998475175.54594.7244942110355338359.stgit@devnote2>
References: <171998475175.54594.7244942110355338359.stgit@devnote2>
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


