Return-Path: <linux-kselftest+bounces-19842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB89A07C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37D41C27427
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F672076B5;
	Wed, 16 Oct 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StiXan+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE87206042;
	Wed, 16 Oct 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075786; cv=none; b=A6UnxLLNh2OKDL3D5nUWxAqFk8EAaZORjMejKvjgtg8xppdpHVgO85UufE5bzKq7QXqmklxH/kWXZE5id+/ts+fSd/186JyTGPEGEmgjW7a+3I38pHHGqErCvrmd/DENz696xhxHnV/EpzGYe3u81WOsDQ/0ECwxSY0tVNpqz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075786; c=relaxed/simple;
	bh=6HwES/3dQX1Ql/jIAJ4yIyDJImUeIDOzvfdnUqOyLvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftUf1/PK65VfdVOTotWYVQxgC0Dsk0Ebs2LTmg8gZW7SfvJnhnqWhETVa5nfgd6MT9XDm0Qbeie9MaZnQ2lOMzVZE/IEB+pOR5owTOn8OtcoNbkk/ytveW5s6BzTsosrl6BpM9rU1y1o9vmKJyWQ3Cm+ZXKicnw92g+Xusp2rBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StiXan+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3283CC4CECD;
	Wed, 16 Oct 2024 10:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729075785;
	bh=6HwES/3dQX1Ql/jIAJ4yIyDJImUeIDOzvfdnUqOyLvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StiXan+U4q/d0bgYYFdd+C96ZmZYmLrMzUsyQ3O67sJ5tCkyx6zp/DPH04S5gmjZv
	 xhx7xX1xB0KhPIZ0WVuXMFTVIvar76hH55blCPZpEsLCEMO4hhEyRHbQ/+J/2At2sZ
	 B3/IN4CuV5e2pChDK1sJQus6309Tt5gNQKaG+3p8SH/L4XfVs0L7NotLCK049zI8Eu
	 JQfvSgn0CwEPI5ww/8XHtb/vF17g+QokbWLjKEqa6hQ1lTp9n4LtvIYnc6f3WoF+v4
	 dwF0TJv37bn+Vb6/EA+9jYSF2QUBCYDigDhlcjSufvNw48RfpC+jgqqkGf+Xl2fDsW
	 DN52xPVLPVRiw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 3/3] selftests/tracing: Add hist poll() support test
Date: Wed, 16 Oct 2024 19:49:41 +0900
Message-ID:  <172907578159.470540.12276069200453397317.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To:  <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
References:  <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
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


