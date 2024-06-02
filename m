Return-Path: <linux-kselftest+bounces-11089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09CD8D7365
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 05:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB901C212C1
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 03:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2C42AA4;
	Sun,  2 Jun 2024 03:37:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAE4086A;
	Sun,  2 Jun 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299448; cv=none; b=b5lnbb7tLNE9h8dyX3D5nBVTXP0zSerySxDMPRhseNaVD+2R0lseYUWAmJE0pdQmcgO8YY/84RqicVW5B6pnTBb1WSWtf3sz63J4xeK4O0O/dCePbByjHjjM80ByMdEOxtXePcrQkMuVk/3CHH0e8PyfR6QkGoVXf/a6BOp6KGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299448; c=relaxed/simple;
	bh=SitV4QfbSbiGZH0OuJ+lv+tss/ApiEzmsvTb29VB5DM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GgK8p0PkuS3wUvqR4VYV+B/HFgri2/QutjOmqv36BIg4xIFKpuP3zUUyIeLc0BoPejiymc6Qkw9LPIJD1Ud/IHBE6vtrTor3wsQvUTCLMNpUiHAIwyF6CISsiVgdIGIUVKZ8vty6ZEimMMEGZSXJ6ggX7NCK8zzXl4PV852C79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCECC4AF0D;
	Sun,  2 Jun 2024 03:37:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3H-000000094Vx-1xgM;
	Sat, 01 Jun 2024 23:38:35 -0400
Message-ID: <20240602033835.323438089@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:38:10 -0400
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
Subject: [PATCH v2 26/27] selftests/ftrace: Add function_graph tracer to func-filter-pid test
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function tracer is tested to see if pid filtering works. Add a test to
test function_graph tracer as well, but only if the function_graph tracer
is enabled for the top level or instance.

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/ftrace/func-filter-pid.tc   | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 2f7211254529..c6fc9d31a496 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -14,6 +14,11 @@ if [ ! -f options/function-fork ]; then
     echo "no option for function-fork found. Option will not be tested."
 fi
 
+if [ ! -f options/funcgraph-proc ]; then
+    do_funcgraph_proc=0
+    echo "no option for function-fork found. Option will not be tested."
+fi
+
 read PID _ < /proc/self/stat
 
 if [ $do_function_fork -eq 1 ]; then
@@ -21,12 +26,18 @@ if [ $do_function_fork -eq 1 ]; then
     orig_value=`grep function-fork trace_options`
 fi
 
+if [ $do_funcgraph_proc -eq 1 ]; then
+    orig_value2=`cat options/funcgraph-proc`
+fi
+
 do_reset() {
-    if [ $do_function_fork -eq 0 ]; then
-	return
+    if [ $do_function_fork -eq 1 ]; then
+	echo $orig_value > trace_options
     fi
 
-    echo $orig_value > trace_options
+    if [ $do_funcgraph_proc -eq 1 ]; then
+	echo $orig_value2 > options/funcgraph-proc
+    fi
 }
 
 fail() { # msg
@@ -36,13 +47,15 @@ fail() { # msg
 }
 
 do_test() {
+    TRACER=$1
+
     disable_tracing
 
     echo do_execve* > set_ftrace_filter
     echo $FUNCTION_FORK >> set_ftrace_filter
 
     echo $PID > set_ftrace_pid
-    echo function > current_tracer
+    echo $TRACER > current_tracer
 
     if [ $do_function_fork -eq 1 ]; then
 	# don't allow children to be traced
@@ -82,7 +95,11 @@ do_test() {
     fi
 }
 
-do_test
+do_test function
+if grep -s function_graph available_tracers; then
+    do_test function_graph
+fi
+
 do_reset
 
 exit 0
-- 
2.43.0



