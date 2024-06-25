Return-Path: <linux-kselftest+bounces-12697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A434B916CDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 17:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D636C1C22C94
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D17176230;
	Tue, 25 Jun 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8nEJ5FV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94D175570;
	Tue, 25 Jun 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328644; cv=none; b=Nk8WNthapoTISKe0qc1Y89VAXSEARa4Vv2XAZQNNXUjqzWUYBCuCCBnNSopIPgIAuZ9C5vm8Vzdv2VkkIqYWcoHwVNcHq7v+gG1E0Mnw3geXk1g0ackfBaQ57CaHyUAnN98UTdvSFbid5Bw5ZS7MHT2kPMIA0hSs0q+BE5tMbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328644; c=relaxed/simple;
	bh=pB4FB/igmk8EJqUlCRjX0n+041AXKCqYYycE3U3JBVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yefw61c+FYIrkQejDVySLUZsFS5E/ZYq/dbQ8XnbgfH9XJcyib+tUZo+fJ0SAj6zU4h07RF9WP9mwzXlX3PiUX+To0cz62h8UgFSoTwhTTDOoI2jDqOUVyE55qXHg6b5ydhozm+CE4wBvb7MXaYNWP+hOwuunWzUXv6XLpdxpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8nEJ5FV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BB0C32781;
	Tue, 25 Jun 2024 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719328644;
	bh=pB4FB/igmk8EJqUlCRjX0n+041AXKCqYYycE3U3JBVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8nEJ5FV7NXmyeeQ2gq9/LjfH/OFhTk5m0LgPjZIkb7LiyMb330/axgp0Ts7ldFHl
	 W0UxgLoHIylziRjEpNNPhPtQvRCniaLuNk8ND0ftw3OK7JCDe6O5obvmD+Lwdams8S
	 twvYesUDbV+Kr6P5FUBWC3ZfEbiI2PHHZJi7LoJz1koSmdQF1FuuqAr+n0lrkTQ278
	 R9iUBqE6N7sKPOC8ks9gSyBUy5Gz7cpyqAL+VXXtSUdrdw5wfuB4gMZ3n1NhbjcVzW
	 3SmpmaIYBX3ev7I5J24Zm+E0es7j43ECECWfkeriO/5MZevDR+8Y7+emXJEGayAzfq
	 7294LZoHeU6Sg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 3/3] selftests/tracing: Add hist poll() support test
Date: Wed, 26 Jun 2024 00:17:20 +0900
Message-Id: <171932864022.584123.13092042198625511966.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171932861260.584123.15653284949837094747.stgit@devnote2>
References: <171932861260.584123.15653284949837094747.stgit@devnote2>
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
 tools/testing/selftests/ftrace/Makefile            |    3 +
 tools/testing/selftests/ftrace/poll.c              |   34 +++++++++++++++
 .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   46 ++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/poll.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc

diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index a1e955d2de4c..830b2299ea27 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -6,4 +6,7 @@ TEST_PROGS := ftracetest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
+LDFLAGS += -static
+TEST_GEN_PROGS = poll
+
 include ../lib.mk
diff --git a/tools/testing/selftests/ftrace/poll.c b/tools/testing/selftests/ftrace/poll.c
new file mode 100644
index 000000000000..800d1114629c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/poll.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple poll on a file.
+ *
+ * Copyright (c) 2024 Google LLC.
+ */
+
+#include <fcntl.h>
+#include <poll.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#define BUFSIZE 4096
+
+int main(int argc, char *argv[])
+{
+	struct pollfd pfd = {.events = POLLPRI};
+	char buf[BUFSIZE];
+
+	if (argc < 2)
+		return -1;
+	pfd.fd = open(argv[1], O_RDONLY);
+	if (pfd.fd < 0) {
+		perror("open");
+		return -1;
+	}
+
+	if (poll(&pfd, 1, -1) < 0) {
+		perror("poll");
+		return -1;
+	}
+	close(pfd.fd);
+	return 0;
+}
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
new file mode 100644
index 000000000000..ac3999dee40b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
@@ -0,0 +1,46 @@
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
+echo "hist:key=comm" > ${EVENT}/trigger
+echo 1 > ${EVENT}/enable
+
+# setting timeout
+PID=$$
+SIG_FAIL=37
+trap exit_fail $SIG_FAIL
+sleep 10 && (kill -s ${SIG_FAIL} ${PID} ||:) &
+TOPID=$!
+
+# sleep command will exit after 2 seconds
+sleep 2 &
+BGPID=$!
+${POLL} ${EVENT}/hist
+# stop timeout
+kill -KILL ${TOPID} ||:
+
+cat trace > ${TMPDIR}/trace
+
+if [ -d /proc/${BGPID} ]; then
+  echo "poll exits too soon"
+  kill -KILL ${BGPID} ||:
+  exit_fail
+fi
+
+if ! grep -qw "sleep" ${TMPDIR}/trace; then
+  echo "poll exits before event happens"
+  exit_fail
+fi
+
+exit_pass


