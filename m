Return-Path: <linux-kselftest+bounces-11090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044818D736A
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 05:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4EF1F221C0
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0FA45948;
	Sun,  2 Jun 2024 03:37:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB944376;
	Sun,  2 Jun 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299448; cv=none; b=F8WJJH+j89dDlJEYk9W02UK1GPsCXpXYsErR+tyG5zEQREdAGToLGAMh0zcMvoY/N4SFfAVyD4eQqUkcLRbgWTMkgWO5IBdlHIATsDzv6UUPKZerVYH43EekbUfTZXSevq6gfPpaJnrDlNSSJv5Xc7qJevHzsCdIuc0TgDt2URU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299448; c=relaxed/simple;
	bh=IBvQ1EjeHUmg4YeF3oXh/rA5/gT95qKmM3/sG7PAKSE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aX3V3RCOSHOG9zZKpgXalzi/fhG7YjCwUTFXdHCGxK5mTlivU/zAIjB3mak8S60eM6apKpKA1H3wPFfYUaWUaMqRcRagRBPsWwva+OrXQE4yfeHsOHuI7XoyVNsMTFi7BZNMQ6URQ7m08za4zbUumm+m8FG9/f8cSjrcnhS3mGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545C6C4AF09;
	Sun,  2 Jun 2024 03:37:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3H-000000094WR-2fw7;
	Sat, 01 Jun 2024 23:38:35 -0400
Message-ID: <20240602033835.489585837@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:38:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v2 27/27] selftests/ftrace: Add fgraph-multi.tc test
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a test that creates 3 instances and enables function_graph tracer in
each as well as the top instance, where each will enable a filter (but one
that traces all functions) and check that they are filtering properly.

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/ftrace/fgraph-multi.tc      | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
new file mode 100644
index 000000000000..ff88f97e41fb
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
@@ -0,0 +1,103 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function graph filters
+# requires: set_ftrace_filter function_graph:tracer
+
+# Make sure that function graph filtering works
+
+INSTANCE1="instances/test1_$$"
+INSTANCE2="instances/test2_$$"
+INSTANCE3="instances/test3_$$"
+
+WD=`pwd`
+
+do_reset() {
+    cd $WD
+    if [ -d $INSTANCE1 ]; then
+	echo nop > $INSTANCE1/current_tracer
+	rmdir $INSTANCE1
+    fi
+    if [ -d $INSTANCE2 ]; then
+	echo nop > $INSTANCE2/current_tracer
+	rmdir $INSTANCE2
+    fi
+    if [ -d $INSTANCE3 ]; then
+	echo nop > $INSTANCE3/current_tracer
+	rmdir $INSTANCE3
+    fi
+}
+
+mkdir $INSTANCE1
+if ! grep -q function_graph $INSTANCE1/available_tracers; then
+    echo "function_graph not allowed with instances"
+    rmdir $INSTANCE1
+    exit_unsupported
+fi
+
+mkdir $INSTANCE2
+mkdir $INSTANCE3
+
+fail() { # msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+disable_tracing
+clear_trace
+
+do_test() {
+    REGEX=$1
+    TEST=$2
+
+    # filter something, schedule is always good
+    if ! echo "$REGEX" > set_ftrace_filter; then
+	fail "can not enable filter $REGEX"
+    fi
+
+    echo > trace
+    echo function_graph > current_tracer
+    enable_tracing
+    sleep 1
+    # search for functions (has "{" or ";" on the line)
+    echo 0 > tracing_on
+    count=`cat trace | grep -v '^#' | grep -e '{' -e ';' | grep -v "$TEST" | wc -l`
+    echo 1 > tracing_on
+    if [ $count -ne 0 ]; then
+	fail "Graph filtering not working by itself against $TEST?"
+    fi
+
+    # Make sure we did find something
+    echo 0 > tracing_on
+    count=`cat trace | grep -v '^#' | grep -e '{' -e ';' | grep "$TEST" | wc -l`
+    echo 1 > tracing_on
+    if [ $count -eq 0 ]; then
+	fail "No traces found with $TEST?"
+    fi
+}
+
+do_test '*sched*' 'sched'
+cd $INSTANCE1
+do_test '*lock*' 'lock'
+cd $WD
+cd $INSTANCE2
+do_test '*rcu*' 'rcu'
+cd $WD
+cd $INSTANCE3
+echo function_graph > current_tracer
+
+sleep 1
+count=`cat trace | grep -v '^#' | grep -e '{' -e ';' | grep "$TEST" | wc -l`
+if [ $count -eq 0 ]; then
+    fail "No traces found with all tracing?"
+fi
+
+cd $WD
+echo nop > current_tracer
+echo nop > $INSTANCE1/current_tracer
+echo nop > $INSTANCE2/current_tracer
+echo nop > $INSTANCE3/current_tracer
+
+do_reset
+
+exit 0
-- 
2.43.0



