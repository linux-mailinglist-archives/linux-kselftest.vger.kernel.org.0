Return-Path: <linux-kselftest+bounces-19061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6D990F61
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 21:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AB81F22F01
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7641DD9A1;
	Fri,  4 Oct 2024 18:55:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB641CACF7;
	Fri,  4 Oct 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068125; cv=none; b=auTqUbIDq/8YNE31BtgR6q7OdkKqIfLpEwvN7K+Wg2Ypfhl/7DCrXmIcwfFk0FpiSM5ocN4OOgGa5fpywp8e9/yg2C2b4BBeOmq3VxCtelUv3UDZxyHDMCJhgECkSwOuFb1NqaNj5XUYTEmsBEUfxFAQEiOj1FBLh4imbhpbzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068125; c=relaxed/simple;
	bh=Rqi4i0Q52MITi79rvy0yX36+1lr+tW5PzSpWyB7kXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hyNG2LxAysd2oxmY88pa4F6jlOBaWXCt7fuG7fmudkYiCnn0sy8eQGrrXP6F9yOzvmvFQgZ1UpqgahkJ1jEeZRwNYnDyJD5jHE7vPKVVviFJiiyFRlPLX41QmK126SRqIWvvKsv8WKhTy8ZDqNrcgtHjiq0alax0h53VV2eiZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C60FC4CECD;
	Fri,  4 Oct 2024 18:55:22 +0000 (UTC)
Date: Fri, 4 Oct 2024 14:56:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v2] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
Message-ID: <20241004145618.18436d7e@gandalf.local.home>
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
Changes since v1: https://lore.kernel.org/20240821150903.05c6cf96@gandalf.local.home

- Added comment to why we are doing a sleep 1

- Now that the fix is in mainline, we can add this to the selftests

 .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
new file mode 100644
index 000000000000..1580e4ef9739
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
+# Let it run for a bit to make sure nothing explodes
+sleep 1
+
+exit 0
-- 
2.45.2


