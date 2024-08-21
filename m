Return-Path: <linux-kselftest+bounces-15903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D674695A513
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828101F243C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780616DEB5;
	Wed, 21 Aug 2024 19:08:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2915C12B;
	Wed, 21 Aug 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267315; cv=none; b=JhsbfZsAKtespCrEojtQt+9f5oZIDXfNDTKLzZsvrCPnmEu2/3kyu01eG4Nfp13DI2ztRfEpKWLjlG+cK2ZadgBr31uUB3qm3CAE6BzPe8mK+Ek0sDzLpEYnPyt8teFyi2VS/AjV4Yp1yTp/QrHDdbh+bdc0tT1gifi4ml88lLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267315; c=relaxed/simple;
	bh=XzCjK3bq3OKpZpPX48+0Xsq05rEKNphEmNWIlaujLbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SHbWRpJEUR+yuQBCJkZwlXFqRAZlf/mteXqkiElStjFcC3WTEjP7K7CUy8DkD2Rn6SaDSiQ0eBIMeH9mpV7qFJnpnGCSosFC+Bw/6R/54oKKnbwuLOKdInGzdS9S9qEyIyVlaJ3E/Z2Ykyj9p0tw2aXmCpJOsmRueQtR7+X2/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A034C32781;
	Wed, 21 Aug 2024 19:08:34 +0000 (UTC)
Date: Wed, 21 Aug 2024 15:09:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH] ftrace/selftest: Test combination of function_graph tracer
 and function profiler
Message-ID: <20240821150903.05c6cf96@gandalf.local.home>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
new file mode 100644
index 000000000000..62d44a1395da
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
@@ -0,0 +1,30 @@
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
+# We need function_graph and profiling to to run this test
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
+sleep 1
+
+exit 0
-- 
2.43.0


