Return-Path: <linux-kselftest+bounces-19478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B09993EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 22:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF0A283B78
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD11E1A33;
	Thu, 10 Oct 2024 20:52:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0781CF7B8;
	Thu, 10 Oct 2024 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593548; cv=none; b=KPsSWZSDlhwoj5pjieRj+NSSasSvfSi81rxc+fEMEFm0EC+EVS7p3FruMN6Vk2BYeALkKPCxvRwJ9n7By8ZppdHQ+LDzl7svguln7XG5ynzniqAiCxsi6SIiZKlbqrqtst21nHeQE5f/9egpbCNDqRcpIH8clvtbFa792KBm7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593548; c=relaxed/simple;
	bh=VOLSGxoFpqEKw8p69LGCSzYyDXmPRCffVpLrGBu5v+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JGwNvuZ7Vn2v7XGHvy/hipdJovS4kb0W0LGHI2mmiHsR9saylRUVOlx79C9ynqArFoaOQNNfFcTqU7ZmLDohfShDJBu/ITCok3VvCtuM7sCL1ynEDgqekxC3wrlWh3AndVFeB9JWw6zFpsVSnocayIxgv0d0dsNW2K/lsWO3OOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E1EC4CEC5;
	Thu, 10 Oct 2024 20:52:27 +0000 (UTC)
Date: Thu, 10 Oct 2024 16:52:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
Message-ID: <20241010165235.35122877@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Masami reported a bug when running function graph tracing then the
function profiler. The following commands would cause a kernel crash:

  # cd /sys/kernel/tracing/
  # echo function_graph > current_tracer
  # echo 1 > function_profile_enabled

In that order. Create a test to test this two to make sure this does not
come back as a regression.

Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20241004145618.18436d7e@gandalf.local.home

- Fixed grammar of comment

 .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
new file mode 100644
index 000000000000..ffff8646733c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function profiler with function graph tracing
+# requires: function_profile_enabled set_ftrace_filter function_graph:tracer
+
+# The function graph tracer can now be run along side of the function
+# profiler. But there was a bug that caused the combination of the two
+# to crash. It also required the function graph tracer to be started
+# first.
+#
+# This test triggers that bug
+#
+# We need both function_graph and profiling to run this test
+
+fail() { # mesg
+    echo $1
+    exit_fail
+}
+
+echo "Enabling function graph tracer:"
+echo function_graph > current_tracer
+echo "enable profiler"
+
+# Older kernels do not allow function_profile to be enabled with
+# function graph tracer. If the below fails, mark it as unsupported
+echo 1 > function_profile_enabled || exit_unsupported
+
+# Let it run for a bit to make sure nothing explodes
+sleep 1
+
+exit 0
-- 
2.45.2


